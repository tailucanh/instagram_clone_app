import 'package:flutter/material.dart';

class VideoTab extends StatelessWidget {
  const VideoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Short Video",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        const SizedBox(height: 10,),
        const Icon(
          Icons.video_call,
          size: 60,
        ),
      ],
    );
  }
}
