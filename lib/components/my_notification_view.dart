import 'dart:async';

import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  final String message;
  Color colorView;
  final IconData iconData;

  NotificationView(
      {required this.colorView,
      required this.message,
      required this.iconData,
      });

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  bool _isShowing = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();

    Timer(Duration(seconds: 3), () {
      _animationController.reverse().then((value) {
        setState(() {
          _isShowing = false;
        });
      });
    });
  }

  void showNotification() {
    if (!_isShowing) {
      setState(() {
        _isShowing = true;
      });

      _animationController.forward();
    }
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isShowing
        ? Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Container(
                color: widget.colorView,
                padding: EdgeInsets.only(top: 55, bottom: 30),
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.iconData,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.message,
                          style:
                              TextStyle(fontSize: 15, color: Colors.white),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : SizedBox();
  }
}
