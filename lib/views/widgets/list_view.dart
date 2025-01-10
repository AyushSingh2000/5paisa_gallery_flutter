import 'package:flutter/material.dart';

import '../../view_model/blocs/img_state.dart';
import 'custom_circularprogress.dart';
import 'image_tile.dart';

class ListImageView extends StatelessWidget {
  final ScrollController scrollController;
  final List<dynamic> images;
  final bool hasMore;
  final ImageState state;

  const ListImageView({
    Key? key,
    required this.scrollController,
    required this.images,
    required this.hasMore,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 4,
              ),
              itemCount: images.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == images.length) {
                  return Center(child: CPI());
                }
                return Row(
                  children: [
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: ImageTile(image: images[index]),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Author:\n${images[index]['author']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          if (state is ImageLoadingState)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CPI(),
            ),
        ],
      ),
    );
  }
}
