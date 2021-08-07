import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/request_screen/history/components/collection_history_card.dart';
import 'package:trashi/pages/request_screen/provider.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class CollectionHistoryScreen extends StatefulWidget {
  static const String PATH = "collection_history_screen";

  @override
  _CollectionHistoryScreenState createState() =>
      _CollectionHistoryScreenState();
}

class _CollectionHistoryScreenState extends State<CollectionHistoryScreen> {
  bool isFirstTimeOpened = true;

  Widget _buildCollectionHistoryCards() {
    return ListView(
      children: context
          .watch<CollectionHistoryProvider>()
          .pengangkatanList
          .map(
            (element) => CollectionHistoryCard(
              pengangkatan: element,
            ),
          )
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CollectionHistoryProvider>().isFetching = true;
      await context.read<CollectionHistoryProvider>().getHistoriPengangkatan();
      context.read<CollectionHistoryProvider>().isFetching = false;

      setState(() {
        isFirstTimeOpened = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<CollectionHistoryProvider>().isFetching ||
            isFirstTimeOpened
        ? Layout(
            body: CircularProgressIndicator(),
          )
        : Layout(
            title: Text(
              "Histori Pengangkatan",
              style: TextStyle(
                color: hexToColor("#4C4C4C"),
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            body: _buildCollectionHistoryCards(),
          );
  }
}
