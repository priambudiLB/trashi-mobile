import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

class Layout extends StatefulWidget {
  final Text title;
  final Text subtitle;
  final double height;
  final Widget body;

  const Layout({
    Key key,
    this.title,
    this.subtitle = const Text(''),
    this.height = 80,
    this.body
  }) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(widget.height),
        child: SafeArea(
          child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    widget.title,
                    widget.subtitle
                  ],
                )
              ),
            ),
            leading: IconButton(
              icon: SvgPicture.asset('assets/images/ic-back.svg', width: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        )
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: widget.body,
      )
    );
  }
}