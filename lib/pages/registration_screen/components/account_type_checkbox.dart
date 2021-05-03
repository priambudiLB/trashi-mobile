import 'package:flutter/material.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

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
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: checkBox.value
                        ? hexToColor(MAIN_COLOR)
                        : hexToColor(COLOR_CHECKBOX_INACTIVE),
                  ),
                ),
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: checkBox,
                ),
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
