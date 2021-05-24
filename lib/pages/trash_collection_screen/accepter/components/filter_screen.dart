import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/drop_down_filter.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/utils/commons.dart';

class FilterScreen extends StatelessWidget {
  Widget _buildProvinceDropdown() {
    return DropdownFilter(
      initValue: "DKI Jakarta",
      list: [
        "DKI Jakarta",
        "Jawa Barat",
      ],
    );
  }

  Widget _buildKabupatenDropdown() {
    return DropdownFilter(
      initValue: "Jakarta Pusat",
      list: [
        "Jakarta Pusat",
        "Jakarta Selatan",
        "Jakarta Timur",
        "Jakarta Utara",
        "Jakarta Barat",
      ],
    );
  }

  Widget _buildKecamatanDropdown() {
    return DropdownFilter(
      initValue: "Mampang Prapatan",
      list: [
        "Mampang Prapatan",
        "Tebet",
      ],
    );
  }

  Widget _buildUPSTDropdown() {
    return DropdownFilter(
      initValue: "UPST 1",
      list: [
        "UPST 1",
        "UPST 2",
      ],
    );
  }

  Widget _buildFilterLabelText(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: hexToColor("#4D4D4D"),
        ),
      ),
    );
  }

  Widget _buildApplyFilterButton() {
    return RowButtonWrapper(
      backgroundColor: hexToColor("#32A37F"),
      foregroundColor: Colors.white,
      height: 48,
      circularBorderRadius: 8,
      borderColor: hexToColor("#32A37F"),
      padding: EdgeInsets.fromLTRB(126, 15, 126, 15),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Terapkan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      onPressed: () {
        print("apply filter");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: Text(
        "Filter",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFilterLabelText("Provinsi"),
          _buildProvinceDropdown(),
          Spacings.verticalSpace(16),
          _buildFilterLabelText("Kabupaten"),
          _buildKabupatenDropdown(),
          Spacings.verticalSpace(16),
          _buildFilterLabelText("Kecamatan"),
          _buildKecamatanDropdown(),
          Spacings.verticalSpace(16),
          _buildFilterLabelText("UPST"),
          _buildUPSTDropdown(),
          Spacings.verticalSpace(24),
          _buildApplyFilterButton(),
        ],
      ),
    );
  }
}
