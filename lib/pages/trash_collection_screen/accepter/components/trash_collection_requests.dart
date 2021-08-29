import 'package:flutter/material.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/provider/provider.dart';
import 'package:trashi/utils/commons.dart';

import 'trash_collection_request_card.dart';
import 'package:provider/provider.dart';

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

  Widget _buildNowRequestCards() {
    return ListView(
      children: context
          .watch<AcceptTrashCollectionRequestScreenProvider>()
          .pengangkatanListAdminResponse
          .isNow
          .map(
            (element) => TrashCollectionRequestCard(
              pengangkatan: element,
            ),
          )
          .toList(),
    );
  }

  Widget _buildNotNowRequestCards() {
    return ListView(
      children: context
          .watch<AcceptTrashCollectionRequestScreenProvider>()
          .pengangkatanListAdminResponse
          .notIsNow
          .map(
            (element) => TrashCollectionRequestCard(
              pengangkatan: element,
            ),
          )
          .toList(),
    );
  }

  Widget _buildDoneRequestCards() {
    return ListView(
      children: context
          .watch<AcceptTrashCollectionRequestScreenProvider>()
          .pengangkatanListAdminResponse
          .done
          .map(
            (element) => TrashCollectionRequestCard(
              pengangkatan: element,
            ),
          )
          .toList(),
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
                _buildNowRequestCards(),
                _buildNotNowRequestCards(),
                _buildDoneRequestCards(),
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
