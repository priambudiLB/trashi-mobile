import 'package:trashi/constants/account_types.dart';

class CheckboxConfig {
  String text;
  bool value;

  CheckboxConfig({
    this.text,
    this.value = false,
  });
}

class AccountTypeCheckboxConfig {
  bool value;
  AccountType accountType;

  AccountTypeCheckboxConfig({
    this.value = false,
    this.accountType,
  });
}
