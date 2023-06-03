import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String content;
  final IconData? icon;
  final Function() onConfirm;


  const MyDialog({super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.onConfirm,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey),
      ),
      title: Row(
        children: [
          if (icon != null) Icon(icon, color:  Color.fromRGBO(234, 64, 128, 100),size: 30,),
          if (icon != null) SizedBox(width: 8.0),
          Text(title),
        ],
      ),
      content: Text(content),
      actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Hủy', style: TextStyle(color: Colors.black),),
          ),
        if (onConfirm != null)
          ElevatedButton(
            onPressed:() {onConfirm();},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(234, 64, 128, 100)),
            ),
            child: Text('Xác nhận', style: TextStyle(color: Colors.white),),
          ),
      ],
    );
  }
}
