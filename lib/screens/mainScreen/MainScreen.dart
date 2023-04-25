import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_truyenfull/screens/homeScreen/HomeScreen.dart';
import 'package:flutter_truyenfull/screens/searchScreen/SearchScreen.dart';

import '../../generated/Dimensions.dart';
import 'bloc/bottomNavBar/BottomNavBarBloc.dart';
import 'bloc/bottomNavBar/BottomNavBarEvent.dart';
import 'bloc/bottomNavBar/BottomNavBarState.dart';
import 'components/BottomNavBar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController(initialPage: 0, keepPage: true);

  final List<Widget> screenList = [
    const HomeScreen(),
    const SearchScreen(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavBarBloc>(
      create: (context) => BottomNavBarBloc(),
      child: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
        builder: (context, bottomNavBarState) {
          return Dimensions.getOrientation(context) == Orientation.portrait ? Stack(
            children: [
              Scaffold(
                body: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemCount: screenList.length,
                  onPageChanged: (int page) {
                    context.read<BottomNavBarBloc>().add(ChangeBottomNavBarPosition(position: page));
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return screenList[index];
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: BottomNavBar(
                  pageController: pageController,
                ),
              ),
            ],
          ) : Row(
            children: [
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemCount: screenList.length,
                  onPageChanged: (int page) {
                    context.read<BottomNavBarBloc>().add(ChangeBottomNavBarPosition(position: page));
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return screenList[index];
                  },
                ),
              ),
              BottomNavBar(
                pageController: pageController,
              ),
            ],
          );
        },
      ),
    );
  }
}
