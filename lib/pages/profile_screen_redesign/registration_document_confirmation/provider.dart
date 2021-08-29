import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/status_upload.dart';

class SubmitDocumentVerification with ChangeNotifier, DiagnosticableTreeMixin {
  StatusUpload _generalStatus = StatusUpload.NOT_UPLOADED;
  StatusUpload _ktpStatus = StatusUpload.NOT_UPLOADED;
  StatusUpload _kkStatus = StatusUpload.NOT_UPLOADED;
  StatusUpload _ktpAndKkStatus = StatusUpload.NOT_UPLOADED;
  FormzStatus _statusFetchData = FormzStatus.pure;
  File _fileKtp;
  File _fileKk;
  File _fileKtpAndKK;

  StatusUpload get generalStatus => _generalStatus;
  StatusUpload get ktpStatus => _ktpStatus;
  StatusUpload get kkStatus => _kkStatus;
  StatusUpload get ktpAndKkStatus => _ktpAndKkStatus;
  FormzStatus get statusFetchData => _statusFetchData;
  File get fileKtp => _fileKtp;
  File get fileKk => _fileKk;
  File get fileKtpAndKK => _fileKtpAndKK;

  void setStatusFetchData(FormzStatus status) {
    _statusFetchData = status;
    notifyListeners();
  }

  void fetchData() async {
    setStatusFetchData(FormzStatus.submissionInProgress);
    Future.delayed(Duration(seconds: 1), () {
      setGeneralStatus(StatusUpload.NOT_UPLOADED);
      setKtpStatus(StatusUpload.FAILED);
      setKkStatus(StatusUpload.FAILED);
      setKtpAndKkStatus(StatusUpload.FAILED);
      setStatusFetchData(FormzStatus.submissionSuccess);
    });
  }

  void setGeneralStatus(StatusUpload newStatus) {
    _generalStatus = newStatus;
    notifyListeners();
  }

  void setKtpStatus(StatusUpload newStatus) {
    _ktpStatus = newStatus;
    notifyListeners();
  }

  void setKkStatus(StatusUpload newStatus) {
    _kkStatus = newStatus;
    notifyListeners();
  }

  void setKtpAndKkStatus(StatusUpload newStatus) {
    _ktpAndKkStatus = newStatus;
    notifyListeners();
  }

  void setKtpFile(File file) {
    _fileKtp = file;
    notifyListeners();
  }

  void setKkFile(File file) {
    _fileKk = file;
    notifyListeners();
  }

  void setKtpAndKkFile(File file) {
    _fileKtpAndKK = file;
    notifyListeners();
  }
}
