import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/constants.dart';
import '../../view_model/blocs/image_bloc.dart';
import '../../view_model/blocs/image_event.dart';
import '../../view_model/blocs/img_state.dart';
import '../widgets/author_carousel.dart';
import '../widgets/custom_circularprogress.dart';
import '../widgets/custom_top_bar.dart';
import '../widgets/grid_view.dart';
import '../widgets/list_view.dart';
import '../widgets/toogle_switch.dart'; // Import ToggleSwitch

class ImageGridScreen extends StatefulWidget {
  @override
  _ImageGridScreenState createState() => _ImageGridScreenState();
}

class _ImageGridScreenState extends State<ImageGridScreen> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _isGridView = true; // Track the toggle state

  @override
  void initState() {
    super.initState();
    _loadImages();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isFetching()) {
        _loadImages();
      }
    });
  }

  bool _isFetching() {
    final state = context.read<ImageBloc>().state;
    return state is ImageLoadingState;
  }

  void _loadImages() {
    context
        .read<ImageBloc>()
        .add(FetchImagesEvent(page: _page, limit: Constants.limit));
    _page++;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFD81B60),
                Color(0xFF1976D2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              const CustomBar(),
              ToggleSwitch(
                isToggled: _isGridView,
                onToggle: () {
                  setState(() {
                    _isGridView = !_isGridView;
                  });
                },
              ),
              AuthorCarousel(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, state) {
                    if (state is ImageInitialState ||
                        (state is ImageLoadingState &&
                            state.existingImages.isEmpty)) {
                      return Center(child: CPI());
                    } else if (state is ImagesLoadedState ||
                        state is ImageLoadingState) {
                      final images = state is ImagesLoadedState
                          ? state.images
                          : (state as ImageLoadingState).existingImages;
                      final hasMore =
                          state is ImagesLoadedState ? state.hasMore : true;

                      return _isGridView
                          ? GridImageView(
                              scrollController: _scrollController,
                              images: images,
                              hasMore: hasMore,
                              state: state,
                            )
                          : ListImageView(
                              scrollController: _scrollController,
                              images: images,
                              hasMore: hasMore,
                              state: state,
                            );
                    } else if (state is ImageErrorState) {
                      return const Center(child: Text('Failed to load images'));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
