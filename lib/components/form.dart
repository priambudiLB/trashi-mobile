import 'package:flutter/material.dart';

class TrashiTextFormField {
  final TextInputType keyboardType;
  final String label;
  final TextEditingController controller;
  final Function(String) validator;

  TrashiTextFormField({
    this.keyboardType,
    this.label,
    this.controller,
    this.validator,
  });

  Widget buildTextFormField() {
    TextFormField textFormField = TextFormField(
      controller: controller,
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
}
