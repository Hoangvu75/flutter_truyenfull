import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_truyenfull/apiResponse/Category.dart';
import 'package:flutter_truyenfull/generated/Dimensions.dart';
import 'package:flutter_truyenfull/generated/PColors.dart';
import 'package:flutter_truyenfull/screens/categoryDetailsScreen/CategoryDetailsScreen.dart';
import 'package:flutter_truyenfull/screens/homeScreen/bloc/category/CategoryBloc.dart';
import 'package:flutter_truyenfull/screens/homeScreen/bloc/category/CategoryState.dart';
import 'package:page_transition/page_transition.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, categoryState) {
      if (categoryState is CategoryLoadedState) {
        return Dimensions.getOrientation(context) == Orientation.portrait
            ? GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryState.categories.length + 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.3,
                  crossAxisSpacing: 0 * Dimensions.responsiveSize.width,
                  mainAxisSpacing: 0 * Dimensions.responsiveSize.height,
                ),
                itemBuilder: (context, index) {
                  return index >= categoryState.categories.length
                      ? Container()
                      : CategoryItem(
                          category: categoryState.categories[index],
                        );
                },
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryState.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.3,
                  crossAxisSpacing: 0 * Dimensions.responsiveSize.width,
                  mainAxisSpacing: 0 * Dimensions.responsiveSize.height,
                ),
                itemBuilder: (context, index) {
                  return CategoryItem(
                    category: categoryState.categories[index],
                  );
                },
              );
      } else {
        return Container();
      }
    });
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double tween, Widget? child) {
          return Opacity(
            opacity: tween,
            child: Transform(
              transform:
              category.id! % 2 == 0
                  ? Matrix4.translationValues(50 * (1 - tween), 0, 0)
              : Matrix4.translationValues(-50 * (1 - tween), 0, 0),
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
                        child: CategoryDetailsScreen(
                          category: category,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        10.0 * Dimensions.responsiveSize.width,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: PColors.bgBlack.withOpacity(0.2),
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
                      15.0 * Dimensions.responsiveSize.width,
                    ),
                    child: Center(
                      child: Text(
                        category.name!,
                        style: TextStyle(
                          fontSize: 20 * Dimensions.responsiveSize.width,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
