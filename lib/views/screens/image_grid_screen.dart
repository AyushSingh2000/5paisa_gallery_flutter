// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../models/constants.dart';
// import '../../view_model/blocs/image_bloc.dart';
// import '../../view_model/blocs/image_event.dart';
// import '../../view_model/blocs/img_state.dart';
// import '../widgets/image_tile.dart';
//
// class ImageGridScreen extends StatefulWidget {
//   @override
//   _ImageGridScreenState createState() => _ImageGridScreenState();
// }
//
// class _ImageGridScreenState extends State<ImageGridScreen> {
//   final ScrollController _scrollController = ScrollController();
//   int _page = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadImages();
//
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//               _scrollController.position.maxScrollExtent &&
//           !_isFetching()) {
//         _loadImages();
//       }
//     });
//   }
//
//   bool _isFetching() {
//     final state = context.read<ImageBloc>().state;
//     return state is ImageLoadingState;
//   }
//
//   void _loadImages() {
//     context
//         .read<ImageBloc>()
//         .add(FetchImagesEvent(page: _page, limit: Constants.limit));
//     _page++;
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Picsum Grid with Zoom')),
//       body: BlocBuilder<ImageBloc, ImageState>(
//         builder: (context, state) {
//           if (state is ImageInitialState ||
//               (state is ImageLoadingState && state.existingImages.isEmpty)) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ImagesLoadedState || state is ImageLoadingState) {
//             final images = state is ImagesLoadedState
//                 ? state.images
//                 : (state as ImageLoadingState).existingImages;
//             final hasMore = state is ImagesLoadedState ? state.hasMore : true;
//
//             return Column(
//               children: [
//                 Expanded(
//                   child: GridView.builder(
//                     controller: _scrollController,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 8.0,
//                       mainAxisSpacing: 8.0,
//                     ),
//                     itemCount: images.length + (hasMore ? 1 : 0),
//                     itemBuilder: (context, index) {
//                       if (index == images.length) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       return ImageTile(image: images[index]);
//                     },
//                   ),
//                 ),
//                 if (state is ImageLoadingState)
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: CircularProgressIndicator(),
//                   ),
//               ],
//             );
//           } else if (state is ImageErrorState) {
//             return Center(child: Text('Failed to load images'));
//           } else {
//             return SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/constants.dart';
import '../../view_model/blocs/image_bloc.dart';
import '../../view_model/blocs/image_event.dart';
import '../../view_model/blocs/img_state.dart';
import '../widgets/custom_circularprogress.dart';
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFD81B60),
                Color(0xFF1976D2),
                // End color
              ],
              begin: Alignment.topLeft, // Gradient start point
              end: Alignment.bottomRight, // Gradient end point
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Pictures",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                    ),
                    SizedBox(
                      width: 154,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 25,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 25,
                        )),
                  ],
                ),
              ),
              // ToggleSwitch at the top
              ToggleSwitch(
                isToggled: _isGridView,
                onToggle: () {
                  setState(() {
                    _isGridView = !_isGridView;
                  });
                },
              ),
              // Author Carousel below ToggleSwitch
              BlocBuilder<ImageBloc, ImageState>(
                builder: (context, state) {
                  if (state is ImagesLoadedState ||
                      state is ImageLoadingState) {
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
                          disableCenter: true),
                      items: authors.map((author) {
                        String firstName = author?.split(' ')[0] ?? 'Unknown';
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  Colors.white, // Placeholder color
                              child: Center(
                                child: Icon(Icons.account_circle,
                                    size: 61, color: Colors.black),
                              ),
                            ),
                            Text(
                              firstName,
                              style: TextStyle(
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
                  return SizedBox.shrink();
                },
              ),
              SizedBox(
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
                                        SliverGridDelegateWithFixedCrossAxisCount(
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
                                          SliverGridDelegateWithFixedCrossAxisCount(
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
                                            Container(
                                                height: 160,
                                                width: 160,
                                                child: ImageTile(
                                                    image: images[index])),
                                            SizedBox(
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
                                                  style: TextStyle(
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
                      return Center(child: Text('Failed to load images'));
                    } else {
                      return SizedBox.shrink();
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
