import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_truyenfull/apiResponse/Category.dart';
import 'package:flutter_truyenfull/screens/categoryDetailsScreen/bloc/comic/ComicBloc.dart';
import 'package:flutter_truyenfull/screens/categoryDetailsScreen/components/ComicListView.dart';
import 'package:flutter_truyenfull/screens/categoryDetailsScreen/repositories/ComicRepository.dart';

import '../../generated/Dimensions.dart';
import '../../generated/PColors.dart';
import 'bloc/comic/ComicEvent.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ComicRepository>(
          create: (context) => ComicRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ComicBloc>(
            create: (context) => ComicBloc(
              RepositoryProvider.of<ComicRepository>(context),
            )..add(LoadComicEvent(categoryId: category.id!)),
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
              child: CategoryDetailsScreenBody(category: category),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryDetailsScreenBody extends StatefulWidget {
  const CategoryDetailsScreenBody({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<CategoryDetailsScreenBody> createState() => _CategoryDetailsScreenBodyState();
}

class _CategoryDetailsScreenBodyState extends State<CategoryDetailsScreenBody> {
  late ScrollController _scrollController;
  late bool _scrollControllerOnTopState;

  _scrollListener() {
    if (_scrollController.offset > 70 * Dimensions.responsiveSize.height) {
      setState(() {
        _scrollControllerOnTopState = true;
      });
    } else {
      setState(() {
        _scrollControllerOnTopState = false;
      });
    }

    if (_scrollController.position.atEdge) {
      bool isTop = _scrollController.position.pixels == 0;
      if (!isTop) {
        context.read<ComicBloc>().add(
              LoadMoreComicEvent(
                categoryId: widget.category.id!,
              ),
            );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text("Loading..."),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _scrollControllerOnTopState = false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 175 * Dimensions.responsiveSize.height,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: _scrollControllerOnTopState ? PColors.primary : Colors.transparent,
          leading: ScaleTap(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 25 * Dimensions.responsiveSize.width,
              color: _scrollControllerOnTopState ? Colors.white : PColors.primary,
            ),
          ),
          leadingWidth: 50 * Dimensions.responsiveSize.width,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: _scrollControllerOnTopState
                ? null
                : EdgeInsets.all(
                    20 * Dimensions.responsiveSize.width,
                  ),
            title: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              curve: Curves.ease,
              duration: const Duration(seconds: 2),
              builder: (BuildContext context, double tween, Widget? child) {
                return Opacity(
                  opacity: tween,
                  child: Transform(
                    transform: Matrix4.translationValues(-50 * (1 - tween), 0, 0),
                    child: Text("Truyện ${widget.category.name}",
                        style: _scrollControllerOnTopState
                            ? TextStyle(
                                fontSize: 24 * Dimensions.responsiveSize.width,
                                color: PColors.whiteTextColor,
                              )
                            : TextStyle(
                                fontSize: 30 * Dimensions.responsiveSize.width,
                                color: PColors.primary,
                              )),
                  ),
                );
              },
            ),
            centerTitle: _scrollControllerOnTopState ? true : false,
          ),
        ),
        const SliverToBoxAdapter(child: ComicListView())
      ],
    );
  }
}
