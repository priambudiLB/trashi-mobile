import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/request_screen/history/components/collection_history_card.dart';
import 'package:trashi/pages/request_screen/history/models/collection_history_model.dart';

class CollectionHistoryScreen extends StatefulWidget {
  static const String PATH = "collection_history_screen";

  @override
  _CollectionHistoryScreenState createState() =>
      _CollectionHistoryScreenState();
}

class _CollectionHistoryScreenState extends State<CollectionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      body: ListView(
        children: [
          CollectionHistoryCard(
            collectionHistoryModel: CollectionHistoryModel(
              requestStatus: "Menunggu Pengangkatan",
              requestTime: "Sekarang",
              pickUpDeliveryType: "Gerobak - Motor",
              address: "Jiah",
              trashType: "Sampah",
              paymentDetail: "DP 20.000 (Sisa pembayaran: 15.000)",
              paymentStatus: "Belum lunas",
            ),
          ),
        ],
      ),
    );
  }
}
