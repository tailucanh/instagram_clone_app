import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/custom_dialog_setting.dart';
import 'package:tinder_clone_app/components/my_item_list_user.dart';
import 'package:tinder_clone_app/controllers/user_controller.dart';
import 'package:tinder_clone_app/screens/chats/chats_page.dart';
import 'package:tinder_clone_app/screens/home/list_all_user_page.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_image.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_story.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_short_video.dart';
import 'package:tinder_clone_app/screens/login/login_page.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';

import '../../controllers/message_controller.dart';
import '../../models/user_modal.dart';

class DetailsUserPage extends StatefulWidget {
  final UserModal userData;

  DetailsUserPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsUserPageState();
}

class _DetailsUserPageState extends State<DetailsUserPage> {

  final UserController userController = Get.put(UserController());
  bool isRowVisible = false;

  bool isShowingDialog = true;
  int _selectedIndex = 0;


  void toggleRowVisibility() {
    setState(() {
      isRowVisible = !isRowVisible;
    });
    userController.refreshGetUserList();
  }


  Future<void> getChatUser(BuildContext context, String uid) async {
    UserModal? user = await userController.getUserById(uid);
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(userData: user, currentId: userController.userData.value!.uid,),
        ),
      );
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
        title: Text(
              widget.userData.name ?? '',
              style: TextStyle(color: Colors.black),
            ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.stacked_line_chart,
                  size: 25, color: Color.fromRGBO(199, 60, 113, 100)),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: widget.userData.avatar.length == 0 ? DecorationImage(
                              image: AssetImage(AppAssets.iconAvatar),
                              fit: BoxFit.cover,
                            ): DecorationImage(
                              image: NetworkImage(widget.userData.avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    widget.userData.followersList?.length.toString() ?? '0',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Người theo dõi',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    widget.userData.followingList?.length.toString() ?? '0',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Đang theo dõi',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          widget.userData.name ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          widget.userData.story ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(47, 128, 237,100),
                                  Color.fromRGBO(86, 204, 242, 100)
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('Theo dõi',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () { getChatUser(context, widget.userData.uid);},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Nhắn tin',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: InkWell(
                          onTap: toggleRowVisibility,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Color.fromRGBO(234, 64, 128, 100),
                                Color.fromRGBO(238, 128, 95, 100)
                              ]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: !isRowVisible?  Icon(Icons.person_add, color: Colors.white,size: 15,): Icon(Icons.person_add_alt_1_outlined, color: Colors.white,size: 15,) ,

                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: isRowVisible,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Khám phá mọi người', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17)),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListAllUserTab()));},
                                  child:  Text('Xem tất cả', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 16),),
                                )

                              ],
                            ),
                          ),
                          userController.users.isEmpty ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                              child: CircularProgressIndicator(),),
                          ) :
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for(int i = 0; i < userController.users.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ItemUser(
                                          name: userController.users[i].name,
                                          imageUrl: userController.users[i].avatar,
                                          width: 150,
                                          onClick: () => userController.showDetailsUser(context, userController.users[i].uid),
                                          onFollow: () => userController.onFollowUser(userController.userData as UserModal , userController.users[i].uid),
                                          textFollow: userController.userData.value!.followersList.contains(userController.users[i].uid) ? 'Hủy theo dõi' : 'Theo dõi',
                                          onClose: (){}),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],

                      )
                  ),



                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTabItem(0,Icons.list_alt_outlined),
                            _buildTabItem(1,Icons.video_collection_outlined),
                            _buildTabItem(2,Icons.person_pin_outlined),
                          ],
                        )
                      ],
                    ),
                  ),


                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: _buildSelectedScreen(),

                  ),


                ],
              ),
            ),

          ),
    );

  }
  Widget _buildTabItem(int index, IconData iconData) {
    final isSelected = index == _selectedIndex;

    return  Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.black : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 8),
              child: Icon(iconData, color: isSelected ? Colors.black : Colors.grey.shade400, size: 30,),
            ),
          ),
        ),

      ),
    );
  }

Widget _buildSelectedScreen() {
  switch (_selectedIndex) {
    case 0:
      return StoryTab(title: 'Chưa có khoảnh khắc được tạo',content: '',);
    case 1:
      return ShortVideoTab(title: 'Chưa có video được tạo');
    case 2:
      return StorageTab(title: 'Chưa có bài viết', content: '',);
    default:
      return Container();
  }
}

}
