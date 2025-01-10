// lib/widgets/author_carousel.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/blocs/image_bloc.dart';
import '../../view_model/blocs/img_state.dart';

class AuthorCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        if (state is ImagesLoadedState || state is ImageLoadingState) {
          final images = state is ImagesLoadedState
              ? state.images
              : (state as ImageLoadingState).existingImages;

          // Filter out duplicate authors
          final authors =
              images.map((image) => image['author']).toSet().toList();

          return CarouselSlider(
            options: CarouselOptions(
              height: 80.0,
              viewportFraction: 0.25,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              disableCenter: true,
            ),
            items: authors.map((author) {
              String firstName = author?.split(' ')[0] ?? 'Unknown';
              return Column(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white, // Placeholder color
                    child: Center(
                      child: Icon(Icons.account_circle,
                          size: 61, color: Colors.black),
                    ),
                  ),
                  Text(
                    firstName,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
