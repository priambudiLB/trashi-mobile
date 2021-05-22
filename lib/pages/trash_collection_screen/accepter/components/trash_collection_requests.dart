import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

import 'trash_collection_request_card.dart';

class TrashCollectionRequests extends StatefulWidget {
  @override
  _TrashCollectionRequestsState createState() =>
      _TrashCollectionRequestsState();
}

class _TrashCollectionRequestsState extends State<TrashCollectionRequests>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget _buildRequestCards() {
    return ListView(
      children: [
        TrashCollectionRequestCard(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: hexToColor(MAIN_COLOR),
                  width: 2,
                ),
              ),
            ),
            unselectedLabelColor: hexToColor("#909090"),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'Sekarang',
              ),
              Tab(
                text: 'Terjadwal',
              ),
              Tab(
                text: 'Selesai',
              )
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 16,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildRequestCards(),
                _buildRequestCards(),
                _buildRequestCards(),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}

// creds to: https://stackoverflow.com/questions/50609252/flutter-tabbar-without-appbar/50610509
