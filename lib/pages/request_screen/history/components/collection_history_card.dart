import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/pengangkatan.dart';
import 'package:trashi/http_request/models/pengangkatan.dart';
import 'package:trashi/pages/request_screen/history/request_detail_screen.dart';
import 'package:trashi/utils/commons.dart';

class CollectionHistoryCard extends StatefulWidget {
  final Pengangkatan pengangkatan;

  const CollectionHistoryCard({
    Key key,
    this.pengangkatan,
  }) : super(key: key);

  @override
  _CollectionHistoryCardState createState() => _CollectionHistoryCardState();
}

class _CollectionHistoryCardState extends State<CollectionHistoryCard> {
  Widget get statusSection {
    if (widget.pengangkatan.statusPengangkatan == StatusPengangkatan.selesai &&
        widget.pengangkatan.statusPembayaran == StatusPembayaran.lunas) {
      return Text(
        'Selesai',
        style: TextStyle(
          color: hexToColor("#909090"),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    if (widget.pengangkatan.statusPengangkatan ==
        StatusPengangkatan.menungguPengambilan) {
      return Text(
        widget.pengangkatan.statusPengangkatan.text,
        style: TextStyle(
          color: hexToColor("#32A37F"),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    if (widget.pengangkatan.statusPengangkatan == StatusPengangkatan.selesai &&
        widget.pengangkatan.statusPembayaran == StatusPembayaran.belumLunas) {
      return Text(
        'Menunggu Sisa Pembayaran',
        style: TextStyle(
          color: hexToColor("#FF9059"),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return SizedBox.shrink();
  }

  Widget get timeOfCollectionSection {
    String timeOfCollection;

    if (widget.pengangkatan.isNow) {
      timeOfCollection = 'Sekarang';
    } else if (widget.pengangkatan.statusPengangkatan ==
            StatusPengangkatan.selesai &&
        widget.pengangkatan.statusPembayaran == StatusPembayaran.lunas) {
      return SizedBox.shrink();
    } else {
      timeOfCollection =
          getAccepterScreenLocaleDate(widget.pengangkatan.waktuPengangkatan);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.all(
          color: hexToColor("#FF9059"),
        ),
        color: Color.fromRGBO(255, 144, 89, 0.1),
      ),
      child: Text(
        timeOfCollection,
        style: TextStyle(
          color: hexToColor("#FF9059"),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
    );
  }

  Color _getPaymentStatusColor() {
    switch (widget.pengangkatan.statusPembayaran) {
      case StatusPembayaran.lunas:
        return hexToColor("#32A37F");
      case StatusPembayaran.belumBayar:
        return hexToColor("#ED7D31");
      default:
        return hexToColor("#909090");
    }
  }

  Color _getRequestStatusColor() {
    switch (widget.pengangkatan.statusPengangkatan) {
      case StatusPengangkatan.selesai:
        return hexToColor("#909090");
      case StatusPengangkatan.menungguPengambilan:
        return hexToColor("#32A37F");
      default:
        return hexToColor("#32A37F");
    }
  }

  Widget _buildStatusAndTimeOfCollectionSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        statusSection,
        timeOfCollectionSection,
      ],
    );
  }

  Widget _buildRequestDataSection() {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/trash-kind.svg',
                width: 12,
                height: 14,
              ),
              Spacings.horizontalSpace(8),
              Text(
                widget.pengangkatan.jenisBarang,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: hexToColor("#909090"),
                ),
              )
            ],
          ),
        ),
        Spacings.verticalSpace(12),
        Container(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/truck-1.svg',
                width: 12,
                height: 14,
              ),
              Spacings.horizontalSpace(8),
              Text(
                widget.pengangkatan.jenisKendaraan,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: hexToColor("#909090"),
                ),
              )
            ],
          ),
        ),
        Spacings.verticalSpace(12),
        Container(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/money.svg',
                width: 15,
                height: 11,
              ),
              Spacings.horizontalSpace(8),
              Text(
                widget.pengangkatan.harga.toString(), // unfinished
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: hexToColor("#909090"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 12,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RequestDetailScreen(
                id: widget.pengangkatan.id,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              color: hexToColor("#F2F2F2"),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusAndTimeOfCollectionSection(),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                _buildRequestDataSection(),
                Spacings.verticalSpace(16),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: hexToColor("#909090"),
                      fontFamily: "Avenir",
                    ),
                    children: [
                      TextSpan(text: "Status Pembayaran: "),
                      TextSpan(
                        text: widget.pengangkatan.statusPembayaran.text,
                        style: TextStyle(
                          color: _getPaymentStatusColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
