import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:apod_nasa_flutter/viewmodel/media_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MediaDetailsScreen extends StatefulWidget {
  const MediaDetailsScreen({super.key});

  @override
  State<MediaDetailsScreen> createState() => _MediaDetailsScreenState();
}

class _MediaDetailsScreenState extends State<MediaDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaItem =
        Provider.of<MediaViewModel>(context, listen: false).selectedItem;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(mediaItem?.title ?? ""),
        ),
        body: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _displayMedia(mediaItem!.finalUrl),
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
        ));
  }
}

Widget _displayMedia(String? finalUrl) {
  if (finalUrl == null) {
    //return Image.asset('assets/images/picture.png');
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/picture.png',
        image: 'assets/images/picture.png',
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
