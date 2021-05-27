import 'package:flutter/material.dart';
import 'package:trashi/utils/commons.dart';

class Layout extends StatefulWidget {
  final Text title;
  final Text subtitle;
  final double height;
  final Widget body;

  const Layout(
      {Key key,
      this.title,
      this.subtitle = const Text(''),
      this.height = 80,
      this.body})
      : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Pembayaran Retribusi",
            // textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: "Avenir",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 20
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop()),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: widget.body,
        ));
  }
}
