import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/constants/pengangkatan.dart';
import 'package:trashi/http_request/models/pengangkatan.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/trash_collection_request_detail_screen.dart';
import 'package:trashi/utils/commons.dart';

class TrashCollectionRequestCard extends StatefulWidget {
  final Pengangkatan pengangkatan;

  const TrashCollectionRequestCard({
    Key key,
    this.pengangkatan,
  }) : super(key: key);

  @override
  _TrashCollectionRequestCardState createState() =>
      _TrashCollectionRequestCardState();
}

class _TrashCollectionRequestCardState
    extends State<TrashCollectionRequestCard> {
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

  Widget _buildStatusAndTimeOfCollectionSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        statusSection,
        timeOfCollectionSection,
      ],
    );
  }

  Widget _buildRequesterIdentitySection() {
    ImageProvider image;

    image = Image.asset('assets/images/profile-active.png').image;

    final userfirstname = widget.pengangkatan.userfirstname ?? '';
    final userlastname = widget.pengangkatan.userlastname ?? '';

    String userFullName = '$userfirstname $userlastname';

    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 8,
          ),
        ),
        Text(
          userFullName,
          style: TextStyle(
            color: hexToColor("#4D4D4D"),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRequestDataSection() {
    return Row(
      children: [
        Container(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/trash-kind.svg',
                width: 12,
                height: 14,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                ),
              ),
              Text(
                widget.pengangkatan.jenisBarang ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: hexToColor("#909090"),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 25,
          ),
        ),
        Container(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/truck-1.svg',
                width: 12,
                height: 14,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                ),
              ),
              Text(
                widget.pengangkatan.jenisKendaraan ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: hexToColor("#909090"),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildShowDetailButton() {
    return RowButtonWrapper(
      padding: EdgeInsets.fromLTRB(105, 11, 105, 11),
      circularBorderRadius: 8,
      borderColor: hexToColor("#32A37F"),
      backgroundColor: Colors.white,
      height: 40,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lihat Detail",
            style: TextStyle(
              color: hexToColor("#32A37F"),
              fontSize: 14,
            ),
          ),
        ],
      ),
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrashCollectionRequestDetailScreen(
              id: widget.pengangkatan.id,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 12,
      ),
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
            children: [
              _buildStatusAndTimeOfCollectionSection(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 15,
                ),
              ),
              _buildRequesterIdentitySection(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 17,
                ),
              ),
              _buildRequestDataSection(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 17,
                ),
              ),
              Text(
                widget.pengangkatan.lokasi ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: hexToColor("#909090")),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 12,
                ),
              ),
              _buildShowDetailButton(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
