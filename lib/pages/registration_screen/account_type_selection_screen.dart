import 'package:flutter/material.dart';

class AccountTypeSelectionScreen extends StatelessWidget {
  static const String PATH = "accountTypeSelection";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black)),
      elevation: 0,
    ));
  }
}
