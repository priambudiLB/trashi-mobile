const String accountTypeGovernment = "Pemerintah";
const String accountTypeCompany = "Perusahaan";
const String accountTypeRTRW = "RT/RW";
const String accountTypePublic = "Masyarakat Umum";

enum AccountType {
  government,
  company,
  RTRW,
  public,
}

extension AccountTypeExtension on AccountType {
  static const accountTypeText = {
    AccountType.government: 'Pemerintah',
    AccountType.company: 'Perusahaan',
    AccountType.RTRW: 'RT/RW',
    AccountType.public: 'Masyarakat Umum',
  };

  static const accountTypeRoleInt = {
    AccountType.government: 2,
    AccountType.company: 3,
    AccountType.RTRW: 5,
    AccountType.public: 4,
  };

  String get verificationMethod {
    switch (this) {
      case AccountType.government:
      case AccountType.company:
        return 'email';
      case AccountType.RTRW:
      case AccountType.public:
        return 'sms';
      default:
        return '';
    }
  }

  String get text => accountTypeText[this];

  int get roleInt => accountTypeRoleInt[this];

  bool get shouldInputPhoneNumberToRegister =>
      this == AccountType.RTRW || this == AccountType.public;
}
