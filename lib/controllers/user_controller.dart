import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder_clone_app/components/my_dialog.dart';
import 'package:tinder_clone_app/models/user_modal.dart';
import 'package:tinder_clone_app/screens/home/details_user.dart';
import 'package:tinder_clone_app/screens/login/login_page.dart';

class UserController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null);
  Rx<UserModal?> userData = Rx<UserModal?>(null);

  final users = <UserModal>[].obs;

  late final String? getUid;

  @override
  void onInit() {
    super.onInit();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
      currentUser.value = user;
      if (user != null) {
        getUserData(user.uid);
        getUid = user.uid;
      }
    });

  }

  Future<void> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (snapshot.exists) {
        userData.value = UserModal.fromMap(snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu người dùng: $e');
    }
  }


  Future<void> refreshGetUserList() async {
    try {
      List<UserModal> userList = await getListUserOther();
      users.assignAll(userList);
    } catch (e) {
      print('Lỗi khi lấy danh sách người dùng: $e');
    }
  }


  Future<UserModal?> getUserById(String userId) async {
    try {
      List<UserModal> userList = await getUserListAllFromFirestore();
      UserModal user = userList.firstWhere((user) => user.uid == userId);
      return user;

    } catch (e) {
      print('Lỗi khi lấy thông tin người dùng: $e');

    }
  }


  Future<List<UserModal>> getListUserOther() async {
    try {
      List<UserModal> userListAll = await getUserListAllFromFirestore();
      List<UserModal> getListUser = userListAll.where((user) => user.uid != getUid).toList();

      return getListUser;
    } catch (e) {
      print('Lỗi khi lấy danh sách người dùng: $e');
      return [];
    }
  }




  Future<List<UserModal>> getUserListAllFromFirestore() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      List<UserModal> userListAll = snapshot.docs
          .map((doc) => UserModal.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return userListAll;
    } catch (e) {
      print('Lỗi khi lấy danh sách người dùng: $e');
      return [];
    }
  }

  Future<void> showDetailsUser(BuildContext context, String uid) async {
    UserModal? user = await getUserById(uid);
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsUserPage(userData: user),
        ),
      );
    }
  }


  void onFollowUser(UserModal user, String otherUserId){
    if (user.followingList.contains(otherUserId)) {
      // Đã theo dõi, hủy follow
      unfollowUser(user,otherUserId);
    } else {
      // Chưa theo dõi, thực hiện follow
      followUser(user,otherUserId);
    }
  }




  void followUser(UserModal user, otherUserId) {
    // Thêm otherUserId vào danh sách "đang theo dõi" của bạn
    user.followingList.add(otherUserId);

    // Thêm yourUserId vào danh sách "người theo dõi" của người khác
    UserModal otherUser = getUserById(otherUserId) as UserModal;
    if (otherUser != null) {
      otherUser.followersList.add(user.uid);
    }
    updateUserOnFirebase(user);
    updateUserOnFirebase(otherUser);
  }

  void unfollowUser(UserModal user, String otherUserId) {
    // Xóa otherUserId khỏi danh sách "đang theo dõi" của bạn
    user.followingList.remove(otherUserId);

    // Xóa yourUserId khỏi danh sách "người theo dõi" của người khác
    UserModal otherUser = getUserById(otherUserId) as UserModal;

    if (otherUser != null) {
      otherUser.followersList.remove(user.uid);
    }

    updateUserOnFirebase(user);
    updateUserOnFirebase(otherUser);
  }
  void updateUserOnFirebase(UserModal user) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update(user.toJson())
        .then((value) {
      print('Cập nhật dữ liệu người dùng thành công');
    }).catchError((error) {
      print('Lỗi khi cập nhật dữ liệu người dùng: $error');
    });
  }



  void logOut(BuildContext context) {
    _showDialog(context, "Đăng xuất", "Xác nhận đăng xuất khỏi ứng dụng",Icons.logout, (){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
            (route) => false,
      );

    });
  }


  void _showDialog(BuildContext context, String title, String content,IconData icon, Function() onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialog(title: title, content: content, icon: icon, onConfirm: onConfirm);
      },
    );
  }





}
