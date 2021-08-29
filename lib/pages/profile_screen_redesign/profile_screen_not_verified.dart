import 'package:flutter/material.dart';
import 'package:trashi/pages/profile_screen_redesign/provider.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/components/waiting_for_document_confirmation_component.dart';
import 'package:provider/provider.dart';

class ProfileScreenNotVerified extends StatelessWidget {
  static const String PATH = "profileexample";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.notifications_none,
                size: 26.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ProfileScreenProvider>().fetchData();
          },
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height -
                      5.5 * MediaQuery.of(context).padding.top,
                  child: WaitingForDocumentConfirmationComponent())),
        ),
      ),
    );
  }
}
