import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_truyenfull/apiResponse/Comic.dart';
import 'package:flutter_truyenfull/generated/Dimensions.dart';
import 'package:flutter_truyenfull/generated/PColors.dart';
import 'package:page_transition/page_transition.dart';

import '../../ComicDetailScreen/ComicDetailsScreen.dart';
import '../bloc/comic/ComicBloc.dart';
import '../bloc/comic/ComicState.dart';

class ComicListView extends StatefulWidget {
  const ComicListView({
    super.key,
  });

  @override
  State<ComicListView> createState() => _ComicListViewState();
}

class _ComicListViewState extends State<ComicListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComicBloc, ComicState>(
      builder: (context, comicState) {
        if (comicState is ComicLoadedState) {
          return Dimensions.getOrientation(context) == Orientation.portrait
              ? ListView.builder(
                  itemCount: comicState.comics.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ComicItem(
                      comic: comicState.comics[index],
                    );
                  },
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: comicState.comics.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.3,
                    crossAxisSpacing: 0 * Dimensions.responsiveSize.width,
                    mainAxisSpacing: 0 * Dimensions.responsiveSize.height,
                  ),
                  itemBuilder: (context, index) {
                    return ComicItem(
                      comic: comicState.comics[index],
                    );
                  },
                );
        } else {
          return Container();
        }
      },
    );
  }
}

class ComicItem extends StatelessWidget {
  const ComicItem({
    super.key,
    required this.comic,
  });

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double tween, Widget? child) {
          return Opacity(
            opacity: tween,
            child: Transform.scale(
              scale: tween,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0 * Dimensions.responsiveSize.height,
                  horizontal: 15.0 * Dimensions.responsiveSize.width,
                ),
                child: ScaleTap(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: ComicDetailsScreen(
                          comic: comic,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        25.0 * Dimensions.responsiveSize.width,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: PColors.bgBlack.withOpacity(0.5),
                          spreadRadius: 1 * Dimensions.responsiveSize.width,
                          blurRadius: 7 * Dimensions.responsiveSize.width,
                          offset: Offset(
                            3 * Dimensions.responsiveSize.width,
                            3 * Dimensions.responsiveSize.width,
                          ), // changes position
                          // of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(
                      10.0 * Dimensions.responsiveSize.width,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            100.0 * Dimensions.responsiveSize.width,
                          ),
                          child: SizedBox(
                            width: 100.0 * Dimensions.responsiveSize.width,
                            height: 100.0 * Dimensions.responsiveSize.width,
                            child: Image.network(
                              comic.poster!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0 * Dimensions.responsiveSize.width,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comic.title!,
                                style: TextStyle(
                                  fontSize: 20.0 * Dimensions.responsiveSize.width,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 2.0 * Dimensions.responsiveSize.height,
                              ),
                              Text(
                                comic.author!,
                                style: TextStyle(
                                  fontSize: 16.0 * Dimensions.responsiveSize.width,
                                  overflow: TextOverflow.ellipsis,
                                  fontStyle: FontStyle.italic,
                                  color: PColors.greyTextColor,
                                ),
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 10.0 * Dimensions.responsiveSize.height,
                              ),
                              Text(
                                "Tình trạng: ${comic.status}",
                                style: TextStyle(
                                  fontSize: 14.0 * Dimensions.responsiveSize.width,
                                  overflow: TextOverflow.ellipsis,
                                  color: PColors.greyTextColor,
                                ),
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 5.0 * Dimensions.responsiveSize.height,
                              ),
                              Text(
                                "Cập nhật: ${comic.updatedDate!.day}/${comic.updatedDate!.month}/${comic.updatedDate!.year}",
                                style: TextStyle(
                                  fontSize: 14.0 * Dimensions.responsiveSize.width,
                                  overflow: TextOverflow.ellipsis,
                                  color: PColors.greyTextColor,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
