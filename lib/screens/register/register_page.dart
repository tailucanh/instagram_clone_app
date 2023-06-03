import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/my_button.dart';
import 'package:tinder_clone_app/components/my_textfield.dart';
import 'package:tinder_clone_app/components/my_notification_view.dart';
import 'package:tinder_clone_app/models/user_modal.dart';
import 'package:tinder_clone_app/screens/home/main_wrapper.dart';
import 'package:tinder_clone_app/screens/login/login_page.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool passToggle = true;
  final _phoneController = TextEditingController();
  int? _selectedGender;
  DateTime? selectedDate;
  bool isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> userRegister() async {
    if (_nameController.text.toString().isEmpty ||
        _nameController.text.toString().length < 2) {
      showNotificationErr(message: "Hãy nhập họ tên trên 2 kí tự");
    } else if (_selectedGender == null) {
      showNotificationErr(message: "Hãy chọn giới tính");
    } else if (selectedDate == null) {
      showNotificationErr(message: "Hãy chọn ngày sinh");
    } else if (_phoneController.text.toString().isEmpty) {
      showNotificationErr(message: "Hãy nhập số điện thoại.");
    } else if (!isValidPhoneNumber(_phoneController.text)) {
      showNotificationErr(message: "Số điện thoại sai định dạng");
    } else if (!isValidEmail(_emailController.text)) {
      showNotificationErr(message: "Hãy nhập email đúng định dạng.");
    } else if (_passwordController.text.toString().isEmpty) {
      showNotificationErr(message: "Hãy nhập mật khẩu");
    } else if (_passwordController.text.toString().length < 4) {
      showNotificationErr(message: "Hãy nhập mật khẩu nhiều hơn 4 kí tự");
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        UserModal user = UserModal.fromFirebase(
          userCredential,
          _nameController.text,
          '',
          selectedDate.toString().substring(0, 10),
          _phoneController.text,
          _selectedGender.toString(),
          '',
          _passwordController.text,
          getCurrentDate(),
          [],
          [],
        );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .set(user.toJson())
            .then((value) {
          showNotificationSuccess(message: "Đăng kí người dùng thành công");

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainWrapper()),
              (route) => false);
        });
      } catch (error) {
        if (error is FirebaseAuthException) {
          switch (error.code) {
            case 'email-already-in-use':
              showNotificationErr(
                  message: "Email đã được sử dụng bởi người dùng khác");
              break;
            default:
              showNotificationErr(message: "Đăng ký người dùng thất bại");
              break;
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isValidPhoneNumber(String phoneNumber) {
    String pattern =
        r'^(0|84)(2(0[3-9]|1[0-6|8|9]|2[0-2|5-9]|3[2-9]|4[0-9]|5[1|2|4-9]|6[0-3|9]|7[0-7]|8[0-9]|9[0-4|6|7|9])|3[2-9]|5[5|6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])([0-9]{7})$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phoneNumber);
  }

  bool isValidEmail(String email) {
    String pattern =
        r'^[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*$';

    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  void showNotificationErr({
    required String message,
  }) {
    Overlay.of(context).insert(
      OverlayEntry(
        builder: (context) => NotificationView(
          message: message,
          colorView: Colors.red,
          iconData: Icons.warning,
        ),
      ),
    );
  }

  void showNotificationSuccess({
    required String message,
  }) {
    Overlay.of(context).insert(
      OverlayEntry(
        builder: (context) => NotificationView(
          message: message,
          colorView: Colors.green,
          iconData: Icons.check_circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: Color.fromRGBO(234, 64, 128, 100),
                size: 100,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: padding.top),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.iconTinder,
                              width: 70,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Tinder',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Hãy đăng kí để hẹn hò cùng nhau',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 53, 53, 53)),
                        ),
                        const SizedBox(height: 30),
                        MyTextField(
                          textInputType: TextInputType.name,
                          controller: _nameController,
                          hintText: 'Nhập họ và tên',
                          obscureText: false,
                          iconData: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            // Widget left
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text('Giới tính',
                                          style: TextStyle(
                                            fontSize: 17,
                                          )),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: _selectedGender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedGender = value;
                                                  });
                                                },
                                                activeColor: Color.fromRGBO(
                                                    234, 64, 128, 100),
                                              ),
                                              const Text('Nam',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Radio(
                                                value: 2,
                                                groupValue: _selectedGender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedGender = value;
                                                  });
                                                },
                                                activeColor: Color.fromRGBO(
                                                    234, 64, 128, 100),
                                              ),
                                              const Text('Nữ',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Radio(
                                                value: 3,
                                                groupValue: _selectedGender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedGender = value;
                                                  });
                                                },
                                                activeColor: Color.fromRGBO(
                                                    234, 64, 128, 100),
                                              ),
                                              const Text('Khác',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              // Widget right
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text('Ngày sinh',
                                          style: TextStyle(
                                            fontSize: 17,
                                          )),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: Color.fromRGBO(
                                                    234, 64, 128, 100),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                selectedDate != null
                                                    ? DateFormat('yyyy/MM/dd')
                                                        .format(selectedDate!)
                                                    : 'Chọn ngày',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          textInputType: TextInputType.phone,
                          controller: _phoneController,
                          hintText: 'Nhập số điện thoại',
                          obscureText: false,
                          iconData: Icons.phone,
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          textInputType: TextInputType.emailAddress,
                          controller: _emailController,
                          hintText: 'Nhập email',
                          obscureText: false,
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          textInputType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          hintText: 'Nhập mật khẩu',
                          obscureText: passToggle,
                          iconData: Icons.lock,
                          inkWell: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(
                              passToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromRGBO(234, 64, 128, 100),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        MyButton(title: 'Đăng kí ngay', onTap: userRegister),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Bạn đã có tài khoản?',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (route) => false);
                              },
                              child: const Text(
                                'Đăng nhập?',
                                style: TextStyle(
                                    fontSize: 19,
                                    decoration: TextDecoration.underline,
                                    color: Color.fromARGB(255, 68, 68, 68),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
