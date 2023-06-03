import 'package:flutter/material.dart';

class StoryTab extends StatefulWidget {
  final String title;
  final String content;

  StoryTab({Key? key, required this.title, required this.content }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StoryTabState();
}

class _StoryTabState extends State<StoryTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 10),
        Text(widget.content, style: TextStyle(color: Colors.blueAccent, fontSize: 14, fontWeight: FontWeight.w600),
          overflow: TextOverflow.clip,
          softWrap: true,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}
