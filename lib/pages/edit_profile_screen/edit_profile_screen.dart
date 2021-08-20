import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:provider/provider.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/edit_profile_screen/provider.dart';
import 'package:trashi/pages/profile_screen_redesign/role_type.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        child: Form(
          key: _formKey,
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
                  context.watch<EditProfileScreenProvider>().name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                height: 4,
              ),
              Center(
                child: Text(
                  context.watch<EditProfileScreenProvider>().role,
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
              TextFormField(
                enabled: context
                        .watch<EditProfileScreenProvider>()
                        .statusFetchData !=
                    FormzStatus.submissionInProgress,
                focusNode: _usernameFocusNode,
                validator: validateName,
                controller: _usernameEditingController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: hexToColor("#F2F2F2"),
                  focusColor: hexToColor("#F2F2F2"),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                ),
              ),
              Container(
                height: 16,
              ),
              Text("Email"),
              Container(
                height: 8,
              ),
              TextFormField(
                enabled: context
                        .watch<EditProfileScreenProvider>()
                        .statusFetchData !=
                    FormzStatus.submissionInProgress,
                focusNode: _emailOrPhoneFocusNode,
                controller: _emailOrPhoneEditingController,
                validator: emailOrPhoneValidator,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                ),
              ),
              Container(
                height: 16,
              ),
              Text("Password"),
              Container(
                height: 8,
              ),
              TextFormField(
                enabled: context
                        .watch<EditProfileScreenProvider>()
                        .statusFetchData !=
                    FormzStatus.submissionInProgress,
                obscureText: !context
                    .watch<EditProfileScreenProvider>()
                    .isPasswordVisible,
                focusNode: _passwordFocusNode,
                controller: _passwordEditingController,
                textAlignVertical: TextAlignVertical.center,
                validator: passwordValidatorEditProfile,
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
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: hexToColor("#DFDFDF"), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                ),
              ),
              Container(
                height: 32,
              ),
              context.watch<EditProfileScreenProvider>().statusFetchData ==
                      FormzStatus.submissionInProgress
                  ? Center(child: CircularProgressIndicator())
                  : Button(
                      width: double.infinity,
                      onTap: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        context
                            .read<EditProfileScreenProvider>()
                            .setName(_usernameEditingController.text);
                        context
                            .read<EditProfileScreenProvider>()
                            .setEmailOrPhone(
                                _emailOrPhoneEditingController.text);
                        context
                            .read<EditProfileScreenProvider>()
                            .setPassword(_passwordEditingController.text);
                        context.read<EditProfileScreenProvider>().editData();
                      },
                      title: "Edit Profile")
            ],
          ),
        ),
      ),
    );
  }

  String passwordValidatorEditProfile(String value) {
    if (value.isEmpty) {
      return null;
    }

    if (value.length < 8 || value.length > 20) {
      return 'Password harus sepanjang 8 hingga 20 karakter.';
    }
    return null;
  }

  String emailOrPhoneValidator(String value) {
    if (context.read<EditProfileScreenProvider>().roleType != RoleType.RTRW) {
      if (value.isEmpty) {
        return "Email tidak boleh kosong";
      }

      if (!isEmail(value)) {
        return "Email tidak valid";
      }
    } else {
      if (value.isEmpty) {
        return "Nomor telepon tidak boleh kosong";
      }

      if (int.tryParse(value) == null || value.length > 24) {
        return "Nomor telepon tidak valid";
      }
    }
    return null;
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return "Nama tidak boleh kosong";
    }

    List<String> names = value.trim().split(" ");
    if (names.length < 2) {
      return "Harus mengisi nama depan dan nama belakang";
    }
    String firstnameChanged = names[0];
    String lastnameChanged = names.sublist(1).join(" ");
    if (firstnameChanged.length < 8 || firstnameChanged.length > 20) {
      return 'Nama depan harus sepanjang 8 hingga 20 karakter.';
    }

    if (lastnameChanged.length < 8 || lastnameChanged.length > 20) {
      return 'Nama belakang harus sepanjang 8 hingga 20 karakter.';
    }

    return null;
  }
}
