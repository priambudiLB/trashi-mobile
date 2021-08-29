import 'dart:io';

import 'package:trashi/constants/document_type.dart';

class TrashiDocument {
  final File file;
  final DocumentType type;

  TrashiDocument({this.file, this.type});
}

class TrashiVerificationDocument {
  final File file;
  final String label;

  TrashiVerificationDocument({
    this.file,
    this.label,
  });
}
