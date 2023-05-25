import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:apod_nasa_flutter/viewmodel/media_view_model.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';

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
                _displayMedia(mediaItem!.finalUrl, mediaItem.url),
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
