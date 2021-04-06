import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';

class AuthenticationInput extends StatefulWidget {
  final String widgetKey;
  final TextInputType textInputType;
  final String svgImage;
  final String hintText;
  final String errorText;
  final bool isValid;
  final Function onChanged;
  final bool isPassword;

  const AuthenticationInput({
    Key key,
    this.widgetKey,
    this.textInputType,
    this.svgImage,
    this.hintText,
    this.errorText,
    this.isValid,
    this.onChanged,
    this.isPassword = false,
  }) : super(key: key);
  @override
  _AuthenticationInput createState() => _AuthenticationInput();
}

class _AuthenticationInput extends State<AuthenticationInput> {
  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(100));
    return TextField(
      key: Key(widget.widgetKey),
      onChanged: widget.onChanged,
      keyboardType: widget.textInputType,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
          isDense: true,
          prefixIcon: new Padding(
            padding: const EdgeInsets.only( top: 13, left: 0, right: 0, bottom: 13),
            child: new SizedBox(
                height: 1,
                child: SvgPicture.asset(widget.svgImage)
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: borderRadius
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: borderRadius
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: borderRadius
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: borderRadius
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 14, color: Colors.black.withOpacity(0.5)),
          contentPadding: EdgeInsets.all(0),
          errorText: widget.isValid ?  null : widget.errorText,
          errorStyle: TextStyle(
              fontSize: 11
          )
      ),
    );
  }
}
