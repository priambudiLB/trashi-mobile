import 'package:flutter/material.dart';
import 'package:trashi/components/spacings.dart';

class TrashiProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          Spacings.verticalSpace(20),
          Text(
            'Mohon menunggu',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

void showTrashiProgressIndicator(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TrashiProgressIndicator();
    },
  );
}

void closeTrashiProgressIndicator(BuildContext context) {
  Navigator.of(context).pop();
}
