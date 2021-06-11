import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/constants/trash_collections.dart';
import 'package:trashi/pages/request_screen/history/components/collection_history_card.dart';
import 'package:trashi/pages/request_screen/history/models/collection_history_model.dart';

class CollectionHistoryScreen extends StatefulWidget {
  static const String PATH = "collection_history_screen";

  @override
  _CollectionHistoryScreenState createState() =>
      _CollectionHistoryScreenState();
}

class _CollectionHistoryScreenState extends State<CollectionHistoryScreen> {
  List<CollectionHistoryCard> _buildCollectionHistoryCards() {
    return <CollectionHistoryCard>[
      CollectionHistoryCard(
        collectionHistoryModel: CollectionHistoryModel(
          requestStatus: requestStatusWaiting,
          requestTime: "Sekarang",
          pickUpDeliveryType: "Gerobak - Motor",
          address: "Jl. Alamat",
          trashType: "Batu",
          paymentDetail: "DP 20.000 (Sisa pembayaran: 15.000)",
          paymentStatus: paymentStatusNotPaid,
        ),
      ),
      CollectionHistoryCard(
        collectionHistoryModel: CollectionHistoryModel(
          requestStatus: requestStatusWaiting,
          requestTime: "Sekarang",
          pickUpDeliveryType: "Gerobak - Motor",
          address: "Jl. Alamat",
          trashType: "Batu",
          paymentDetail: "DP 20.000 (Sisa pembayaran: 15.000)",
          paymentStatus: paymentStatusNotPaid,
        ),
      ),
      CollectionHistoryCard(
        collectionHistoryModel: CollectionHistoryModel(
          requestStatus: requestStatusFinished,
          requestTime: "Sekarang",
          pickUpDeliveryType: "Pick Up",
          address: "Jl. Alamat",
          trashType: "Batu",
          paymentDetail: "30.000",
          paymentStatus: paymentStatusPaid,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: ListView(
        children: _buildCollectionHistoryCards(),
      ),
    );
  }
}
