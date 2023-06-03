import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/custom_dialog_setting.dart';
import 'package:tinder_clone_app/components/my_item_list_user.dart';
import 'package:tinder_clone_app/controllers/user_controller.dart';
import 'package:tinder_clone_app/screens/home/details_user.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_image.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_story.dart';
import 'package:tinder_clone_app/screens/login/login_page.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';

import '../../models/user_modal.dart';

class ListAllUserTab extends StatefulWidget {
  ListAllUserTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListAllUserTabState();
}

class _ListAllUserTabState extends State<ListAllUserTab> {

  final UserController userController = Get.put(UserController());


  Future<void> showDetailsUser(BuildContext context, String uid) async {
    UserModal? user = await userController.getUserById(uid);
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsUserPage(userData: user),
        ),
      );
      print(user.toString());

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey.shade800
        ),
        title:
            Text(
              'Khám phá mọi người',
              style: TextStyle(color: Colors.black),
            ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.refresh_rounded,
                  size: 30, color: Color.fromRGBO(199, 60, 113, 100)),
              onPressed: () { userController.refreshGetUserList();},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:2,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black38,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(Icons.person_pin_outlined ,color: Colors.grey.shade600,),
                          ),
                        ),

                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('Đồng bộ thông tin trên trang cá nhân của bạn', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              ),
                              Text('Tìm bạn bè trên Facebook', style: TextStyle(color: Colors.black, fontSize: 13,),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(47, 128, 237,100),
                                  Color.fromRGBO(86, 204, 242, 100)
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Đồng bộ',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 15),
                    child: Text('Gợi ý liên quan nhất', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17)),
                  ),

                  userController.users.isEmpty ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: CircularProgressIndicator(),),
                  ) :
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child:Wrap(
                        children: List.generate(userController.users.length , (rowIndex) {
                          String uid = userController.users[rowIndex].name;


                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10,  right: 10),
                            child: ItemUser(
                                name: userController.users[rowIndex].name,
                                imageUrl: userController.users[rowIndex].avatar,
                                width: MediaQuery.of(context).size.width / 2.2,
                                onClick: () => showDetailsUser(context, userController.users[rowIndex].uid),
                                onFollow: () {},
                                textFollow:  userController.userData.value!.followersList.contains(userController.users[rowIndex].uid) ? 'Hủy theo dõi' : 'Theo dõi',
                                onClose: (){}
                            ),
                          );

                          },
                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Column(
                      children: [
                       Image.asset(AppAssets.iconEmail, width: 80,),
                        const SizedBox(height: 8),
                        Text('Giúp bạn bè dễ dàng theo dõi bạn', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text('Chia sẻ trang cá nhân với bạn bè và giúp họ kết nối với bạn trên Tinder.', style: TextStyle(color: Colors.grey.shade600, fontSize: 15,),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text('Chia sẻ trang cá nhân của bạn', style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
             


                ],
              ),
            ),

          ),


    );

  }
}
