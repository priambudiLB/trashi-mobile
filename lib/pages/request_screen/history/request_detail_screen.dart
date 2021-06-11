import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/trash_collections.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/utils/commons.dart';

import 'models/collection_history_model.dart';

class RequestDetailScreen extends StatefulWidget {
  final CollectionHistoryModel collectionHistoryModel;

  const RequestDetailScreen({
    Key key,
    this.collectionHistoryModel,
  }) : super(key: key);
  @override
  _RequestDetailScreen createState() => _RequestDetailScreen();
}

class _RequestDetailScreen extends State<RequestDetailScreen> {
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
    String pickUpDeliveryType =
        widget.collectionHistoryModel.pickUpDeliveryType;
    String downPayment = widget.collectionHistoryModel.downPayment;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem(
            "Jenis Barang", widget.collectionHistoryModel.trashType),
        _buildDetailItem(
            "Berat", widget.collectionHistoryModel.trashWeightFormatted),
        _buildDetailItem(
            "Jenis Kendaraan dan DP", "$pickUpDeliveryType (DP $downPayment)"),
        _buildDetailItem(
            "Sisa Pembayaran", widget.collectionHistoryModel.remainingPayment),
        _buildDetailItem("Waktu", widget.collectionHistoryModel.requestTime),
        _buildDetailItem("Lokasi", widget.collectionHistoryModel.address),
        _buildDetailItem(
            "Status Pembayaran", widget.collectionHistoryModel.paymentStatus),
      ],
    );
  }

  Widget _buildPayButton() {
    return RowButtonWrapper(
      padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
      circularBorderRadius: 8,
      borderColor: hexToColor("#32A37F"),
      backgroundColor: hexToColor("#32A37F"),
      height: 48,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lunasi Pembayaran",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
      onPressed: () {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return _buildDialog();
        //   },
        // );
        print("pay");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
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
          Spacings.verticalSpace(24),
          if (widget.collectionHistoryModel.paymentStatus ==
              paymentStatusNotPaid)
            _buildPayButton(),
        ],
      ),
    );
  }
}
