import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/pengangkatan.dart';
import 'package:trashi/pages/request_screen/provider.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class RequestDetailScreen extends StatefulWidget {
  final int id;

  const RequestDetailScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _RequestDetailScreen createState() => _RequestDetailScreen();
}

class _RequestDetailScreen extends State<RequestDetailScreen> {
  bool isFirstTimeOpened = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CollectionHistoryProvider>().isFetching = true;
      await context
          .read<CollectionHistoryProvider>()
          .getPengangkatanDetail(widget.id);
      context.read<CollectionHistoryProvider>().isFetching = false;

      setState(() {
        isFirstTimeOpened = false;
      });
    });
  }

  Future<void> _onPressedConfirmationButton() async {
    await context.read<CollectionHistoryProvider>().getHistoriPengangkatan();

    Navigator.of(context).pop();
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: hexToColor("#909090"),
            ),
          ),
          Spacings.verticalSpace(8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem(
            "Jenis Barang",
            context
                .watch<CollectionHistoryProvider>()
                .pengangkatan
                .jenisBarang),
        _buildDetailItem("Berat",
            context.watch<CollectionHistoryProvider>().pengangkatan.berat),
        _buildDetailItem(
            "Jenis Kendaraan",
            context
                .watch<CollectionHistoryProvider>()
                .pengangkatan
                .jenisKendaraan),
        _buildDetailItem(
            "Harga",
            context
                .watch<CollectionHistoryProvider>()
                .pengangkatan
                .harga
                .toString()),
        _buildDetailItem(
            "Waktu",
            getAccepterScreenCompleteLocaleDate(context
                .watch<CollectionHistoryProvider>()
                .pengangkatan
                .waktuPengangkatan)),
        _buildDetailItem("Lokasi",
            context.watch<CollectionHistoryProvider>().pengangkatan.lokasi),
        _buildDetailItem(
            "Status Pembayaran",
            context
                .watch<CollectionHistoryProvider>()
                .pengangkatan
                .statusPembayaran
                .text),
      ],
    );
  }

  Widget _buildLunasiPembayaranButton() {
    return RowButtonWrapper(
      padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
      circularBorderRadius: 8,
      borderColor: context
                  .watch<CollectionHistoryProvider>()
                  .pengangkatan
                  .statusPengangkatan ==
              StatusPengangkatan.selesai
          ? Colors.white
          : hexToColor("#32A37F"),
      backgroundColor: context
                  .watch<CollectionHistoryProvider>()
                  .pengangkatan
                  .statusPengangkatan ==
              StatusPengangkatan.selesai
          ? Colors.white
          : hexToColor("#32A37F"),
      height: 48,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lunasi Pembayaran',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: context
                          .watch<CollectionHistoryProvider>()
                          .pengangkatan
                          .statusPengangkatan ==
                      StatusPengangkatan.selesai
                  ? hexToColor("#909090")
                  : Colors.white,
            ),
          ),
        ],
      ),
      onPressed: () {
        print('pressed');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<CollectionHistoryProvider>().isFetching ||
            isFirstTimeOpened
        ? Layout(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Layout(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detail Pengangkatan",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Spacings.verticalSpace(24),
                _buildDetailItems(),
                Spacings.verticalSpace(16),
                if (context
                        .watch<CollectionHistoryProvider>()
                        .pengangkatan
                        .statusPengangkatan !=
                    StatusPengangkatan.selesai)
                  _buildLunasiPembayaranButton(),
              ],
            ),
          );
  }
}
