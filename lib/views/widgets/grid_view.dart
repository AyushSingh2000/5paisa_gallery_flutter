import 'package:flutter/material.dart';

import '../../view_model/blocs/img_state.dart';
import 'custom_circularprogress.dart';
import 'image_tile.dart';

class GridImageView extends StatelessWidget {
  final ScrollController scrollController;
  final List<dynamic> images;
  final bool hasMore;
  final ImageState state;

  const GridImageView({
    Key? key,
    required this.scrollController,
    required this.images,
    required this.hasMore,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: images.length + (hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == images.length) {
                return Center(child: CPI());
              }
              return ImageTile(image: images[index]);
            },
          ),
        ),
        if (state is ImageLoadingState)
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CPI(),
          ),
      ],
    );
  }
}
