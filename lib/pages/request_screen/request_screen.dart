import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/routes.dart';
import 'package:trashi/pages/request_screen/provider.dart';
import 'package:trashi/utils/commons.dart';
import 'package:trashi/pages/form_request_pengangkatan/location_picker_form.dart';

import 'package:provider/provider.dart';
import 'history/collection_history_screen.dart';

class RequestScreen extends StatefulWidget {
  static const String PATH = "request_screen";

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CollectionHistoryProvider>().isFetching = true;
      await context.read<CollectionHistoryProvider>().getHistoriPengangkatan();
      context.read<CollectionHistoryProvider>().isFetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: Text(""),
      body: new RefreshIndicator(
        onRefresh: () async {
          context.read<CollectionHistoryProvider>().isFetching = true;
          await context
              .read<CollectionHistoryProvider>()
              .getHistoriPengangkatan();
          context.read<CollectionHistoryProvider>().isFetching = false;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.read<CollectionHistoryProvider>().isFetching
                  ? SkeletonAnimation(
                      child: Container(
                      height: 40,
                      width: double.infinity,
                      color: Color.fromRGBO(114, 120, 151, 0.1),
                    ))
                  : InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (!context
                                .read<CollectionHistoryProvider>()
                                .isFetching &&
                            !context
                                .read<CollectionHistoryProvider>()
                                .hasInvalidPayment)
                          Navigator.push(context,
                                  SlideLeftRoute(page: LocationPickerForm()))
                              .then((value) async {
                            context
                                .read<CollectionHistoryProvider>()
                                .isFetching = true;
                            await context
                                .read<CollectionHistoryProvider>()
                                .getHistoriPengangkatan();
                            context
                                .read<CollectionHistoryProvider>()
                                .isFetching = false;
                          });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Request Pengangkatan",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: context
                                              .watch<
                                                  CollectionHistoryProvider>()
                                              .hasInvalidPayment
                                          ? Color.fromRGBO(114, 120, 151, 0.3)
                                          : hexToColor("#464646"),
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  height: 8,
                                ),
                                Text(
                                  "Request pengangkatan sampah",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: context
                                              .watch<
                                                  CollectionHistoryProvider>()
                                              .hasInvalidPayment
                                          ? Color.fromRGBO(114, 120, 151, 0.2)
                                          : hexToColor("#909090")),
                                )
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_outlined,
                            size: 40,
                            color: context
                                    .watch<CollectionHistoryProvider>()
                                    .hasInvalidPayment
                                ? Color.fromRGBO(114, 120, 151, 0.3)
                                : hexToColor("#4C4C4C"),
                          )
                        ],
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 16),
                height: 1,
                width: double.infinity,
                color: hexToColor("#DFDFDF"),
              ),
              context.read<CollectionHistoryProvider>().isFetching
                  ? SkeletonAnimation(
                      child: Container(
                      height: 40,
                      width: double.infinity,
                      color: Color.fromRGBO(114, 120, 151, 0.1),
                    ))
                  : InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          SlideLeftRoute(
                            page: CollectionHistoryScreen(),
                          ),
                        ).then((value) async {
                          context.read<CollectionHistoryProvider>().isFetching =
                              true;
                          await context
                              .read<CollectionHistoryProvider>()
                              .getHistoriPengangkatan();
                          context.read<CollectionHistoryProvider>().isFetching =
                              false;
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Histori Pengangkatan",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: hexToColor("#464646"),
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  height: 8,
                                ),
                                Text(
                                  "Lihat histori pengangkatan sampah",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: hexToColor("#909090")),
                                )
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_outlined,
                            size: 40,
                            color: hexToColor("#4C4C4C"),
                          )
                        ],
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 16),
                height: 1,
                width: double.infinity,
                color: hexToColor("#DFDFDF"),
              ),
              !context.watch<CollectionHistoryProvider>().isFetching &&
                      context
                          .read<CollectionHistoryProvider>()
                          .hasInvalidPayment
                  ? Text(
                      "Silakan lunasi pembayaran untuk request pengangkatan sampah yang baru.",
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: hexToColor("#FF9059")),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
