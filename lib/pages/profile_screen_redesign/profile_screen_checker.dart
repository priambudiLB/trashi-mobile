import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:trashi/pages/profile_screen_redesign/profile_screen_not_verified.dart';
import 'package:trashi/pages/profile_screen_redesign/profile_screen_new.dart';
import 'package:trashi/pages/profile_screen_redesign/provider.dart';
import 'package:provider/provider.dart';

class ProfileScreenChecker extends StatefulWidget {
  const ProfileScreenChecker({Key key}) : super(key: key);

  @override
  _ProfileScreenCheckerState createState() => _ProfileScreenCheckerState();
}

class _ProfileScreenCheckerState extends State<ProfileScreenChecker> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileScreenProvider>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<ProfileScreenProvider>().statusFetchData ==
        FormzStatus.submissionSuccess) {
      if (context.watch<ProfileScreenProvider>().isAcc <= 2)
        return ProfileScreenNotVerified();
      else
        return ProfileScreenVerified();
    }

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
