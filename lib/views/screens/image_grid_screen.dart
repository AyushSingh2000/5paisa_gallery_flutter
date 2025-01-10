import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/constants.dart';
import '../../view_model/blocs/image_bloc.dart';
import '../../view_model/blocs/image_event.dart';
import '../../view_model/blocs/img_state.dart';
import '../widgets/author_carousel.dart';
import '../widgets/custom_circularprogress.dart';
import '../widgets/custom_top_bar.dart';
import '../widgets/image_tile.dart';
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
              // ToggleSwitch at the top
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

              // The grid of pics
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
                          ? Column(
                              children: [
                                Expanded(
                                  child: GridView.builder(
                                    controller: _scrollController,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0,
                                    ),
                                    itemCount:
                                        images.length + (hasMore ? 1 : 0),
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: CPI(),
                                  ),
                              ],
                            )
                          //list of pics
                          : Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                      controller: _scrollController,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: 4,
                                      ),
                                      itemCount:
                                          images.length + (hasMore ? 1 : 0),
                                      itemBuilder: (context, index) {
                                        if (index == images.length) {
                                          return Center(child: CPI());
                                        }
                                        return Row(
                                          children: [
                                            SizedBox(
                                                height: 160,
                                                width: 160,
                                                child: ImageTile(
                                                    image: images[index])),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Author:\n${images[index]['author']}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  if (state is ImageLoadingState)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CPI(),
                                    ),
                                ],
                              ),
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
