import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:apod_nasa_flutter/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

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
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: _goRouter,
        title: 'APODNasaFlutter',
        theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(homeListProvider).isLoading;
    final media = ref.watch(homeListProvider).list;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: isLoading
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Lottie.network(
                    'https://assets6.lottiefiles.com/packages/lf20_2kHQhR.json'),
              )
            : ListView.builder(
                itemCount: media.length,
                itemBuilder: (context, index) {
                  final mediaItem = media[index];
                  return GestureDetector(
                    onTap: () => {context.goNamed("details", extra: mediaItem)},
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
              ));
  }
}

Widget _displayMedia(String? finalUrl, String? url) {
  if (finalUrl != null && url != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ProgressiveImage(
        placeholder: const AssetImage('assets/images/image_place_holder.png'),
        thumbnail: NetworkImage(url),
        image: NetworkImage(finalUrl),
        height: 220,
        width: double.infinity,
      ),
    );
  } else {
    //return Image.asset('assets/images/picture.png');
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        "assets/images/picture.png",
        height: 220,
        width: double.infinity,
      ),
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
            name: "details",
            path: "details",
            pageBuilder: (context, state) {
              final mediaItem = state.extra as MediaListResponse?;
              return MaterialPage(
                  child: MediaDetailsScreen(
                mediaItem: mediaItem,
              ));
            })
      ])
]);
