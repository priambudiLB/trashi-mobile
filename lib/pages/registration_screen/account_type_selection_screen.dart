import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/constants/account_types.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/registration_screen/registration_screen.dart';
import 'package:trashi/utils/checkbox_configs.dart';
import 'package:trashi/utils/commons.dart';

import 'components/account_type_checkbox.dart';

class AccountTypeSelectionScreen extends StatefulWidget {
  static const String PATH = "accountTypeSelection";

  @override
  _AccountTypeSelectionScreenState createState() =>
      _AccountTypeSelectionScreenState();
}

class _AccountTypeSelectionScreenState
    extends State<AccountTypeSelectionScreen> {
  String currentlyChecked = "";

  final choices = [
    AccountTypeCheckboxConfig(
      accountType: AccountType.government,
    ),
    AccountTypeCheckboxConfig(
      accountType: AccountType.company,
    ),
    AccountTypeCheckboxConfig(
      accountType: AccountType.RTRW,
    ),
    AccountTypeCheckboxConfig(
      accountType: AccountType.public,
    ),
  ];

  _choose(AccountTypeCheckboxConfig config) {
    setState(() {
      if (currentlyChecked.length == 0) {
        _changeValue(config);
        currentlyChecked = config.accountType.text;
      } else if (currentlyChecked == config.accountType.text) {
        _changeValue(config);
        currentlyChecked = "";
      }
    });
  }

  _openRegistrationForm(AccountTypeCheckboxConfig config) {
    Future.delayed(
      Duration(milliseconds: 500),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegistrationScreen(
              accountType: config.accountType,
            ),
          ),
        );
      },
    );
  }

  _changeValue(AccountTypeCheckboxConfig config) {
    bool newValue = !config.value;
    config.value = newValue;
    choices.forEach((element) {
      if (element.accountType.text != config.accountType.text &&
          element.value != newValue) {
        element.value = !newValue;
      }
    });

    if (newValue) {
      _openRegistrationForm(config);
    }
  }

  // CURRENTLY NOT BEING USED. KEEPING IT JUST IN CASE
  List<CheckboxListTile> getCheckboxes() {
    List<CheckboxListTile> checkboxes = [];
    for (var item in choices) {
      checkboxes.add(
        CheckboxListTile(
          title: Text(item.accountType.text),
          value: item.value,
          onChanged: (bool value) {
            _choose(item);
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.all(0),
          checkColor: hexToColor(MAIN_COLOR),
          activeColor: Colors.white,
        ),
      );
    }
    return checkboxes;
  }

  List<AccountTypeCheckbox> getAccountTypeCheckboxes() {
    List<AccountTypeCheckbox> checkboxes = [];
    for (var item in choices) {
      checkboxes.add(
        AccountTypeCheckbox(
          label: item.accountType.text,
          checkBox: Checkbox(
            value: item.value,
            onChanged: (bool value) {
              _choose(item);
            },
            checkColor: hexToColor(MAIN_COLOR),
            activeColor: Colors.white,
          ),
        ),
      );
    }
    return checkboxes;
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pilih Tipe Akun",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24),
          ),
          Container(
            child: Column(
              children: getAccountTypeCheckboxes(),
            ),
          ),
        ],
      ),
    );
  }
}
