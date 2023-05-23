import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:apod_nasa_flutter/viewmodel/media_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
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
      child: MaterialApp(
        title: 'APODNasaFlutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'APODNasaFlutter'),
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //TODO: not getting list update call and continues showing progress bar
            final media = value.mediaItems;
            return ListView.builder(
              itemCount: media.length,
              itemBuilder: (context, index) {
                final mediaItem = media[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _displayMedia(mediaItem.finalUrl),
                        const SizedBox(height: 8.0),
                        Text(
                          mediaItem.title ?? '',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          mediaItem.date ?? '',
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "©${mediaItem.copyright}",
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

Widget _displayMedia(String? finalUrl) {
  if (finalUrl == null) {
    return Image.asset('assets/picture.png');
  } else {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: finalUrl,
    );
  }
}
