import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

class AccountTypeSelectionScreen extends StatefulWidget {
  static const String PATH = "accountTypeSelection";

  @override
  _AccountTypeSelectionScreenState createState() =>
      _AccountTypeSelectionScreenState();
}

class _AccountTypeSelectionScreenState
    extends State<AccountTypeSelectionScreen> {
  static const String accountTypeGovernment = "Pemerintah";
  static const String accountTypeCompany = "Perusahaan";
  static const String accountTypeRTRW = "RT/RW";
  static const String accountTypePublic = "Masyarakat Umum";

  String currentlyChecked = "";

  final choices = [
    CheckboxConfig(text: accountTypeGovernment),
    CheckboxConfig(text: accountTypeCompany),
    CheckboxConfig(text: accountTypeRTRW),
    CheckboxConfig(text: accountTypePublic),
  ];

  _choose(CheckboxConfig config) {
    setState(() {
      if (currentlyChecked.length == 0) {
        _changeValue(config);
        currentlyChecked = config.text;
      } else if (currentlyChecked == config.text) {
        _changeValue(config);
        currentlyChecked = "";
      }
    });
  }

  _changeValue(CheckboxConfig config) {
    bool newValue = !config.value;
    config.value = newValue;
    choices.forEach((element) {
      if (element.text != config.text && element.value != newValue) {
        element.value = !newValue;
      }
    });
  }

  List<CheckboxListTile> getAccountTypeCheckboxes() {
    List<CheckboxListTile> checkboxes = [];
    for (var item in choices) {
      checkboxes.add(
        CheckboxListTile(
          title: Text(item.text),
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

class CheckboxConfig {
  String text;
  bool value;

  CheckboxConfig({
    this.text,
    this.value = false,
  });
}
