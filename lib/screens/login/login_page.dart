import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tinder_clone_app/components/my_button.dart';
import 'package:tinder_clone_app/components/my_textfield.dart';
import 'package:tinder_clone_app/components/my_notification_view.dart';
import 'package:tinder_clone_app/screens/home/main_wrapper.dart';
import 'package:tinder_clone_app/screens/register/register_page.dart';
import 'package:tinder_clone_app/utils/app_assets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passToggle = true;
  bool isLoading = false;

  Future<void> userLogin() async {
    if (_emailController.text.toString().isEmpty) {
      showNotificationErr(message: 'Hãy nhập email');
    } else if (!isValidEmail(_emailController.text)) {
      showNotificationErr(message: 'Email sai định dạng');
    } else if (_passwordController.text.toString().isEmpty) {
      showNotificationErr(message: 'Hãy nhập mật khẩu');
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (userCredential.user != null) {
          showNotificationSuccess(message: 'Đăng nhập thành công!');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainWrapper()),
              (route) => false);
        } else {
          showNotificationErr(
              message: 'Đăng nhập thất bại. Vui lòng kiểm tra lại thông tin!');
        }
      } catch (error) {
        showNotificationErr(
            message: 'Đăng nhập thất bại. Vui lòng kiểm tra lại thông tin');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isValidEmail(String email) {
    String pattern =
        r'^[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*$';

    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                        const SizedBox(height: 20),
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
                          'Ứng dụng hẹn hò, kết bạn đa đạng và thú vị',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 53, 53, 53)),
                        ),
                        const SizedBox(height: 65),
                        MyTextField(
                          textInputType: TextInputType.emailAddress,
                          controller: _emailController,
                          hintText: 'Nhập email',
                          obscureText: false,
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 12),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Quên mật khẩu?',
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 68, 68, 68),
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 40),
                        MyButton(title: 'Đăng nhập', onTap: userLogin),
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Bạn chưa có tài khoản?',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()),
                                    (route) => false);
                              },
                              child: const Text(
                                'Đăng kí ngay?',
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
