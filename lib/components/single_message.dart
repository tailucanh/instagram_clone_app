import 'package:flutter/material.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final String imageUrl;


  const SingleMessage({
    required this.message,
    required this.isMe,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          child: isMe ? Row(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:  isMe ? Colors.blueAccent : Colors.grey
                  ),
                  child: Text(message,style: TextStyle(color: Colors.white, fontSize: 17),)
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10,top: 18),
                child: Icon(Icons.check_circle, size: 15, color: Colors.blueAccent,),
              )
            ],
          
          ):
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                    ),
                  image: imageUrl.length > 0 ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ):  DecorationImage(
                    image: AssetImage(AppAssets.iconAvatar) ,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:  isMe ? Colors.blueAccent : Colors.grey
                  ),
                  child:
                  Text(message,style: TextStyle(color: Colors.white, fontSize: 15),))
            ],
          ),
        ),
      ],
    );
  }
}
