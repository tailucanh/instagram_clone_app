import 'package:flutter/material.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';

class ItemUser extends StatelessWidget {
  final String name;
  final double width;
  final Function()? onClick;
  final Function()? onClose;
  final Function()? onFollow;
  final String textFollow;
  final String imageUrl;


  const ItemUser({super.key, required this.name, required this.imageUrl,  required this.width,  required this.onClick, required this.onFollow, required this.textFollow, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width,
        height: 195,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: Colors.grey
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image:  imageUrl.length > 0 ? DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ):  DecorationImage(
                        image: AssetImage(AppAssets.iconAvatar) ,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onClose,
                  child: Icon(Icons.close,color: Colors.grey.shade700,),
                )
              ],
            ),
             const SizedBox(height: 5),
            Text(name,
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text('Gợi ý cho bạn',
              style: TextStyle(color: Colors.black54, fontSize: 13, ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: onFollow,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(47, 128, 237,100),
                    Color.fromRGBO(86, 204, 242, 100)
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    textFollow,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
