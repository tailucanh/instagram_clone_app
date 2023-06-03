import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/custom_dialog_setting.dart';
import 'package:tinder_clone_app/components/my_item_list_user.dart';
import 'package:tinder_clone_app/controllers/user_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_image.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_story.dart';
import 'package:tinder_clone_app/screens/login/login_page.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';

class SearchTab extends StatefulWidget {
  SearchTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding:EdgeInsets.only(top: padding.top),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.search, color: Colors.grey),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm...',
                            border: InputBorder.none,

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Column(

                      children: [
                        Text(
                          "Tìm kiếm",
                          style: TextStyle(color: Colors.black, fontSize: 23),
                        ),
                        const SizedBox(height: 10,),
                        const Icon(
                          Icons.search_rounded,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),


    );

  }
}
