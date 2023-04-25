import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_truyenfull/apiResponse/Chapter.dart';
import 'package:flutter_truyenfull/generated/Dimensions.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/chapterDetails/ChapterBloc.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/chapterDetails/ChapterDetailsEvent.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/chapterDetails/ChapterDetailsState.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/settings/SettingsBloc.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/settings/SettingsEvent.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/bloc/settings/SettingsState.dart';
import 'package:flutter_truyenfull/screens/chapterDetailsScreen/repositories/ChapterDetailsRepositories.dart';

import '../../generated/PColors.dart';

class ChapterDetailsScreen extends StatefulWidget {
  const ChapterDetailsScreen({Key? key, required this.chapter}) : super(key: key);

  final Chapter chapter;

  @override
  State<ChapterDetailsScreen> createState() => _ChapterDetailsScreenState();
}

class _ChapterDetailsScreenState extends State<ChapterDetailsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChapterDetailsRepository>(
          create: (context) => ChapterDetailsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ChapterDetailsBloc>(
            create: (context) => ChapterDetailsBloc(
              RepositoryProvider.of<ChapterDetailsRepository>(context),
            )..add(LoadChapterDetailsEvent(id: widget.chapter.id!)),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
        ],
        child: Scaffold(
          body: SafeArea(
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, settingsState) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: settingsState.isDarkMode
                          ? [
                              PColors.bgBlack,
                              PColors.bgBlack,
                            ]
                          : [
                              PColors.primary.withOpacity(0.05),
                              Colors.white,
                            ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      settingsState.isScrollView
                          ? SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: BlocBuilder<ChapterDetailsBloc, ChapterDetailsState>(
                                builder: (context, chapterDetailsState) {
                                  if (chapterDetailsState is ChapterDetailsLoadedState) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15 * Dimensions.responsiveSize.height,
                                            horizontal: 15 * Dimensions.responsiveSize.width,
                                          ),
                                          child: Text(
                                            chapterDetailsState.chapterDetails!.header!,
                                            style: TextStyle(
                                              fontSize: 30 * Dimensions.responsiveSize.width,
                                              color: PColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15 * Dimensions.responsiveSize.width,
                                          ),
                                          child: Text(
                                            removeHtmlTags(chapterDetailsState.chapterDetails!.body![0]),
                                            style: TextStyle(
                                              fontSize: settingsState.fontSize * Dimensions.responsiveSize.width,
                                              color: settingsState.isDarkMode
                                                  ? PColors.whiteTextColor
                                                  : PColors.textColor,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            )
                          : BlocBuilder<ChapterDetailsBloc, ChapterDetailsState>(
                              builder: (context, chapterDetailsState) {
                              if (chapterDetailsState is ChapterDetailsLoadedState) {
                                var content = removeHtmlTags2(chapterDetailsState.chapterDetails!.body![0]);

                                var deviceData = MediaQuery.of(context);
                                var deviceHeight = deviceData.size.height;
                                var deviceWidth = deviceData.size.width;
                                var deviceDimension = deviceHeight * deviceWidth;

                                var pageCharLimit =
                                    (deviceDimension / (settingsState.fontSize * (settingsState.fontSize * 0.8)))
                                        .round();
                                debugPrint('Character limit per page: $pageCharLimit');

                                var pageCount = (content.length / pageCharLimit).round();

                                List<String> pageText = [
                                  chapterDetailsState.chapterDetails!.header!,
                                ];
                                var index = 0;
                                var startStrIndex = 0;
                                var endStrIndex = pageCharLimit;
                                while (index < pageCount) {
                                  /// Update the last index to the Document Text length
                                  if (index == pageCount - 1) {
                                    endStrIndex = content.length;
                                  }

                                  pageText.add(content.substring(startStrIndex, endStrIndex));

                                  if (index < pageCount) {
                                    startStrIndex = endStrIndex;
                                    endStrIndex += pageCharLimit;
                                  }
                                  index++;
                                }
                                return PageView.builder(
                                  itemCount: pageText.length,
                                  itemBuilder: (context, index) {
                                    return index == 0
                                        ? SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height,
                                            child: Center(
                                              child: Text(
                                                chapterDetailsState.chapterDetails!.header!,
                                                style: TextStyle(
                                                  fontSize: 30 * Dimensions.responsiveSize.width,
                                                  color: PColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15 * Dimensions.responsiveSize.width,
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    pageText[index],
                                                    style: TextStyle(
                                                      fontSize:
                                                          settingsState.fontSize * Dimensions.responsiveSize.width,
                                                      color: settingsState.isDarkMode
                                                          ? PColors.whiteTextColor
                                                          : PColors.textColor,
                                                      overflow: TextOverflow.clip,
                                                    ),
                                                    textAlign: TextAlign.justify,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            }),
                      Positioned(
                        top: 15 * Dimensions.responsiveSize.height,
                        right: 15 * Dimensions.responsiveSize.width,
                        child: ScaleTap(
                          onPressed: () {
                            if (_animation.value == 0) {
                              _animationController.forward();
                            } else {
                              _animationController.reverse();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10 * Dimensions.responsiveSize.width),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(15 * Dimensions.responsiveSize.width),
                            ),
                            child: Icon(
                              Icons.settings_outlined,
                              size: 30 * Dimensions.responsiveSize.width,
                              color: PColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        width: MediaQuery.of(context).size.width,
                        child: Visibility(
                          visible: _animation.value == 0 ? false : true,
                          child: Opacity(
                            opacity: _animation.value,
                            child: Container(
                              padding: EdgeInsets.all(15 * Dimensions.responsiveSize.width),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Cài đặt",
                                        style: TextStyle(
                                          fontSize: 24 * Dimensions.responsiveSize.width,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          _animationController.reverse();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          size: 30 * Dimensions.responsiveSize.width,
                                          color: PColors.primary,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15 * Dimensions.responsiveSize.height,
                                  ),
                                  Text(
                                    "Font size: ${settingsState.fontSize}",
                                    style: TextStyle(
                                      fontSize: 20 * Dimensions.responsiveSize.width,
                                    ),
                                  ),
                                  Slider(
                                    value: settingsState.fontSize,
                                    max: 40,
                                    min: 10,
                                    divisions: 60,
                                    label: settingsState.fontSize.toString(),
                                    onChanged: (double value) {
                                      context.read<SettingsBloc>().add(
                                            ChangeSettingsEvent(fontSize: value),
                                          );
                                    },
                                  ),
                                  Text(
                                    "Background: ",
                                    style: TextStyle(
                                      fontSize: 20 * Dimensions.responsiveSize.width,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: false,
                                        groupValue: settingsState.isDarkMode,
                                        onChanged: (value) {
                                          context.read<SettingsBloc>().add(
                                                ChangeSettingsEvent(isDarkMode: false),
                                              );
                                        },
                                      ),
                                      Text(
                                        "Normal mode",
                                        style: TextStyle(
                                          fontSize: 20 * Dimensions.responsiveSize.width,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: true,
                                        groupValue: settingsState.isDarkMode,
                                        onChanged: (value) {
                                          context.read<SettingsBloc>().add(
                                                ChangeSettingsEvent(isDarkMode: true),
                                              );
                                        },
                                      ),
                                      Text(
                                        "Dark mode",
                                        style: TextStyle(
                                          fontSize: 20 * Dimensions.responsiveSize.width,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Reading mode: ",
                                    style: TextStyle(
                                      fontSize: 20 * Dimensions.responsiveSize.width,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: true,
                                        groupValue: settingsState.isScrollView,
                                        onChanged: (value) {
                                          context.read<SettingsBloc>().add(
                                                ChangeSettingsEvent(isScrollView: true),
                                              );
                                        },
                                      ),
                                      Text(
                                        "Scrollview",
                                        style: TextStyle(
                                          fontSize: 20 * Dimensions.responsiveSize.width,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: false,
                                        groupValue: settingsState.isScrollView,
                                        onChanged: (value) {
                                          context.read<SettingsBloc>().add(
                                                ChangeSettingsEvent(isScrollView: false),
                                              );
                                        },
                                      ),
                                      Text(
                                        "Pageview",
                                        style: TextStyle(
                                          fontSize: 20 * Dimensions.responsiveSize.width,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String removeHtmlTags(String htmlString) {
    String newString = htmlString.replaceAll("<br>", "\n");
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String plainText = newString.replaceAll(exp, '');
    return plainText;
  }

  String removeHtmlTags2(String htmlString) {
    String newString = htmlString.replaceAll("<br>", "");
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String plainText = newString.replaceAll(exp, '');
    return plainText;
  }
}
