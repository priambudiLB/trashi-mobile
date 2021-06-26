import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/pages/navbar_screen/bottom_navbar.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';

class PopUpSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!context.watch<OTP>().popUpSuccessOpen) return Container();
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(80, 151, 97, 0.4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Container(
            width: double.infinity,
            height: 320,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Container(
                  height: 40,
                ),
                Image.asset("assets/images/Icon_success.png"),
                Container(
                  height: 20,
                ),
                Material(
                  color: Colors.white,
                  child: Text(
                    "Success",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: hexToColor("#4D4D4D")),
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: Text(
                    "Dokumen anda berhasil kami terima.\nMohon bersabar untuk menunggu proses\nvalidasi dari admin.",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: hexToColor("#909090")),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    child: Button(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavScreen(
                              navIndex: 2,
                              isVerified: false,
                            ),
                          ),
                        );
                      },
                      title: "Done",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
