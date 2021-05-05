import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trashi/components/layout_redesign.dart';

class RegistrationAsRTRWScreen extends StatefulWidget {
  static const String PATH = "registrationAsRTRW";

  @override
  _RegistrationAsRTRWScreenState createState() =>
      _RegistrationAsRTRWScreenState();
}

class _RegistrationAsRTRWScreenState extends State<RegistrationAsRTRWScreen> {
  _buildTextFormField(TextInputType keyboardType, String label,
      {bool obscureText = false}) {
    TextFormField textFormField = TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 15),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );

    return Column(
      children: [
        Container(
          height: 48,
          child: textFormField,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Container(
        child: Column(
          children: [
            Text(
              "Registrasi sebagai RT/RW",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              "Mohon untuk mengisi data-data di bawah ini dengan benar dan lengkap untuk mempermudah tim kami memvalidasi akun Anda.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 16,
              ),
            ),
            Container(
              child: Column(
                children: [
                  _buildTextFormField(
                    TextInputType.text,
                    "Name",
                  ),
                  _buildTextFormField(
                    TextInputType.phone,
                    "Phone Number",
                  ),
                  _buildTextFormField(
                    TextInputType.text,
                    "Password",
                    obscureText: true,
                  ),
                  _buildTextFormField(
                    TextInputType.text,
                    "Confirm Password",
                    obscureText: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
