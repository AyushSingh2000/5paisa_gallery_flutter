import 'package:equatable/equatable.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object?> get props => [];
}

class ImageInitialState extends ImageState {}

class ImageLoadingState extends ImageState {
  final List<dynamic> existingImages;

  const ImageLoadingState({required this.existingImages});

  @override
  List<Object?> get props => [existingImages];
}

class ImagesLoadedState extends ImageState {
  final List<dynamic> images;
  final bool hasMore;

  const ImagesLoadedState({required this.images, required this.hasMore});

  @override
  List<Object?> get props => [images, hasMore];
}

class ImageErrorState extends ImageState {
  final String message;

  const ImageErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
