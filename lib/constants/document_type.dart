enum DocumentType {
  KTP,
  KK,
  photoWithKTPAndKK,
  officialDocument,
  photoWithOfficialDocument,
  businessPermission,
  photoWithBusinessPermission
}

extension DocumentTypeExtension on DocumentType {
  String get label {
    switch (this) {
      case DocumentType.KTP:
        return 'KTP';
      case DocumentType.KK:
        return 'KK';
      case DocumentType.photoWithKTPAndKK:
        return 'Foto bersama KTP dan KK';
      case DocumentType.officialDocument:
        return 'Dokumen resmi';
      case DocumentType.photoWithOfficialDocument:
        return 'Foto bersama dokumen resmi';
      case DocumentType.businessPermission:
        return 'Izin usaha';
      case DocumentType.photoWithBusinessPermission:
        return 'Foto bersama izin usaha';
      default:
        return '';
    }
  }

  String get buttonLabel {
    switch (this) {
      case DocumentType.KTP:
        return 'Upload foto KTP';
      case DocumentType.KK:
        return 'Upload foto KK';
      case DocumentType.photoWithKTPAndKK:
        return 'Upload foto bersama KTP dan KK';
      case DocumentType.officialDocument:
        return 'Upload foto dokumen resmi';
      case DocumentType.photoWithOfficialDocument:
        return 'Upload foto bersama dokumen resmi';
      case DocumentType.businessPermission:
        return 'Upload foto izin usaha';
      case DocumentType.photoWithBusinessPermission:
        return 'Upload foto bersama izin usaha';
      default:
        return '';
    }
  }
}
