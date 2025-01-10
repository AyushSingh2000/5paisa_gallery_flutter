import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../widgets/custom_iconBtn.dart';

class ImagePreviewScreen extends StatelessWidget {
  final List<dynamic> images;
  final int initialIndex;

  ImagePreviewScreen({required this.images, required this.initialIndex});
  Future<void> _downloadImage(String url) async {
    // Assuming flutter_downloader is properly set up in your project
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: '/storage/emulated/0/Download', // Path to download directory
      fileName: 'image.jpg', // File name for the image
      showNotification: true, // Show download progress notification
      openFileFromNotification: true,
    );
    print("Download started with task ID: $taskId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: BouncingScrollPhysics(),
            itemCount: images.length,
            pageController: PageController(initialPage: initialIndex),
            builder: (context, index) {
              final image = images[index];
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    CachedNetworkImageProvider(image['download_url']),
              );
            },
          ),
          Positioned(
            top: 80,
            left: 20,
            child: Row(
              children: [
                CustomIconButton(
                  icon: Icons.cancel,
                  size: 30,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 200,
                ),
                CustomIconButton(
                  icon: Icons.download_rounded,
                  size: 30,
                  onPressed: () {
                    _downloadImage(images[initialIndex]['download_url']);
                  },
                ),
                CustomIconButton(
                  icon: Icons.share_rounded,
                  size: 30,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
