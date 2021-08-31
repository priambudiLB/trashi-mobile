import 'package:flutter/material.dart';
import 'package:trashi/utils/commons.dart';

class TrashiTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final String label;
  final TextEditingController controller;
  final Function(String) validator;
  final bool isPasswordField;

  TrashiTextFormField({
    this.keyboardType,
    this.label,
    this.controller,
    this.validator,
    this.isPasswordField = false,
  });

  _TrashiTextFormFieldState createState() => _TrashiTextFormFieldState();
}

@override
class _TrashiTextFormFieldState extends State<TrashiTextFormField> {
  bool isTextHidden = true;

  void _hideText() {
    setState(() {
      isTextHidden = !isTextHidden;
    });
  }

  Widget _buildTextFormField({
    bool isPassword = false,
    IconButton suffixIcon,
  }) {
    TextFormField textFormField = TextFormField(
      obscureText: isPassword ? isTextHidden : false,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: widget.label,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        suffixIcon: (isPassword && suffixIcon != null) ? suffixIcon : null,
      ),
      validator: widget.validator,
    );

    return textFormField;
  }

  IconButton _buildPasswordIconButton() {
    return IconButton(
      color: hexToColor('#CBCBCB'),
      icon: Icon(
        Icons.remove_red_eye_outlined,
        size: 18,
      ),
      onPressed: () => _hideText(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPasswordField) {
      return _buildTextFormField(
        isPassword: true,
        suffixIcon: _buildPasswordIconButton(),
      );
    }
    return _buildTextFormField();
  }
}
