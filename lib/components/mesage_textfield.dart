import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {

  final String currentId;
  final String friendId;

  const MessageTextField({
    super.key,
    required this.currentId,
    required this.friendId,

  });


  @override
  State<StatefulWidget> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    Future<void> sendMessage() async {
      String message = _controller.text;
      _controller.clear();
      await FirebaseFirestore.instance.collection('users').doc(widget.currentId).collection('messages').doc(widget.friendId).
      collection('chats').add({
        'senderId': widget.currentId,
        'receiverIdD': widget.friendId,
        'message': message,
        'type': "text",
        'date': DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance.collection('users').doc(widget.currentId).collection('messages').doc(widget.friendId)
        .set({
          'last_msg': message,
        });
      });
      await FirebaseFirestore.instance.collection('users').doc(widget.friendId).collection('messages').doc(widget.currentId).
      collection('chats').add({
        'senderId': widget.currentId,
        'receiverIdD': widget.friendId,
        'message': message,
        'type': "text",
        'date': DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance.collection('users').doc(widget.friendId).collection('messages').doc(widget.currentId)
            .set({
          'last_msg': message,
        });
      });
    }

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,

                ),
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5, child: TextField(
            controller: _controller,
            maxLines: null,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              hintText: 'Nhập tin nhắn',
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,

            ),
          ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                sendMessage();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,

                ),
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
