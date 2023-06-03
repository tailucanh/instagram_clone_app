
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_clone_app/components/my_notification_view.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class StoreData{
  Future<String> uploadImageToStorage(String childName,String userId, Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child(userId);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('Link: ' +downloadUrl);
    return downloadUrl;
  }

  Future<void> updateDataImage({required String userId, required Uint8List file}) async {
    try{
       String imageUrl = await uploadImageToStorage('avatars',userId, file);
       await _firestore
           .collection('users')
           .doc(userId)
           .update({
           'avatar': imageUrl,
       });
    }catch(err){
      print('Không thay đổi được ảnh');
      NotificationView(message: 'Không thay đổi được ảnh.Đã có lỗi xảy ra.', colorView: Colors.red, iconData: Icons.error_outline_rounded,);
    }

  }




}