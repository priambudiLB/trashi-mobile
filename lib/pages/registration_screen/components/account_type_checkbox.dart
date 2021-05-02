import 'package:flutter/material.dart';

class AccountTypeCheckbox extends StatelessWidget {
  final String label;
  final Checkbox checkBox;

  const AccountTypeCheckbox({
    Key key,
    this.label,
    this.checkBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: SizedBox(
                height: 24.0,
                width: 24.0,
                child: checkBox,
              ),
            ),
            Text(label),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 19),
        ),
      ],
    );
  }
}
