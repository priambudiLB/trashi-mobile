import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/models/trashi_document.dart';
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

// NEW SCHEME
class SubmitDocumentProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  set isFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

  File _fileKTP;
  File _fileKK;
  File _filePhotoWithKTPAndKK;
  File _fileOfficialDocument;
  File _filePhotoWithOfficialDocument;
  File _fileBusinessPermission;
  File _filePhotoWithBusinessPermission;

  File get fileKTP => _fileKTP;
  File get fileKK => _fileKK;
  File get filePhotoWithKTPAndKK => _filePhotoWithKTPAndKK;
  File get fileOfficialDocument => _fileOfficialDocument;
  File get filePhotoWithOfficialDocument => _filePhotoWithOfficialDocument;
  File get fileBusinessPermission => _fileBusinessPermission;
  File get filePhotoWithBusinessPermission => _filePhotoWithBusinessPermission;

  set fileKTP(File file) {
    _fileKTP = file;
    notifyListeners();
  }

  set fileKK(File file) {
    _fileKK = file;
    notifyListeners();
  }

  set filePhotoWithKTPAndKK(File file) {
    _filePhotoWithKTPAndKK = file;
    notifyListeners();
  }

  set fileOfficialDocument(File file) {
    _fileOfficialDocument = file;
    notifyListeners();
  }

  set filePhotoWithOfficialDocument(File file) {
    _filePhotoWithOfficialDocument = file;
    notifyListeners();
  }

  set fileBusinessPermission(File file) {
    _fileBusinessPermission = file;
    notifyListeners();
  }

  set filePhotoWithBusinessPermission(File file) {
    _filePhotoWithBusinessPermission = file;
    notifyListeners();
  }

  // to upload files

  List<TrashiVerificationDocument> _filesToBeUploaded = [];
  List<TrashiVerificationDocument> get filesToBeUploaded => _filesToBeUploaded;

  void addFilesToBeUploaded(TrashiVerificationDocument document) {
    _filesToBeUploaded.add(document);
    notifyListeners();
  }

  List<String> _fileLabelsToBeUploaded;
  List<String> get fileLabelsToBeUploaded => _fileLabelsToBeUploaded;

  void emptyAllRegistrationDocumentFiles() {
    _filesToBeUploaded = [];
  }

  CurrentUserResponse _currentUserResponse;
  CurrentUserResponse get currentUserResponse => _currentUserResponse;

  set currentUserResponse(CurrentUserResponse value) {
    _currentUserResponse = value;
    notifyListeners();
  }

  getFileLabelsToBeUploadedByUser() async {
    final response = await ApiProvider().getCurrentUser();

    if (response == null) {
      return;
    }

    _currentUserResponse = response;
    _fileLabelsToBeUploaded = response.currentUser.label;

    notifyListeners();
  }

  Future<void> uploadVerificationDocuments() async {
    _filesToBeUploaded.forEach((element) async {
      await ApiProvider().uploadVerificationDocument(element);
    });
  }
}
