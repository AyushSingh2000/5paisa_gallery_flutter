import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object?> get props => [];
}

class FetchImagesEvent extends ImageEvent {
  final int page;
  final int limit;

  const FetchImagesEvent({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
