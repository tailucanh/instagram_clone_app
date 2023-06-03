import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder_clone_app/controllers/main_wrapper_controller.dart';
import 'package:tinder_clone_app/screens/home/views/add_content_tab.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:tinder_clone_app/screens/home/views/home_tab.dart';
import 'package:tinder_clone_app/screens/home/views/profile_tab.dart';
import 'package:tinder_clone_app/screens/home/views/search_tab.dart';
import 'package:tinder_clone_app/screens/home/views/video_tab.dart';

import '../../controllers/user_controller.dart';


class MainWrapper extends StatelessWidget {
  MainWrapper({Key? key}) : super(key: key);

  final MainWrapperController _mainWrapperController =
      Get.put(MainWrapperController());
  final  UserController userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _mainWrapperController.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: _mainWrapperController.animateToTab,
        children: [
          HomeTab(),
          SearchTab(),
          AddContentTab(),
          VideoTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomAppBarItem(
                  icon: Icons.home_outlined,
                  page: 0,
                  context,

                ),
                _bottomAppBarItem(
                  icon: Icons.search,
                  page: 1,
                  context,

                ),
                _bottomAppBarItem(
                icon: Icons.add_circle_outline_rounded,
                  page: 2,
                  context,

                  ),
                _bottomAppBarItem(
                  icon: Icons.video_library,
                  page: 3,
                  context,

                ),
                _bottomAppBarItem(
                  icon: Icons.person_pin,
                  page: 4,
                  context,
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page }) {
    return ZoomTapAnimation(
      onTap: () => _mainWrapperController.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _mainWrapperController.currentPage == page
                  ? Color.fromRGBO(234, 64, 128, 100)
                  : Colors.grey,
              size: 28,
            ),

          ],
        ),
      ),
    );
  }
}
