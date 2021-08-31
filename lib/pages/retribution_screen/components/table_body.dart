import 'package:flutter/material.dart';
import 'package:trashi/constants/retribution_status.dart';
import 'package:trashi/http_request/models/retribusi.dart';
import 'package:trashi/pages/profile_screen_redesign/role_type.dart';
import 'package:trashi/pages/retribution_screen/components/status.dart';
import 'package:trashi/pages/retribution_screen/components/table_body_text.dart';
import 'package:trashi/pages/retribution_screen/provider/provider.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class TableBody extends StatefulWidget {
  final GetRetribusiListItemResponse getRetribusiListItemResponse;

  const TableBody({
    Key key,
    this.getRetribusiListItemResponse,
  }) : super(key: key);
  @override
  _TableBody createState() => _TableBody();
}

class _TableBody extends State<TableBody> {
  Text _buildTextContent(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Avenir",
        fontWeight: FontWeight.w500,
        color: hexToColor('#4D4D4D'),
        fontSize: 12,
      ),
    );
  }

  Widget _buildStatus() {
    RoleType roleType = context.read<RetributionProvider>().roleType;

    switch (roleType) {
      case RoleType.ADMIN:
      case RoleType.PEMERINTAH:
        return _buildStatusAdmin();
      case RoleType.RTRW:
        return _buildStatusRTRW();
    }
  }

  Status _buildStatusRTRW() {
    int isApprovedCount = 0;

    widget.getRetribusiListItemResponse.all.forEach((element) {
      if (element.status == retributionStatusApproved) {
        isApprovedCount++;
      }
    });

    final isApproved =
        isApprovedCount == widget.getRetribusiListItemResponse.all.length;

    if (isApproved) {
      return Status(
        status: 0,
        getRetribusiListItemResponse: widget.getRetribusiListItemResponse,
      );
    }

    return Status(
      status: 2,
      getRetribusiListItemResponse: widget.getRetribusiListItemResponse,
    );
  }

  Status _buildStatusAdmin() {
    int isApprovedCount = 0;

    widget.getRetribusiListItemResponse.all.forEach((element) {
      if (element.status == retributionStatusApproved) {
        isApprovedCount++;
      }
    });

    final isApproved =
        isApprovedCount == widget.getRetribusiListItemResponse.all.length;

    if (isApproved) {
      return Status(
        status: 0,
        getRetribusiListItemResponse: widget.getRetribusiListItemResponse,
      );
    }

    return Status(
      status: 3,
      getRetribusiListItemResponse: widget.getRetribusiListItemResponse,
    );
  }

  bool _shouldShowPenanggungJawab() {
    RoleType roleType = context.read<RetributionProvider>().roleType;

    switch (roleType) {
      case RoleType.ADMIN:
      case RoleType.PEMERINTAH:
        return true;
      case RoleType.RTRW:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
          width: 1,
          color: hexToColor('#F2F2F2'),
        )),
        // color: widget.index % 2 == 0 ? hexToColor('#DFDFDF') : hexToColor('#FFFFFF'),
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Row(
          // children: widget.items,
          children: [
            TableBodyContent(
              content: _buildTextContent(
                  widget.getRetribusiListItemResponse.now.rumah.fullName),
              flex: 4,
            ),
            TableBodyContent(
              content: _buildTextContent(
                widget.getRetribusiListItemResponse.now.rumah.tarifRetribusi
                    .toString(),
              ),
              flex: 4,
            ),
            TableBodyContent(
              content: _buildTextContent(
                  widget.getRetribusiListItemResponse.now.rumah.alamat),
              flex: 6,
            ),
            if (context
                .read<RetributionProvider>()
                .shouldShowPenanggungJawabColumn())
              TableBodyContent(
                content: _buildTextContent('RT002/RW001'),
                flex: 4,
              ),
            TableBodyContent(
              content: _buildStatus(),
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
