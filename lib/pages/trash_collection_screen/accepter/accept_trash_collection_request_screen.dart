import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';

class AcceptTrashCollectionRequestScreen extends StatefulWidget {
  static const String PATH = "acceptTrashCollecting";

  @override
  _AcceptTrashCollectionRequestScreenState createState() =>
      _AcceptTrashCollectionRequestScreenState();
}

class _AcceptTrashCollectionRequestScreenState
    extends State<AcceptTrashCollectionRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: Text("Request Pengambilan"),
    );
  }
}
