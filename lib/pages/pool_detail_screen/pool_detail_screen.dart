import 'package:flutter/material.dart';
import 'package:trashi/components/layout.dart';
import 'package:trashi/pages/pool_detail_screen/components/pool_detail_card_container.dart';
import 'package:trashi/utils/text.dart';

class PoolDetailScreen extends StatefulWidget {
  static const String PATH = "pool_detail";

  final int poolNumber;
  final String region;

  const PoolDetailScreen({Key key, this.poolNumber, this.region})
      : super(key: key);

  @override
  _PoolDetailScreenState createState() => _PoolDetailScreenState();
}

class _PoolDetailScreenState extends State<PoolDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: buildTitleText(_buildPoolTitleString(), colorInHex: "#FFFFFF"),
      subtitle: buildSubtitleText(_buildPoolSubtitleString()),
      body: ListView(
        children: [
          PoolDetailCardContainer(),
        ],
      ),
    );
  }

  String _buildPoolTitleString() {
    if (widget.poolNumber == null || widget.region == null) {
      return "";
    }

    int poolNumber = widget.poolNumber;
    return "Pool $poolNumber";
  }

  String _buildPoolSubtitleString() {
    if (widget.region == null) {
      return "";
    }

    return widget.region;
  }
}
