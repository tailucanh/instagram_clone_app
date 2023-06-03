import 'package:flutter/material.dart';

class StorageTab extends StatefulWidget {
  final String title;
  final String content;

  StorageTab({Key? key, required this.title, required this.content }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StorageTabState();
}

class _StorageTabState extends State<StorageTab> {

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: Icon(Icons.person_pin_outlined, size: 40, color: Colors.grey,),
            ),
            const SizedBox(height: 10),
            Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(widget.content, style: TextStyle(color: Colors.grey.shade600, fontSize: 15,),
              overflow: TextOverflow.clip,
              softWrap: true,
              textAlign: TextAlign.center,
            ),

          ],
        ),
      );
    }

}
