import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/img_repository.dart';
import 'image_event.dart';
import 'img_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository repository;

  ImageBloc({required this.repository}) : super(ImageInitialState()) {
    on<FetchImagesEvent>((event, emit) async {
      if (state is ImageLoadingState ||
          !(state is ImagesLoadedState || state is ImageInitialState)) {
        return; // Prevent duplicate fetches.
      }

      final currentState = state;
      List<dynamic> existingImages = [];

      if (currentState is ImagesLoadedState) {
        existingImages = currentState.images;
      }

      emit(ImageLoadingState(existingImages: existingImages));

      try {
        final newImages = await repository.fetchImages(event.page, event.limit);
        emit(ImagesLoadedState(
          images: existingImages + newImages,
          hasMore: newImages.isNotEmpty,
        ));
      } catch (e) {
        emit(ImageErrorState(message: 'Failed to load images'));
      }
    });
  }
}
