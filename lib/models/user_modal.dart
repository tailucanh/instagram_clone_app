// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class UserModal {
  String uid;
  String email;
  String name;
  String avatar;
  String birthDay;
  String sex;
  String story;
  String phone;
  String password;
  String time;

  List<String> followingList ;
  List<String> followersList ;

  UserModal({
    required this.uid,
    required this.email,
    required this.name,
     required this.avatar,
    required this.birthDay,
    required this.sex,
    required this.story,
    required this.phone,
    required this.password,
    required this.time,
    required this.followingList ,
    required this.followersList ,
  });

  factory UserModal.fromFirebase(
      UserCredential userCredential,
      String name,
      String avatar,
      String birthDay,
      String phone,
      String sex,
      String story,
      String password,
      String time,
      List<String> followingList,
      List<String> followersList ) {
    return UserModal(
      uid: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: name,
      avatar: avatar,
      birthDay: birthDay,
      phone: phone,
      sex: sex,
      story: story,
      password: password,
      time: time,
      followingList : followingList ,
      followersList : followersList ,
    );
  }
  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      uid: map['uid'],
      name: map['name'],
      avatar: map['avatar'],
      email: map['email'],
      birthDay: map['birthDay'],
      phone: map['phone'],
      sex: map['sex'],
      story: map['story'],
      password: map['password'],
      time: map['time'],
      followingList: List<String>.from(map['followingList'] ?? []),
      followersList: List<String>.from(map['followersList'] ?? []),
    );
  }
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'avatar': avatar,
        'birthDay': birthDay,
        'phone': phone,
        'sex': sex,
        'story': story,
        'password': password,
        'time': time,
        'followingList ': followingList,
        'followersList ': followersList,
      };


}
