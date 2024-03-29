import 'package:flutter/material.dart';
import 'package:trashi/components/dropdown_selection.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/http_request/models/kabupaten.dart';
import 'package:trashi/http_request/models/kecamatan.dart';
import 'package:trashi/http_request/models/upst.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/provider/provider.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget _buildProvinceDropdown() {
    return DropdownSelection<String>(
      items: [
        context.watch<AcceptTrashCollectionRequestScreenProvider>().provinsi
      ],
      getLabel: (String value) {
        return value;
      },
      onChanged: (String value) {
        context.read<AcceptTrashCollectionRequestScreenProvider>().provinsi =
            value;
      },
    );
  }

  Widget _buildKabupatenDropdown() {
    return DropdownSelection<Kabupaten>(
      items: context
          .watch<AcceptTrashCollectionRequestScreenProvider>()
          .kabupatens,
      getLabel: (Kabupaten value) {
        return value.name ?? 'Nama tidak tersedia';
      },
      onChanged: (Kabupaten value) async {
        context.read<AcceptTrashCollectionRequestScreenProvider>().kabupaten =
            value;
        showTrashiProgressIndicator(context);
        await context
            .read<AcceptTrashCollectionRequestScreenProvider>()
            .getKecamatans(kabupatenID: value.id);
        await context
            .read<AcceptTrashCollectionRequestScreenProvider>()
            .getUPSTs(kabupatenID: value.id);
        closeTrashiProgressIndicator(context);
      },
    );
  }

  Widget _buildKecamatanDropdown() {
    return DropdownSelection<Kecamatan>(
      items: context
          .watch<AcceptTrashCollectionRequestScreenProvider>()
          .kecamatans,
      getLabel: (Kecamatan value) {
        return value.name ?? 'Nama tidak tersedia';
      },
      onChanged: (Kecamatan value) async {
        context.read<AcceptTrashCollectionRequestScreenProvider>().kecamatan =
            value;
        showTrashiProgressIndicator(context);
        await context
            .read<AcceptTrashCollectionRequestScreenProvider>()
            .getUPSTs(kecamatanID: value.id);
        closeTrashiProgressIndicator(context);
      },
    );
  }

  Widget _buildUPSTDropdown() {
    return DropdownSelection<UPSTHTTPModel>(
      items: context.watch<AcceptTrashCollectionRequestScreenProvider>().upsts,
      getLabel: (UPSTHTTPModel value) {
        final name = value.name;
        final kelurahanName = value.kelurahan.name;

        return '$name, Kelurahan $kelurahanName';
      },
      onChanged: (UPSTHTTPModel value) {
        context.read<AcceptTrashCollectionRequestScreenProvider>().upst = value;
      },
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showTrashiProgressIndicator(context);
      await context
          .read<AcceptTrashCollectionRequestScreenProvider>()
          .getKabupatens();
      await context
          .read<AcceptTrashCollectionRequestScreenProvider>()
          .getKecamatans();
      await context
          .read<AcceptTrashCollectionRequestScreenProvider>()
          .getUPSTs();
      closeTrashiProgressIndicator(context);
    });
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
