import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/edit_profile_screen/provider.dart';
import 'package:trashi/utils/commons.dart';

class EditProfile extends StatefulWidget {
  static const String PATH = "edit_profile";
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _emailOrPhoneFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  TextEditingController _usernameEditingController = TextEditingController();
  TextEditingController _emailOrPhoneEditingController =
      TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditProfileScreenProvider>().fetchData();
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _emailOrPhoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _usernameEditingController.text =
        context.watch<EditProfileScreenProvider>().name != null
            ? context.read<EditProfileScreenProvider>().name
            : "";
    _emailOrPhoneEditingController.text =
        context.watch<EditProfileScreenProvider>().emailOrPhone != null
            ? context.read<EditProfileScreenProvider>().emailOrPhone
            : "";
    _passwordEditingController.text =
        context.watch<EditProfileScreenProvider>().password != null
            ? context.read<EditProfileScreenProvider>().password
            : "";
    return Layout(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit Profile",
              style: TextStyle(
                  color: hexToColor("#4D4D4D"),
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            Container(
              height: 16,
            ),
            Center(
              child: ClipOval(
                  child: Container(
                      height: 64,
                      width: 64,
                      color: Colors.white,
                      child: Image.asset("assets/images/Icon_success.png"))),
            ),
            Container(
              height: 12,
            ),
            Center(
              child: Text(
                "Adista Lailin",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              height: 4,
            ),
            Center(
              child: Text(
                "Masyarakat Umum",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              height: 24,
            ),
            Text("Name"),
            Container(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: hexToColor("#F2F2F2"),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: hexToColor("#DFDFDF")),
              ),
              child: TextField(
                enabled: false,
                focusNode: _usernameFocusNode,
                controller: _usernameEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            ),
            Container(
              height: 16,
            ),
            Text("Email"),
            Container(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: hexToColor("#DFDFDF")),
              ),
              child: TextField(
                focusNode: _emailOrPhoneFocusNode,
                controller: _emailOrPhoneEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            ),
            Container(
              height: 16,
            ),
            Text("Password"),
            Container(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: hexToColor("#DFDFDF")),
              ),
              child: TextField(
                obscureText: !context
                    .watch<EditProfileScreenProvider>()
                    .isPasswordVisible,
                focusNode: _passwordFocusNode,
                controller: _passwordEditingController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () => context
                          .read<EditProfileScreenProvider>()
                          .setPasswordVisible(!context
                              .read<EditProfileScreenProvider>()
                              .isPasswordVisible),
                      icon: context
                              .watch<EditProfileScreenProvider>()
                              .isPasswordVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off)),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
