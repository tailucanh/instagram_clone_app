import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/custom_dialog_setting.dart';
import 'package:tinder_clone_app/components/my_item_list_user.dart';
import 'package:tinder_clone_app/controllers/user_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinder_clone_app/models/user_modal.dart';
import 'package:tinder_clone_app/screens/chats/chats_page.dart';
import 'package:tinder_clone_app/screens/chats/list_chats_user.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_image.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_story.dart';
import 'package:tinder_clone_app/screens/login/login_page.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';

class HomeTab extends StatefulWidget {
   HomeTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final String? imageUrl =  userController.userData.value?.avatar;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding:EdgeInsets.only(top: padding.top),
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Row(
                            children: [
                              Image.asset(AppAssets.iconTinder, width: 25,),
                              const SizedBox(width: 6,),
                              Image.asset(AppAssets.texTinder, width: 100,),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: (){},
                                child: Icon(Icons.notifications_none_rounded, color: Colors.grey.shade700, size: 28,),
                              ),
                              const SizedBox(width: 15,),

                              InkWell(
                                onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ListsChatScreen()));},
                                child:  Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color.fromRGBO(199, 60, 113, 100),
                                      width: 1,
                                    ),
                                  ),
                                  child:   Icon(Icons.message_outlined, color: Color.fromRGBO(199, 60, 113, 100), size: 20,),
                                ),

                              )
                            ],
                          ),
                      ],
                    ),
                    Padding(
                    padding: const EdgeInsets.only(top: 30,),
                    child: Row(
                      children: [
                        // Stack(
                        //   children: [
                        //     // Avatar image
                        //     Container(
                        //       width: 65,
                        //       height: 65,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         border: Border.all(
                        //           color: Colors.grey,
                        //           width: 1,
                        //         ),
                        //         image: imageUrl!.isEmpty ? DecorationImage(
                        //           image: AssetImage(AppAssets.iconAvatar),
                        //           fit: BoxFit.cover,
                        //         ): DecorationImage(
                        //           image: NetworkImage(imageUrl),
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                        //     // Camera icon
                        //     Positioned(
                        //       bottom: 0,
                        //       right: 0,
                        //
                        //       child: Container(
                        //         width: 20,
                        //         height: 20,
                        //         decoration: BoxDecoration(
                        //           color: Colors.blueAccent,
                        //           shape: BoxShape.circle,
                        //           border: Border.all(
                        //             color: Colors.white,
                        //             width: 2,
                        //           ),
                        //         ),
                        //         child: Icon(
                        //           Icons.add,
                        //           color: Colors.white,
                        //           size: 15,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),

        ),
      ),


    );

  }
}
