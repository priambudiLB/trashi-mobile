import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/utils/commons.dart';

class TrashCollectionRequestCard extends StatefulWidget {
  @override
  _TrashCollectionRequestCardState createState() =>
      _TrashCollectionRequestCardState();
}

class _TrashCollectionRequestCardState
    extends State<TrashCollectionRequestCard> {
  Widget _buildStatusAndTimeOfCollectionSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Menunggu Pengambilan",
          style: TextStyle(
            color: hexToColor("#32A37F"),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        Container(
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
            "Sekarang",
            style: TextStyle(
              color: hexToColor("#FF9059"),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        )
      ],
    );
  }

  Widget _buildRequesterIdentitySection() {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                'https://ak.picdn.net/shutterstock/videos/14582785/thumb/4.jpg',
              ),
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
          "Adisti Lailan",
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
                "Pohon > 50 kg",
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
                "Gerobak - Motor",
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: hexToColor("#32A37F"),
        ),
      ),
      padding: EdgeInsets.fromLTRB(105, 11, 105, 11),
      child: Text(
        "Lihat Detail",
        style: TextStyle(
          color: hexToColor("#32A37F"),
          fontSize: 14,
        ),
      ),
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
                "Jl Amil No 10 A Pejaten Barat, Ps. Minggu, Jakarta Selatan",
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
