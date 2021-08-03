import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/pengangkatan.dart';
import 'package:trashi/http_request/models/pengangkatan.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/provider/provider.dart';
import 'package:trashi/components/progress_indicator.dart';

class TrashCollectionRequestDetailScreen extends StatefulWidget {
  final int id;

  const TrashCollectionRequestDetailScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _TrashCollectionRequestDetailScreenState createState() =>
      _TrashCollectionRequestDetailScreenState();
}

class _TrashCollectionRequestDetailScreenState
    extends State<TrashCollectionRequestDetailScreen> {
  bool isFirstTimeOpened = true;

  @override
  void initState() {
    // widget.pengangkatan.statusPengangkatan == StatusPengangkatan.selesai;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<TrashCollectionRequestDetailProvider>().isFetching = true;
      await context
          .read<TrashCollectionRequestDetailProvider>()
          .getPengangkatanDetail(widget.id);
      context.read<TrashCollectionRequestDetailProvider>().isFetching = false;

      setState(() {
        isFirstTimeOpened = false;
      });
    });
    super.initState();
  }

  Future<void> _onPressedConfirmationButton() async {
    await context
        .read<TrashCollectionRequestDetailProvider>()
        .finishPengangkatan(widget.id);

    await context
        .read<AcceptTrashCollectionRequestScreenProvider>()
        .getPengangkatanListAdmin();

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
                .watch<TrashCollectionRequestDetailProvider>()
                .pengangkatan
                .jenisBarang),
        _buildDetailItem(
            "Berat",
            context
                .watch<TrashCollectionRequestDetailProvider>()
                .pengangkatan
                .berat),
        _buildDetailItem(
            "Jenis Kendaraan",
            context
                .watch<TrashCollectionRequestDetailProvider>()
                .pengangkatan
                .jenisKendaraan),
        _buildDetailItem(
            "Harga",
            context
                .watch<TrashCollectionRequestDetailProvider>()
                .pengangkatan
                .harga
                .toString()),
        _buildDetailItem(
            "Waktu",
            getAccepterScreenCompleteLocaleDate(context
                .watch<TrashCollectionRequestDetailProvider>()
                .pengangkatan
                .waktuPengangkatan)),
        _buildDetailItem(
            "Lokasi",
            context
                .watch<TrashCollectionRequestDetailProvider>()
                .pengangkatan
                .lokasi),
        _buildDetailItem(
            "Status Pembayaran",
            context
                .watch<TrashCollectionRequestDetailProvider>()
                .pengangkatan
                .statusPembayaran
                .text),
      ],
    );
  }

  Widget _buildOpenGoogleMapsButton() {
    return RowButtonWrapper(
      padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
      circularBorderRadius: 8,
      borderColor: hexToColor("#32A37F"),
      backgroundColor: Colors.white,
      height: 48,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lihat Google Maps",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: hexToColor("#32A37F"),
            ),
          ),
        ],
      ),
      onPressed: () {
        print("open gmaps");
      },
    );
  }

  Widget _buildFinishRequestButton() {
    return RowButtonWrapper(
      padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
      circularBorderRadius: 8,
      borderColor: context
                  .watch<TrashCollectionRequestDetailProvider>()
                  .pengangkatan
                  .statusPengangkatan ==
              StatusPengangkatan.selesai
          ? Colors.white
          : hexToColor("#32A37F"),
      backgroundColor: context
                  .watch<TrashCollectionRequestDetailProvider>()
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
            "Selesai",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: context
                          .watch<TrashCollectionRequestDetailProvider>()
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _buildDialog();
          },
        );
      },
    );
  }

  Widget _buildCancelButton() {
    return RowButtonWrapper(
      padding: EdgeInsets.fromLTRB(46, 11, 46, 11),
      circularBorderRadius: 8,
      borderColor: hexToColor("#32A37F"),
      backgroundColor: Colors.white,
      height: 40,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Batal",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: hexToColor("#32A37F"),
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildConfirmationButton() {
    return RowButtonWrapper(
      padding: EdgeInsets.fromLTRB(46, 11, 46, 11),
      circularBorderRadius: 8,
      borderColor: hexToColor("#32A37F"),
      backgroundColor: hexToColor("#32A37F"),
      height: 40,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Yakin",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
      onPressed: () {
        _onPressedConfirmationButton();
      },
    );
  }

  Widget _buildDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: EdgeInsets.symmetric(
        vertical: 230,
        horizontal: 24,
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 32, 24, 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Apakah Anda yakin sudah selesai mengambil sampah?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: hexToColor("#464646"),
              ),
              textAlign: TextAlign.center,
            ),
            Spacings.verticalSpace(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCancelButton(),
                Spacings.horizontalSpace(16),
                _buildConfirmationButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<TrashCollectionRequestDetailProvider>().isFetching ||
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
                  "Detail Pengambilan",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Spacings.verticalSpace(24),
                _buildDetailItems(),
                Spacings.verticalSpace(8),
                _buildOpenGoogleMapsButton(),
                Spacings.verticalSpace(16),
                _buildFinishRequestButton(),
              ],
            ),
          );
  }
}
