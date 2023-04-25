import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_truyenfull/apiResponse/Comic.dart';
import 'package:flutter_truyenfull/generated/Dimensions.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/bloc/chapters/ChapterBloc.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/bloc/chapters/ChapterEvent.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/repositories/ChaptersRepository.dart';
import 'package:flutter_truyenfull/screens/ComicDetailScreen/repositories/ComicDetailRepository.dart';

import '../../generated/PColors.dart';
import 'bloc/comicDetails/ComicDetailsBloc.dart';
import 'bloc/comicDetails/ComicDetailsEvent.dart';
import 'bloc/comicDetails/ComicDetailsState.dart';
import 'components/ChapterListView.dart';

class ComicDetailsScreen extends StatelessWidget {
  const ComicDetailsScreen({Key? key, required this.comic}) : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ComicDetailsRepository>(
          create: (context) => ComicDetailsRepository(),
        ),
        RepositoryProvider<ChaptersRepository>(
          create: (context) => ChaptersRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ComicDetailsBloc>(
            create: (context) => ComicDetailsBloc(
              RepositoryProvider.of<ComicDetailsRepository>(context),
            )..add(LoadComicDetailsEvent(comicId: comic.id!)),
          ),
          BlocProvider<ChapterBloc>(
            create: (context) => ChapterBloc(
              RepositoryProvider.of<ChaptersRepository>(context),
            )..add(LoadChapterEvent(slug: comic.slug!)),
          ),
        ],
        child: Scaffold(
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    PColors.primary.withOpacity(0.05),
                    Colors.white,
                  ],
                ),
              ),
              child: BlocBuilder<ComicDetailsBloc, ComicDetailsState>(
                builder: (context, comicDetailsState) {
                  if (comicDetailsState is ComicDetailsLoadedState) {
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 500 * Dimensions.responsiveSize.height,
                          backgroundColor: PColors.primary,
                          leading: ScaleTap(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 25 * Dimensions.responsiveSize.width,
                              color: Colors.white,
                            ),
                          ),
                          leadingWidth: 70,
                          pinned: true,
                          snap: false,
                          floating: false,
                          elevation: 0,
                          automaticallyImplyLeading: false,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        comicDetailsState.comicDetails!.poster!,
                                      ),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 25 * Dimensions.responsiveSize.height,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10 * Dimensions.responsiveSize.width,
                                        ),
                                        child: Text(
                                          comicDetailsState.comicDetails!.title!,
                                          style: TextStyle(
                                            fontSize: 26 * Dimensions.responsiveSize.width,
                                            color: PColors.whiteTextColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20 * Dimensions.responsiveSize.height,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10 * Dimensions.responsiveSize.width,
                                        ),
                                        child: Text(
                                          comicDetailsState
                                              .comicDetails!.description![comic.description!.length - 1],
                                          style: TextStyle(
                                            fontSize: 18 * Dimensions.responsiveSize.width,
                                            color: PColors.greyTextColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsetsDirectional.symmetric(
                              horizontal: 10 * Dimensions.responsiveSize.width,
                              vertical: 10 * Dimensions.responsiveSize.height,
                            ),
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 15 * Dimensions.responsiveSize.width,
                              vertical: 15 * Dimensions.responsiveSize.height,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(
                                15 * Dimensions.responsiveSize.width,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Tác giả: ",
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          color: PColors.textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: comicDetailsState.comicDetails!.author,
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          fontWeight: FontWeight.bold,
                                          color: PColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Thể loại: ",
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          color: PColors.textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: comicDetailsState.comicDetails!.categoryList!
                                            .map((it) => it)
                                            .join(', '),
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          fontWeight: FontWeight.bold,
                                          color: PColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Trạng thái: ",
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          color: PColors.textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: comicDetailsState.comicDetails!.status,
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          fontWeight: FontWeight.bold,
                                          color: PColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Lượt xem: ",
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          color: PColors.textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: comicDetailsState.comicDetails!.rateCount.toString(),
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          fontWeight: FontWeight.bold,
                                          color: PColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Đánh giá: ",
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          color: PColors.textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: comicDetailsState.comicDetails!.rateAvg.toString(),
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          fontWeight: FontWeight.bold,
                                          color: PColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Đăng: ",
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          color: PColors.textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "${comicDetailsState.comicDetails!.uploadDate!.day}/${comicDetailsState.comicDetails!.uploadDate!.month}/${comicDetailsState.comicDetails!.uploadDate!.year}",
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          fontWeight: FontWeight.bold,
                                          color: PColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Cập nhật: ",
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          color: PColors.textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "${comicDetailsState.comicDetails!.updatedDate!.day}/${comicDetailsState.comicDetails!.updatedDate!.month}/${comicDetailsState.comicDetails!.updatedDate!.year}",
                                        style: TextStyle(
                                          fontSize: 18 * Dimensions.responsiveSize.width,
                                          fontWeight: FontWeight.bold,
                                          color: PColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsetsDirectional.symmetric(
                              horizontal: 10 * Dimensions.responsiveSize.width,
                              vertical: 10 * Dimensions.responsiveSize.height,
                            ),
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 15 * Dimensions.responsiveSize.width,
                              vertical: 15 * Dimensions.responsiveSize.height,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(
                                15 * Dimensions.responsiveSize.width,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Các chương mới nhất",
                                  style: TextStyle(
                                    fontSize: 18 * Dimensions.responsiveSize.width,
                                    color: PColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(
                                  thickness: 1 * Dimensions.responsiveSize.width,
                                ),
                                const ChapterListView(),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 200 * Dimensions.responsiveSize.height,
                          ),
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

