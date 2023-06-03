import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/custom_dialog_setting.dart';
import 'package:tinder_clone_app/components/my_item_list_user.dart';
import 'package:tinder_clone_app/controllers/user_controller.dart';
import 'package:tinder_clone_app/models/user_modal.dart';
import 'package:tinder_clone_app/screens/home/details_user.dart';
import 'package:tinder_clone_app/screens/home/list_all_user_page.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_image.dart';
import 'package:tinder_clone_app/screens/home/views/tabs_profile/tab_profile_story.dart';
import 'package:tinder_clone_app/screens/login/login_page.dart';
import 'package:tinder_clone_app/utils/add_data_store.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';
import 'package:tinder_clone_app/utils/pick_image.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  final UserController userController = Get.put(UserController());
  bool isRowVisible = false;
  bool isRowVisible2 = true;
  bool isShowingDialog = true;
  bool _isFirstTabSelected = true;
  Uint8List? _imgAvatar;

    void toggleRowVisibility() {
      setState(() {
        isRowVisible = !isRowVisible;
      });
      userController.refreshGetUserList();
    }
    void toggleRowVisibility2() {
      setState(() {
        isRowVisible2 = !isRowVisible2;
      });
    }
    Future<void> _updateImage() async{
       Uint8List img = await pickImage(ImageSource.gallery);
       setState(() {
         if(img != null){
           _imgAvatar = img;
         }
       });
       await StoreData().updateDataImage(userId: userController.userData.value!.uid, file: _imgAvatar!);
     }


  void _showDialogSetting(BuildContext context) {
    CustomDialogSetting.show(context,(){ userController.logOut(context);});
  }

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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(Icons.filter_list_rounded,
                    size: 30, color: Color.fromRGBO(199, 60, 113, 100)),
                onPressed: () {_showDialogSetting(context);},
              ),
            ),
          ],
        ),
        body: GetBuilder<UserController>(builder: (controller) {
               User? user = controller.currentUser.value;
               UserModal? userData = controller.userData.value;

              if (user != null && userData != null) {
                String username = userData.name;
                String story = userData.story;
                List<String> followingList = userData.followingList;
                List<String> followersList = userData.followersList;

                return  SingleChildScrollView(
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
                            child: Stack(
                              children: [
                                // Avatar image
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    image: userData.avatar.length == 0 ? DecorationImage(
                                      image: AssetImage(AppAssets.iconAvatar),
                                      fit: BoxFit.cover,
                                    ):  DecorationImage(
                                      image: NetworkImage(userData.avatar) ,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Camera icon
                                Positioned(
                                  bottom: 0,
                                  right: 15,
                                  child: InkWell(
                                    onTap:() => _updateImage(),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.white,
                                        size: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                        followersList.length.toString() ?? '0',
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
                                        followingList.length.toString() ?? '0',
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
                              username,
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
                              story ?? '',
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
                                      Color.fromRGBO(234, 64, 128, 100),
                                      Color.fromRGBO(238, 128, 95, 100)
                                    ]),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('Chỉnh sửa trang cá nhân',
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
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(234, 64, 128, 100),
                                      Color.fromRGBO(238, 128, 95, 100)
                                    ]),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Chia sẻ trang cá nhân',
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
                                              onFollow: () => userController.onFollowUser(userData, userController.users[i].name),
                                              textFollow: followersList.contains(userController.users[i].uid) ? 'Hủy theo dõi' : 'Theo dõi',
                                              onClose: (){}
                                          ),
                                        )
                                  ],
                                  ),
                                ),
                              ),
                             ],

                           )
                         ),

                      Padding(
                        padding: const EdgeInsets.only(top: 18, left: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tin nổi bật', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                                InkWell(
                                  onTap: toggleRowVisibility2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 18),
                                    child: isRowVisible2 ? Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black45,): Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black45,),
                                  ),
                                )

                              ],
                            ),
                            Visibility(
                              visible: isRowVisible2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Giữ tin bạn yêu thích trên trang cá nhân',),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  margin: EdgeInsets.only(top: 15),
                                                  decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.black38,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                  child: Icon(Icons.add),
                                              ),
                                              const SizedBox(height: 3),
                                              Text('Mới'),
                                            ],
                                          ),
                                          for(int i = 0; i < 5; i++)
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  margin: EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ],

                        ),
                      ),

                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isFirstTabSelected = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: _isFirstTabSelected ? Colors.black : Colors.grey.shade300,
                                          width:  _isFirstTabSelected ? 2 : 1,
                                      ),
                                    ),
                                  ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 8),
                                        child: Icon(Icons.list_alt_sharp, color: _isFirstTabSelected ? Colors.black : Colors.grey.shade400, size: 30,),
                                      ),
                                    ),
                                  ),

                                  ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isFirstTabSelected = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: !_isFirstTabSelected ? Colors.black : Colors.grey.shade300,
                                          width: !_isFirstTabSelected ? 2 : 1,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 8),
                                        child: Icon(Icons.person_pin_outlined, color: !_isFirstTabSelected ? Colors.black : Colors.grey.shade400, size: 30,),
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child:  _isFirstTabSelected ? StoryTab(title: 'Ghi lại khoảnh khắc với bạn bè', content: 'Hãy tạo bài viết đầu tiên của bạn',) : StorageTab(title: 'Ảnh và video có mặt bạn', content: 'Khi mọi người gắn thẻ bạn trong ảnh và video, ảnh và video đó sẽ xuất hiện ở đây.',),
                      ),


                    ],
                  ),
                ),

              );
              }else {
                return Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: Color.fromRGBO(234, 64, 128, 100),
                    size: 80,
                  ),
                );
              }
        }),

      );

  }
}
