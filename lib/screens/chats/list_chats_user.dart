import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/mesage_textfield.dart';
import 'package:tinder_clone_app/components/single_message.dart';

import 'package:tinder_clone_app/controllers/user_controller.dart';
import 'package:tinder_clone_app/models/message_modal.dart';
import 'package:tinder_clone_app/models/user_modal.dart';
import 'package:tinder_clone_app/screens/chats/chats_page.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';


class ListsChatScreen extends StatefulWidget {


  ListsChatScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListsChatScreenState();
}

class _ListsChatScreenState extends State<ListsChatScreen> {
  final UserController userController = Get.put(UserController());

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
  void dispose() {
    super.dispose();
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
              userController.userData.value!.name ?? '',
              style: TextStyle(color: Colors.black ,fontSize: 18) ,overflow: TextOverflow.ellipsis,
            ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.video_call_outlined,
                      size: 30, color: Colors.black54),
                  onPressed: () {},
                ),
                Container(
                  child:  IconButton(
                    icon: Icon(Icons.edit_note_outlined,
                        size: 30, color:  Colors.black54),
                    onPressed: () {},
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
      body:  Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
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
              padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                  children: [
                    // Avatar image
                    Container(
                      margin: EdgeInsets.only(left: 15,bottom: 5),
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        image:  userController.userData.value!.avatar.length > 0 ? DecorationImage(
                          image: NetworkImage(userController.userData.value!.avatar),
                          fit: BoxFit.cover,
                        ): DecorationImage(
                          image: AssetImage(AppAssets.iconAvatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Camera icon
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                  Text('Ghi chú của bạn', style: TextStyle(color: Colors.grey.shade600, fontSize: 12),)
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 5,bottom: 15,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Tin nhắn', style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w600),),
                        Icon(Icons.info_outline, color: Colors.grey.shade600,size: 15,)
                      ],
                    ),
                    Text('Tin nhắn chờ',style: TextStyle(color: Colors.blueAccent, fontSize: 16,fontWeight: FontWeight.w600),)
                  ],
                ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').doc(userController.userData.value!.uid).collection('messages').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: false,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          var friendId = snapshot.data.docs[index].id;
                          var lastMsg = snapshot.data.docs[index]['last_msg'];
                          return FutureBuilder(
                              future: FirebaseFirestore.instance.collection('users').doc(friendId).get(),
                                    builder:  (context,AsyncSnapshot asyncSnapshot){
                                    if(asyncSnapshot.hasData){
                                      var friend = asyncSnapshot.data;
                                      return ListTile(
                                        leading: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            image: friend['avatar'].length == 0 ? DecorationImage(
                                              image:AssetImage(AppAssets.iconAvatar),
                                              fit: BoxFit.cover,
                                            ): DecorationImage(
                                              image: NetworkImage(friend['avatar']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        title: Text(friend['name'],style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,color: Colors.black),),
                                        subtitle: Container(
                                          child: Text('$lastMsg', style: TextStyle(color: Colors.grey.shade600, overflow: TextOverflow.ellipsis),),
                                        ),
                                        onTap: (){
                                          getChatUser(context, friend['uid']);
                                        },
                                      );
                                    }
                                    return Center(
                                      child: LoadingAnimationWidget.threeArchedCircle(
                                        color: Color.fromRGBO(234, 64, 128, 100),
                                        size: 60,
                                      ),
                                    );
                              },
                          );

                        }
                    );
                  }
                  return Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Color.fromRGBO(234, 64, 128, 100),
                      size: 80,
                    ),
                  );
                },
              ),
            ),


          ],
         ),
      ),
    );
  }
}
