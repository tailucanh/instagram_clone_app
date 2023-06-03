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

class AddContentTab extends StatefulWidget {
  AddContentTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddContentTabTabState();
}

class _AddContentTabTabState extends State<AddContentTab> {



  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Center(

        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           children:[
              Text(
              "Thêm content",
              style: TextStyle(color: Colors.black, fontSize: 23),
            ),
               const SizedBox(height: 10,),
              const Icon(
                Icons.add_a_photo_sharp,
                size: 40,
              ),
           ]

        ),
      ),


    );

  }
}
