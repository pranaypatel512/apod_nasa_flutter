import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:apod_nasa_flutter/viewmodel/media_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:progressive_image/progressive_image.dart';

import 'media_details.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (_) => MediaViewModel()),
      ],
      child: MaterialApp.router(
        routerConfig: _goRouter,
        title: 'APODNasaFlutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MediaViewModel>(context, listen: false).loadAllMedia();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Consumer<MediaViewModel>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Lottie.network(
                    'https://assets6.lottiefiles.com/packages/lf20_2kHQhR.json'),
              );
            }
            final media = value.mediaItems;
            return ListView.builder(
              itemCount: media.length,
              itemBuilder: (context, index) {
                final mediaItem = media[index];
                return GestureDetector(
                  onTap: () =>
                      {value.selectedItem = mediaItem, context.go("/details")},
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _displayMedia(mediaItem.finalUrl, mediaItem.url),
                          const SizedBox(height: 8.0),
                          Text(
                            mediaItem.title ?? '',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text(
                                  mediaItem.date ?? '',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                  child: Text(
                                mediaItem.copyright != null
                                    ? "©${mediaItem.copyright}"
                                    : "",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

Widget _displayMedia(String? finalUrl, String? url) {
  if (finalUrl != null && url != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ProgressiveImage(
        placeholder: const AssetImage('assets/images/picture.png'),
        thumbnail: NetworkImage(url),
        image: NetworkImage(finalUrl),
        height: 300,
        width: 500,
      ),
    );
  } else {
    //return Image.asset('assets/images/picture.png');
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset("assets/images/picture.png"),
    );
  }
}

final GoRouter _goRouter = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: "/",
      builder: (context, state) {
        return const MyHomePage(
          title: 'APODNasaFlutter',
        );
      },
      routes: <RouteBase>[
        GoRoute(
            path: "details",
            builder: (context, state) {
              return const MediaDetailsScreen();
            })
      ])
]);
