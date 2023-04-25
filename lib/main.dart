import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_truyenfull/generated/Dimensions.dart';
import 'package:flutter_truyenfull/screens/mainScreen/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black
      ),
    );
    return MaterialApp(
      home: MainScreen(),
      builder: _builder(),
    );
  }

  Widget Function(BuildContext, Widget?) _builder({Widget Function(BuildContext, Widget?)? builder}) {
    var newBuilder = EasyLoading.init(builder: builder);

    return (BuildContext context, Widget? child) {
      final mChild = child;
      if (mChild != null) {
        final widgetSize = MediaQuery.of(context).size;
        final mResponsiveWidth = widgetSize.width / 375; // 375: Design width
        final mResponsiveHeight = widgetSize.height / 812; // 812: Design height
        final mResponsiveSize = Size(mResponsiveWidth, mResponsiveHeight);
        if (mResponsiveWidth != Dimensions.responsiveSize.width ||
            mResponsiveHeight != Dimensions.responsiveSize.height) {
          if (widgetSize.width > 650) {
            // AppUtils.isSuperBigPhone = true;
          }
          if (mResponsiveWidth > 1.2) {
            Dimensions.responsiveSize = Size(1.2, mResponsiveHeight);
          } else {
            Dimensions.responsiveSize = mResponsiveSize;
          }
          if (kDebugMode) {
            print(
                "widgetSize width: ${widgetSize.width}\nwidgetSize height: ${widgetSize.height}\nresponsiveSize: "
                "$Dimensions.responsiveSize\nmResponsiveHeight: $mResponsiveHeight");
          }
        }
        return newBuilder(
          context,
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: mChild,
          ),
        );
      }
      return Container();
    };
  }
}
