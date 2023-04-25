import 'package:flutter/material.dart';

import '../../generated/Dimensions.dart';
import '../../generated/PColors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Tìm truyện",
                  style: TextStyle(
                    fontSize: 26 * Dimensions.responsiveSize.width,
                    fontWeight: FontWeight.w500,
                    color: PColors.primary,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  20 * Dimensions.responsiveSize.width,
                  0,
                  20 * Dimensions.responsiveSize.width,
                  0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onSubmitted: (value) {},
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: PColors.primary,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
