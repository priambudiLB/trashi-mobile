import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/constants/document_type.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class DocumentUploadButton extends StatefulWidget {
  final DocumentType documentType;

  const DocumentUploadButton({
    Key key,
    this.documentType,
  }) : super(key: key);

  @override
  _DocumentUploadButtonState createState() => _DocumentUploadButtonState();
}

class _DocumentUploadButtonState extends State<DocumentUploadButton> {
  bool isUploaded = false;

  void _saveDocumentToLocal(File file) {
    final _provider = context.read<SubmitDocumentOnRegistration>();

    switch (widget.documentType) {
      case DocumentType.KTP:
        _provider.fileKTP = file;
        return;
      case DocumentType.KK:
        _provider.fileKK = file;
        return;
      case DocumentType.photoWithKTPAndKK:
        _provider.filePhotoWithKTPAndKK = file;
        return;
      case DocumentType.officialDocument:
        _provider.fileOfficialDocument = file;
        return;
      case DocumentType.photoWithOfficialDocument:
        _provider.filePhotoWithOfficialDocument = file;
        return;
      case DocumentType.businessPermission:
        _provider.fileBusinessPermission = file;
        return;
      case DocumentType.photoWithBusinessPermission:
        _provider.filePhotoWithBusinessPermission = file;
        return;
    }
  }

  void _onTapUploadFromCamera() async {
    final pickedFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      _saveDocumentToLocal(pickedFile);

      setState(() {
        isUploaded = true;
      });

      Navigator.of(context).pop();
    }
  }

  void _onTapUploadFromGallery() async {
    final pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _saveDocumentToLocal(pickedFile);

      setState(() {
        isUploaded = true;
      });

      Navigator.of(context).pop();
    }
  }

  void _showPickImageSource() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Pilih sumber foto'),
        actions: <Widget>[
          TextButton(
            onPressed: () => _onTapUploadFromCamera(),
            child: const Text('Kamera'),
          ),
          TextButton(
            onPressed: () => _onTapUploadFromGallery(),
            child: const Text('Galeri'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 48,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: hexToColor(MAIN_COLOR),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          color: isUploaded ? Colors.white.withOpacity(0.7) : Colors.white,
          onPressed: () => _showPickImageSource(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isUploaded
                    ? "Berhasil diupload"
                    : widget.documentType.buttonLabel,
                style: TextStyle(
                  color: hexToColor(MAIN_COLOR),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              if (isUploaded)
                Icon(
                  Icons.check_circle_outline,
                  size: 12,
                  color: hexToColor(MAIN_COLOR),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
