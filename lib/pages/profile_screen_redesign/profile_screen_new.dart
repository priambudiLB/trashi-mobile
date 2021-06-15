import 'package:flutter/material.dart';

class ProfileScreenRedesign extends StatelessWidget {
  static const String PATH = "profile_redesign";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 300,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  child: Image.asset(
                    "assets/images/small_green_background.png",
                    width: size.width,
                  ),
                ),
                Positioned(
                    left: 24,
                    top: 58,
                    child: Text(
                      "Hello,",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 24),
                    )),
                Positioned(
                    left: 24,
                    top: 95,
                    child: Text(
                      "Welcome to Trashi",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )),
                Positioned(
                    top: 67,
                    right: 24,
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 26.0,
                          color: Colors.white,
                        ),
                        Container(
                          width: 25,
                        ),
                        Container(
                          height: 32,
                          width: 32,
                          color: Colors.blue,
                        ),
                      ],
                    )),
                Positioned(
                    top: 144,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 115,
                            width: 148,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 32,
                                  width: 32,
                                  color: Colors.blue,
                                ),
                                Container(
                                  height: 12,
                                ),
                                Text(
                                  "Pembayaran\nRetribusi",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          Container(
                              height: 115,
                              width: 148,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 4), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 32,
                                    width: 32,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    height: 12,
                                  ),
                                  Text(
                                    "Pembayaran\nRetribusi",
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
