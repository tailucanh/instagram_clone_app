import 'package:flutter/material.dart';

class ShortVideoTab extends StatefulWidget {
  final String title;


  ShortVideoTab({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShortVideoTabState();
}

class _ShortVideoTabState extends State<ShortVideoTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}
