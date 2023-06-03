import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/mesage_textfield.dart';
import 'package:tinder_clone_app/components/single_message.dart';

import 'package:tinder_clone_app/controllers/user_controller.dart';
import 'package:tinder_clone_app/models/message_modal.dart';
import 'package:tinder_clone_app/models/user_modal.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';


class ChatScreen extends StatefulWidget {

  final UserModal userData;
  final String currentId;
  ChatScreen({Key? key, required this.userData, required this.currentId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final UserController userController = Get.put(UserController());


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
            color: Colors.grey.shade800
        ),
        title: Row(
          children: [
              Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image:  widget.userData.avatar.length > 0 ? DecorationImage(
                  image: NetworkImage(widget.userData.avatar),
                  fit: BoxFit.cover,
                ): DecorationImage(
                  image: AssetImage(AppAssets.iconAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                widget.userData.name ?? '',
                style: TextStyle(color: Colors.black ,fontSize: 18) ,overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.call,
                      size: 25, color: Colors.black54),
                  onPressed: () {},
                ),
                Stack(
                  children: [
                    Container(
                      child:  IconButton(
                        icon: Icon(Icons.video_call_outlined,
                            size: 35, color:  Colors.black54),
                        onPressed: () {},
                      ),
                    ),

                    // Avatar image
                    // Camera icon
                    Positioned(
                      top: 12,
                      right: 8,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          shape: BoxShape.circle,
                        ),

                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
      body:  Padding(
        padding:  EdgeInsets.only(bottom: padding.bottom),
        child: Column(
          children: [
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('users').doc(widget.currentId).collection('messages').doc(widget.userData.uid).collection('chats')
                            .orderBy("date", descending: true).snapshots(),
                         builder: (context, AsyncSnapshot snapshot) {
                           if(snapshot.hasData){
                             if(snapshot.data.docs.length < 1){
                               return Center(
                                 child: Text('Hãy làm quen với nhau', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                               );
                             }
                             return ListView.builder(
                                 itemCount: snapshot.data.docs.length,
                                 reverse: true,
                                 physics: BouncingScrollPhysics(),
                                 itemBuilder: (context,index){
                                   bool isMe = snapshot.data.docs[index]['senderId'] == widget.currentId;
                                   return SingleMessage(message: snapshot.data.docs[index]['message'], isMe: isMe, imageUrl: widget.userData.avatar,);

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
                    )
                ),
            ),
            MessageTextField(currentId: widget.currentId,friendId: widget.userData.uid,),
          ],
         ),
      ),
    );
  }
}
