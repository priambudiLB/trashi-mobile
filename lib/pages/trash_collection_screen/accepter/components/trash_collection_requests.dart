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
        TrashCollectionRequestCard(
          requesterName: "Mikey",
          requesterAddress:
              "Jl. M. Nasir No.18, Cilodong, Kec. Cilodong, Kota Depok, Jawa Barat 16415",
          requesterPhotoURL:
              "https://i.pinimg.com/736x/1e/1c/3e/1e1c3e4adbd53afaa0b7f2f999c46887.jpg",
          requestStatus: "Menunggu Pengambilan",
          requestTime: "22 Jan, 15:00",
          trashType: "Batu > 100kg",
          pickUpDeliveryType: "Pickup",
        ),
        TrashCollectionRequestCard(
          requesterName: "Adisti Lailan",
          requesterAddress:
              "Jl. M. Nasir No.18, Cilodong, Kec. Cilodong, Kota Depok, Jawa Barat 16415",
          requestStatus: "Menunggu Pengambilan",
          requestTime: "22 Jan, 15:00",
          trashType: "Batu > 100kg",
          pickUpDeliveryType: "Pickup",
        ),
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
