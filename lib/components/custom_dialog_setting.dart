import 'package:flutter/material.dart';

class CustomDialogSetting {
  static void show(BuildContext context, Function() onLogout) {
    
    OverlayEntry? overlayEntry;
     overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    overlayEntry?.remove();
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Material(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 0, bottom: 50, left: 20,right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.linear_scale_sharp, size: 40,color: Color.fromRGBO(199, 60, 113, 100),)
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.settings_rounded, color: Colors.grey.shade700,),
                                const SizedBox(width: 10,),
                                Text('Cài đặt', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 16),)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.access_time_rounded, color: Colors.grey.shade700,),
                                const SizedBox(width: 10,),
                                Text('Hoạt động của bạn', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 16),)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.lock_clock, color: Colors.grey.shade700, ),
                                const SizedBox(width: 10,),
                                Text('Kho lưu trữ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.qr_code, color: Colors.grey.shade700, ),
                                const SizedBox(width: 10,),
                                Text('Mã QR', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.star_border_rounded, color: Colors.grey.shade700, ),
                                const SizedBox(width: 10,),
                                Text('Yêu thích', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){;
                            overlayEntry?.remove();
                            onLogout();
                        },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.logout, color: Color.fromRGBO(199, 60, 113, 100), ),
                                const SizedBox(width: 10,),
                                Text('Đăng xuất', style: TextStyle(color: Color.fromRGBO(199, 60, 113, 100), fontWeight: FontWeight.w600, fontSize: 16),)
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


        );
      },
    );

    Overlay.of(context)?.insert(overlayEntry);
  }
}
