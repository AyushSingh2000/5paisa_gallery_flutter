import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../screens/ image_preview_screen.dart';
import 'custom_circularprogress.dart';

class ImageTile extends StatelessWidget {
  final dynamic image;

  const ImageTile({required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePreviewScreen(
              images: [image],
              initialIndex: 0,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: image['download_url'],
          placeholder: (context, url) => Center(child: CPI()),
          errorWidget: (context, url, error) =>
              Icon(Icons.error, color: Colors.red),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
