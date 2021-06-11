import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/trash_collections.dart';
import 'package:trashi/pages/request_screen/history/models/collection_history_model.dart';
import 'package:trashi/pages/request_screen/history/request_detail_screen.dart';
import 'package:trashi/utils/commons.dart';

class CollectionHistoryCard extends StatefulWidget {
  final CollectionHistoryModel collectionHistoryModel;

  const CollectionHistoryCard({
    Key key,
    this.collectionHistoryModel,
  }) : super(key: key);

  @override
  _CollectionHistoryCardState createState() => _CollectionHistoryCardState();
}

class _CollectionHistoryCardState extends State<CollectionHistoryCard> {
  Color _getPaymentStatusColor() {
    switch (widget.collectionHistoryModel.paymentStatus) {
      case paymentStatusPaid:
        return hexToColor("#32A37F");
      case paymentStatusNotPaid:
        return hexToColor("#ED7D31");
      default:
        return hexToColor("#909090");
    }
  }

  Color _getRequestStatusColor() {
    switch (widget.collectionHistoryModel.requestStatus) {
      case requestStatusFinished:
        return hexToColor("#909090");
      case requestStatusWaiting:
        return hexToColor("#32A37F");
      default:
        return hexToColor("#32A37F");
    }
  }

  Widget _buildStatusAndTimeOfCollectionSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.collectionHistoryModel.requestStatus,
          style: TextStyle(
            color: _getRequestStatusColor(),
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
            widget.collectionHistoryModel.requestTime,
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
                widget.collectionHistoryModel.trashType,
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
                widget.collectionHistoryModel.pickUpDeliveryType,
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
                widget.collectionHistoryModel.paymentDetail,
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
                collectionHistoryModel: widget.collectionHistoryModel,
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
                        text: widget.collectionHistoryModel.paymentStatus,
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
