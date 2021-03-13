import 'package:farmer_market/src/styles/colors.dart';
import 'package:farmer_market/src/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppNavbar {
  static CupertinoSliverNavigationBar cupertinoNavBar(
      {String title, BuildContext context}) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(title, style: TextStyles.navTitle),
      backgroundColor: Colors.transparent,
      border: null,
    );
  }

  static SliverAppBar materialNavBar(
      {@required String title, @required TabBar tapBar}) {
    return SliverAppBar(
      title: Text(
        title,
        style: TextStyles.navTitleMaterial,
      ),
      backgroundColor: AppColors.darkblue,
      bottom: tapBar,
      floating: true,
      pinned: true,
      snap: true,
    );
  }
}
