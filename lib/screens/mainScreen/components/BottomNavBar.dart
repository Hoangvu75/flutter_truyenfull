import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_truyenfull/generated/PColors.dart';

import '../../../generated/Dimensions.dart';
import '../bloc/bottomNavBar/BottomNavBarBloc.dart';
import '../bloc/bottomNavBar/BottomNavBarState.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Dimensions.getOrientation(context) == Orientation.portrait
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 100.0 * Dimensions.responsiveSize.height,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0 * Dimensions.responsiveSize.width,
              vertical: 15.0 * Dimensions.responsiveSize.height,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: SizedBox(
                width: 60.0 * Dimensions.responsiveSize.width,
                height: 60.0 * Dimensions.responsiveSize.width,
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: PColors.primary,
                  onPressed: () {},
                  child: Icon(
                    Icons.menu_book_outlined,
                    size: 30.0 * Dimensions.responsiveSize.width,
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: ClipRRect(
                borderRadius: BorderRadius.circular(
                  30.0 * Dimensions.responsiveSize.width,
                ),
                child: BottomAppBar(
                  color: PColors.bgBlack,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 10.0 * Dimensions.responsiveSize.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      NavButton(
                        pageController: pageController,
                        position: 0,
                        iconData: Icons.home_outlined,
                      ),
                      NavButton(
                        pageController: pageController,
                        position: 1,
                        iconData: Icons.search_outlined,
                      ),
                      SizedBox(
                        width: 50.0 * Dimensions.responsiveSize.width,
                      ),
                      NavButton(
                        pageController: pageController,
                        position: 2,
                        iconData: Icons.favorite_border_outlined,
                      ),
                      NavButton(
                        pageController: pageController,
                        position: 3,
                        iconData: Icons.account_circle_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
      color: PColors.bgBlack,
      width: 50.0 * Dimensions.responsiveSize.width,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                NavButton(
                  pageController: pageController,
                  position: 0,
                  iconData: Icons.home_outlined,
                ),
                NavButton(
                  pageController: pageController,
                  position: 1,
                  iconData: Icons.search_outlined,
                ),
                NavButton(
                  pageController: pageController,
                  position: 2,
                  iconData: Icons.favorite_border_outlined,
                ),
                NavButton(
                  pageController: pageController,
                  position: 3,
                  iconData: Icons.account_circle_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
          );
  }
}

class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    required this.pageController,
    required this.position,
    required this.iconData,
  });

  final PageController pageController;
  final int position;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55.0 * Dimensions.responsiveSize.width,
      height: 55.0 * Dimensions.responsiveSize.height,
      child: MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          pageController.animateToPage(
            position,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
          );
        },
        child: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(builder: (context, bottomNavBarState) {
          return Icon(
            iconData,
            color: bottomNavBarState.position == position
                ? PColors.primary
                : PColors.primary.withOpacity(0.5),
            size: 27.0 * Dimensions.responsiveSize.width,
          );
        }),
      ),
    );
  }
}
