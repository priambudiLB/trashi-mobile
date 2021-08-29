enum RetributionStatus { sudahBayar, belumBayar, semuaPembayaran }

extension RetributionStatusExtension on RetributionStatus {
  String get text {
    switch (this) {
      case RetributionStatus.sudahBayar:
        return 'Sudah Bayar';
      case RetributionStatus.belumBayar:
        return 'Belum Bayar';
      case RetributionStatus.semuaPembayaran:
        return 'Semua Pembayaran';
    }

    return '';
  }

  bool get asIsApproved {
    switch (this) {
      case RetributionStatus.sudahBayar:
        return true;
      case RetributionStatus.belumBayar:
        return false;
      case RetributionStatus.semuaPembayaran:
        return null;
    }

    return false;
  }
}

RetributionStatus getRetributionStatusByText(String value) {
  switch (value) {
    case 'Sudah Bayar':
      return RetributionStatus.sudahBayar;
    case 'Belum Bayar':
      return RetributionStatus.belumBayar;
    case 'Semua Pembayaran':
      return RetributionStatus.semuaPembayaran;
  }

  return null;
}

const retributionStatusNotApproved = 0;
const retributionStatusApproved = 1;
const retributionStatusOverdue = 2;
