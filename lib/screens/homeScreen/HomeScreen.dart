import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_truyenfull/generated/Dimensions.dart';
import 'package:flutter_truyenfull/generated/PColors.dart';
import 'package:flutter_truyenfull/screens/homeScreen/bloc/category/CategoryBloc.dart';
import 'package:flutter_truyenfull/screens/homeScreen/bloc/category/CategoryEvent.dart';
import 'package:flutter_truyenfull/screens/homeScreen/bloc/updatedComic/UpdatedComicBloc.dart';
import 'package:flutter_truyenfull/screens/homeScreen/components/HeaderSelectorBar.dart';
import 'package:flutter_truyenfull/screens/homeScreen/components/UpdatedComicListView.dart';
import 'package:flutter_truyenfull/screens/homeScreen/repositories/CategoryRepository.dart';
import 'package:flutter_truyenfull/screens/homeScreen/repositories/UpdatedComicRepository.dart';

import 'bloc/headerSelector/HeaderSelectorBloc.dart';
import 'bloc/headerSelector/HeaderSelectorState.dart';
import 'bloc/updatedComic/UpdatedComicEvent.dart';
import 'components/CategoryListView.dart';

class HomeScreen extends StatefulWidget  {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UpdatedComicRepository>(
          create: (context) => UpdatedComicRepository(),
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) => CategoryRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HeaderSelectorBloc>(
            create: (context) => HeaderSelectorBloc(),
          ),
          BlocProvider<UpdatedComicBloc>(
            create: (context) => UpdatedComicBloc(
              RepositoryProvider.of<UpdatedComicRepository>(context),
            )..add(LoadUpdatedComicEvent()),
          ),
          BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
              RepositoryProvider.of<CategoryRepository>(context),
            )..add(LoadCategoryEvent()),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24 * Dimensions.responsiveSize.width,
                      vertical: 20 * Dimensions.responsiveSize.height,
                    ),
                    child: Text(
                      "Trang chủ",
                      style: TextStyle(
                        fontSize: 26 * Dimensions.responsiveSize.width,
                        fontWeight: FontWeight.w500,
                        color: PColors.primary,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    child: const HeaderSelectorBar(),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10.0 * Dimensions.responsiveSize.height,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: BlocBuilder<HeaderSelectorBloc, HeaderSelectorState>(
                        builder: (context, categorySelectorState) {
                          if (categorySelectorState.position == 0) {
                            return const UpdatedComicListView();
                          } else if (categorySelectorState.position == 1) {
                            return const CategoryListView();
                          }
                          else {
                            return const UpdatedComicListView();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
