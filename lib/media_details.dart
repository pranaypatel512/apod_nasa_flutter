import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_image/progressive_image.dart';

class MediaDetailsScreen extends ConsumerWidget {
  const MediaDetailsScreen({super.key, required this.mediaItem});
  final MediaListResponse? mediaItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mediaItem?.title ?? ""),
        ),
        body: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _displayMedia(mediaItem!.finalUrl, mediaItem?.url ?? ""),
                  const SizedBox(height: 8.0),
                  Text(
                    mediaItem?.title ?? '',
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
                          mediaItem?.date ?? '',
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Expanded(
                          child: Text(
                        mediaItem?.copyright != null
                            ? "©${mediaItem?.copyright}"
                            : "",
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ))
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                      flex: 0,
                      child: Text(
                        mediaItem?.explanation ?? '',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ))
                ],
              ),
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
        placeholder: const AssetImage('assets/images/image_place_holder.png'),
        thumbnail: NetworkImage(url),
        image: NetworkImage(finalUrl),
        height: 220,
        width: double.infinity,
      ),
    );
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset("assets/images/picture.png"),
    );
  }
}
