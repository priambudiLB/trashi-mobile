import 'package:flutter/material.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/pages/edit_profile_screen/edit_profile_screen.dart';
import 'package:trashi/pages/onboarding_redesign_screen/on_boarding_screen_view.dart';
import 'package:trashi/pages/profile_screen_redesign/provider.dart';
import 'package:trashi/pages/profile_screen_redesign/role_type.dart';
import 'package:trashi/pages/request_screen/request_screen.dart';
import 'package:trashi/pages/retribution_screen/retribution_screen.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/accept_trash_collection_request_screen.dart';
import 'package:trashi/secure_storage/secure_storage.dart';
import 'package:trashi/utils/commons.dart';

import 'package:provider/provider.dart';

class ProfileScreenRedesign extends StatefulWidget {
  static const String PATH = "profile_redesign";

  @override
  _ProfileScreenRedesignState createState() => _ProfileScreenRedesignState();
}

class _ProfileScreenRedesignState extends State<ProfileScreenRedesign> {
  bool isSignOutSuccessful = false;
  SecureStorage _secureStorage = SecureStorage();

  Future<void> _signOut() async {
    showTrashiProgressIndicator(context);

    final response = await ApiProvider().signOut();

    if (response != null) {
      isSignOutSuccessful = true;
    }

    closeTrashiProgressIndicator(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileScreenProvider>().fetchData();
    });
    printMethod();
  }

  void printMethod() async {
    // can be deleted later. for testing purposes
    SignInByPhoneResponse signInByPhoneResponse =
        await _secureStorage.getSignInByPhoneResponse();

    SignInResponse signInResponse = await _secureStorage.getSignInResponse();

    if (signInByPhoneResponse != null) print(signInByPhoneResponse.phone);

    if (signInResponse != null) print(signInResponse.email);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          ProfileHeader(size: size),
          context.watch<ProfileScreenProvider>().roleType == RoleType.PERSONAL
              ? ItemTileProfile(
                  icon: Icons.text_snippet_outlined,
                  ontap: () {},
                  title: "Daftar Harga Pengangkatan",
                )
              : Container(),
          Container(
            height: context.watch<ProfileScreenProvider>().roleType ==
                    RoleType.PERSONAL
                ? 1
                : 0,
            margin: EdgeInsets.symmetric(horizontal: 24),
            color: hexToColor("#DFDFDF"),
          ),
          ItemTileProfile(
            icon: Icons.lock_outline,
            ontap: () {},
            title: "Privacy",
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 24),
            color: hexToColor("#DFDFDF"),
          ),
          ItemTileProfile(
              icon: Icons.settings_outlined,
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                ).then((value) =>
                    context.read<ProfileScreenProvider>().fetchData());
              },
              title: "Setting"),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 24),
            color: hexToColor("#DFDFDF"),
          ),
          ItemTileProfile(
              icon: Icons.logout,
              ontap: () async {
                await _signOut();

                if (isSignOutSuccessful) {
                  print('log out');
                  await _secureStorage.deleteAll();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnboardingScreen(),
                    ),
                  );
                }
              },
              title: "Logout"),
        ],
      ),
    );
  }
}

class ItemTileProfile extends StatelessWidget {
  const ItemTileProfile({
    Key key,
    @required this.icon,
    @required this.ontap,
    @required this.title,
  }) : super(key: key);

  final IconData icon;
  final Function ontap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: hexToColor(MAIN_COLOR),
            ),
            Container(
              width: 18,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          context.watch<ProfileScreenProvider>().roleType != RoleType.PERSONAL
              ? 420
              : 300,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            child: Image.asset(
              "assets/images/${context.watch<ProfileScreenProvider>().roleType != RoleType.PERSONAL ? 'large_green_background.png' : 'small_green_background.png'}",
              width: size.width,
            ),
          ),
          Positioned(
              left: 24,
              top: 58,
              child: Text(
                "Hello, ${context.watch<ProfileScreenProvider>().name.length > 12 ? context.watch<ProfileScreenProvider>().name.substring(0, 12) + "..." : context.watch<ProfileScreenProvider>().name}",
                overflow: TextOverflow.ellipsis,
                softWrap: false,
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
                    size: 32.0,
                    color: Colors.white,
                  ),
                  Container(
                    width: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(),
                        ),
                      );
                    },
                    child: ClipOval(
                        child: Container(
                            height: 30,
                            width: 30,
                            color: Colors.white,
                            child: Image.asset("assets/images/dummy_dp.png"))),
                  ),
                ],
              )),
          Positioned(
              top: 160,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                width: size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RetributionScreen(),
                              ),
                            );
                          },
                          child: Container(
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
                                ClipOval(
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    height: 32,
                                    width: 32,
                                    color: hexToColor(MAIN_COLOR),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/wallet_icon.png",
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                  ),
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
                        ),
                        InkWell(
                          onTap: () {
                            if (context
                                    .read<ProfileScreenProvider>()
                                    .roleType ==
                                RoleType.ADMIN)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AcceptTrashCollectionRequestScreen(),
                                ),
                              );
                            else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RequestScreen(),
                                ),
                              );
                            }
                          },
                          child: Container(
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
                                  ClipOval(
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      height: 32,
                                      width: 32,
                                      color: hexToColor(MAIN_COLOR),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/bag_icon.png",
                                          width: 15,
                                          height: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 12,
                                  ),
                                  Text(
                                    "Request\nPengangkatan",
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: context.watch<ProfileScreenProvider>().roleType !=
                              RoleType.PERSONAL
                          ? 16
                          : 0,
                    ),
                    context.watch<ProfileScreenProvider>().roleType !=
                            RoleType.PERSONAL
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  print('on tap daftar harga');
                                },
                                child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          height: 32,
                                          width: 32,
                                          color: hexToColor(MAIN_COLOR),
                                          child: Center(
                                            child: Icon(
                                              Icons.text_snippet_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 12,
                                      ),
                                      Text(
                                        "Daftar Harga\nPengangkatan",
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  print('on tap buat donasi');
                                },
                                child: Container(
                                    height: 115,
                                    width: 148,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              4), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            padding: EdgeInsets.all(6),
                                            height: 32,
                                            width: 32,
                                            color: hexToColor(MAIN_COLOR),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/donate_icon.png",
                                                width: 15,
                                                height: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 12,
                                        ),
                                        Text(
                                          "Buat\nDonasi",
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
