import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/custom_dialog_setting.dart';
import 'package:tinder_clone_app/components/my_item_list_user.dart';
import 'package:tinder_clone_app/controllers/user_controller.dart';
import 'package:tinder_clone_app/models/user_modal.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_image.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_story.dart';
import 'package:tinder_clone_app/screens/login/login_page.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';

class ListFollowTab extends StatefulWidget {
  ListFollowTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListFollowTabState();
}

class _ListFollowTabState extends State<ListFollowTab> {

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              AppAssets.iconTinder,
              width: 20,
            ),
            const SizedBox(width: 5),
            Text(
              'Tinder',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),

      ),
      body: SingleChildScrollView(),

    );

  }
}
