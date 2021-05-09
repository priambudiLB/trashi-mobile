import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

class DocumentUploadButton extends StatefulWidget {
  final String labelText;

  const DocumentUploadButton({
    Key key,
    this.labelText,
  }) : super(key: key);

  @override
  _DocumentUploadButtonState createState() => _DocumentUploadButtonState();
}

class _DocumentUploadButtonState extends State<DocumentUploadButton> {
  bool isUploaded = false;

  void _onTapUploadDocument() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        isUploaded = true;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: hexToColor(MAIN_COLOR),
        ),
      ),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 48,
        child: MaterialButton(
          color: isUploaded ? Color.fromRGBO(50, 163, 127, 0.05) : Colors.white,
          onPressed: () => _onTapUploadDocument(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isUploaded ? "Berhasil diupload" : widget.labelText,
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
