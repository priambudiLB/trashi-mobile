import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/models/trashi_document.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/provider.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class DocumentOnVerificationButtonRedesigned extends StatefulWidget {
  final String label;

  const DocumentOnVerificationButtonRedesigned({
    Key key,
    this.label,
  }) : super(key: key);

  @override
  _DocumentOnVerificationButtonRedesignedState createState() =>
      _DocumentOnVerificationButtonRedesignedState();
}

class _DocumentOnVerificationButtonRedesignedState
    extends State<DocumentOnVerificationButtonRedesigned> {
  bool isUploaded = false;

  void _saveDocumentToLocal(File file) {
    final _provider = context.read<SubmitDocumentProvider>();

    final _document =
        TrashiVerificationDocument(file: file, label: widget.label);

    _provider.addFilesToBeUploaded(_document);
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
                    : 'Upload foto ' + widget.label,
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
