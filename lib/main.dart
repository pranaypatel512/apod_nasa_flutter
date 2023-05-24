import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:apod_nasa_flutter/viewmodel/media_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
          backgroundColor: Colors.white,
          title: Text(widget.title),
        ),
        body: Consumer<MediaViewModel>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                widthFactor: double.infinity,
                child: Lottie.network(
                    'https://assets6.lottiefiles.com/packages/lf20_2kHQhR.json'),
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
                        Row(
                          children: [
                            Text(
                              mediaItem.date ?? '',
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              mediaItem.copyright != null
                                  ? "©${mediaItem.copyright}"
                                  : "",
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            )
                          ],
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
    //return Image.asset('assets/images/picture.png');
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FadeInImage.assetNetwork(
        placeholder: 'images/picture.png',
        image: 'images/picture.png',
      ),
    );
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: finalUrl,
      ),
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => MediaViewModel(),
//       child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           home: ProviderDemoScreen()),
//     );
//   }
// }

// class ProviderDemoScreen extends StatefulWidget {
//   const ProviderDemoScreen({Key? key}) : super(key: key);

//   @override
//   _ProviderDemoScreenState createState() => _ProviderDemoScreenState();
// }

// class _ProviderDemoScreenState extends State<ProviderDemoScreen> {
//   @override
//   void initState() {
//     super.initState();
//     final postModel = Provider.of<MediaViewModel>(context, listen: false);
//     postModel.loadAllMedia();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final postModel = Provider.of<MediaViewModel>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Provider Demo"),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: postModel.isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(top: 40, bottom: 20),
//                       child: Text(
//                         postModel.mediaItems?.title ?? "",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                     ),
//                     Container(
//                       child: Text(postModel.mediaItems?.body ?? ""),
//                     )
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
