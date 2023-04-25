import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_truyenfull/generated/Dimensions.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/bloc/chapters/ChapterBloc.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/bloc/chapters/ChapterState.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/ChapterDetailsScreen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../apiResponse/Chapter.dart';
import '../../../generated/PColors.dart';

class ChapterListView extends StatefulWidget {
  const ChapterListView({
    super.key,
  });

  @override
  State<ChapterListView> createState() => _ChapterListViewState();
}

class _ChapterListViewState extends State<ChapterListView> {
  bool viewAllChapters = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChapterBloc, ChapterState>(builder: (context, chapterState) {
      if (chapterState is ChapterLoadedState) {
        return Column(
          children: [
            ListView.builder(
              itemCount: viewAllChapters ? chapterState.chapters.length : 3,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ChapterItem(
                  chapter: chapterState.chapters[index],
                );
              },
            ),
            Divider(
              thickness: 1 * Dimensions.responsiveSize.width,
              height: 20 * Dimensions.responsiveSize.height,
            ),
            ScaleTap(
              onPressed: () {
                setState(() {
                  viewAllChapters = !viewAllChapters;
                });
              },
              child: Text(
                viewAllChapters ? "Thu gọn" : "Xem thêm",
                style: TextStyle(
                  fontSize: 18 * Dimensions.responsiveSize.width,
                  color: PColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}

class ChapterItem extends StatelessWidget {
  const ChapterItem({
    super.key,
    required this.chapter,
  });

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: ChapterDetailsScreen(
              chapter: chapter,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5 * Dimensions.responsiveSize.height,
          horizontal: 5 * Dimensions.responsiveSize.width,
        ),
        child: Text(
          chapter.header!,
          style: TextStyle(
            fontSize: 18 * Dimensions.responsiveSize.width,
            color: PColors.greyTextColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
