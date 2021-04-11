import 'package:flutter/material.dart';
import 'package:intl/message_format.dart';

class PoolDetailCard extends StatelessWidget {
  final String owner;
  final String address;
  final String neighbourhood;
  final String hamlet;
  final String urbanVillage;
  final String imageURL;

  final String ownerLabelLocale = "Pemilik";
  final String addressLabelLocale = "Alamat";
  final String neighbourhoodLabelLocale = "RT";
  final String hamletLabelLocale = "RW";
  final String urbanVillageLabelLocale = "Kelurahan";
  final double poolDetailCardHeight = 120;
  final double borderRadius = 5;

  const PoolDetailCard(
      {Key key,
      this.owner,
      this.address,
      this.neighbourhood,
      this.hamlet,
      this.urbanVillage,
      this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              children: [
                _buildText(ownerLabelLocale, owner),
                _buildText(addressLabelLocale, address),
                _buildText("$neighbourhoodLabelLocale / $hamletLabelLocale",
                    "$neighbourhood / $hamlet"),
                _buildText(urbanVillageLabelLocale, urbanVillage),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Image.network(
              imageURL,
              fit: BoxFit.fitHeight,
              height: poolDetailCardHeight,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildText(String label, String value) {
    return Row(
      children: [
        Text("$label : ", style: _buildTextStyle()),
        Expanded(child: Text("$value", style: _buildTextStyle())),
      ],
    );
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
  }
}
