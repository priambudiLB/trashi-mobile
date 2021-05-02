import 'package:flutter/material.dart';
import 'package:trashi/pages/confirmation_otp_screen/components/confirmation_otp_body.dart';
import 'package:provider/provider.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/verification.dart';

class ConfirmationOTPScreen extends StatefulWidget {
  static const String PATH = "confirmation_otp";
  final Verification verification;
  final String account;

  const ConfirmationOTPScreen(
      {Key key, @required this.verification, @required this.account})
      : super(key: key);

  @override
  _ConfirmationOTPScreenState createState() => _ConfirmationOTPScreenState();
}

class _ConfirmationOTPScreenState extends State<ConfirmationOTPScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OTP>().setAccount(widget.account);
      context.read<OTP>().setVerificationOption(widget.verification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
        ),
        body: ConfirmationOTPBody());
  }
}
