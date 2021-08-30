import 'package:flutter/material.dart';
import 'package:trashi/components/dropdown_selection.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/http_request/models/kabupaten.dart';
import 'package:trashi/http_request/models/kecamatan.dart';
import 'package:trashi/http_request/models/upst.dart';
import 'package:trashi/pages/registration_screen/components/account_type_checkbox.dart';
import 'package:trashi/pages/retribution_screen/provider/provider.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/utils/checkbox_configs.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';
import 'package:trashi/http_request/models/retribusi.dart';
import 'package:trashi/constants/retribution_status.dart';

class FilterAdminScreen extends StatefulWidget {
  static const String PATH = "retributionFilterAdmin";

  @override
  _FilterAdminScreen createState() => _FilterAdminScreen();
}

class _FilterAdminScreen extends State<FilterAdminScreen> {
  Widget _buildProvinceDropdown() {
    return DropdownSelection<String>(
      items: [context.watch<RetributionProvider>().provinsi],
      getLabel: (String value) {
        return value;
      },
      onChanged: (String value) {
        context.read<RetributionProvider>().provinsi = value;
      },
    );
  }

  Widget _buildKabupatenDropdown() {
    return DropdownSelection<Kabupaten>(
      items: context.watch<RetributionProvider>().kabupatens,
      getLabel: (Kabupaten value) {
        return value.name ?? 'Nama tidak tersedia';
      },
      onChanged: (Kabupaten value) async {
        context.read<RetributionProvider>().kabupaten = value;
        showTrashiProgressIndicator(context);
        await context
            .read<RetributionProvider>()
            .getKecamatans(kabupatenID: value.id);
        await context
            .read<RetributionProvider>()
            .getUPSTs(kabupatenID: value.id);
        closeTrashiProgressIndicator(context);
      },
    );
  }

  Widget _buildKecamatanDropdown() {
    return DropdownSelection<Kecamatan>(
      items: context.watch<RetributionProvider>().kecamatans,
      getLabel: (Kecamatan value) {
        return value.name ?? 'Nama tidak tersedia';
      },
      onChanged: (Kecamatan value) async {
        context.read<RetributionProvider>().kecamatan = value;
        showTrashiProgressIndicator(context);
        await context
            .read<RetributionProvider>()
            .getUPSTs(kecamatanID: value.id);
        closeTrashiProgressIndicator(context);
      },
    );
  }

  Widget _buildUPSTDropdown() {
    return DropdownSelection<UPSTHTTPModel>(
      items: context.watch<RetributionProvider>().upsts,
      getLabel: (UPSTHTTPModel value) {
        final name = value.name;
        final kelurahanName = value.kelurahan.name;

        return '$name, Kelurahan $kelurahanName';
      },
      onChanged: (UPSTHTTPModel value) {
        context.read<RetributionProvider>().upst = value;
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
      onPressed: () async {
        context.read<RetributionProvider>().getRetribusiListFilterV2 =
            GetRetribusiListFilterV2(
          kabupatenID: context.read<RetributionProvider>().kabupaten?.id,
          kecamatanID: context.read<RetributionProvider>().kecamatan?.id,
          upstID: context.read<RetributionProvider>().upst?.id,
          status: context.read<RetributionProvider>().status?.asInt,
        );

        showTrashiProgressIndicator(context);

        await context.read<RetributionProvider>().getRetribusiListPemerintah(
              filter:
                  context.read<RetributionProvider>().getRetribusiListFilterV2,
            );

        closeTrashiProgressIndicator(context);

        Navigator.of(context).pop();
      },
    );
  }

  String currentlyChecked = "";

  final choices = [
    CheckboxConfig(text: RetributionStatus.sudahBayar.text),
    CheckboxConfig(text: RetributionStatus.belumBayar.text),
    CheckboxConfig(text: RetributionStatus.semuaPembayaran.text),
  ];

  _choose(CheckboxConfig config) {
    setState(() {
      _changeValue(config);
    });
  }

  _changeValue(CheckboxConfig config) {
    bool currentValue = config.value;

    choices.forEach(
      (element) {
        if (element.text != config.text) {
          element.value = false;
        }
      },
    );

    config.value = !currentValue;
    context.read<RetributionProvider>().status = getRetributionStatusByText(
      config.text,
    );
  }

  List<AccountTypeCheckbox> getAccountTypeCheckboxes() {
    List<AccountTypeCheckbox> checkboxes = [];
    for (var item in choices) {
      checkboxes.add(
        AccountTypeCheckbox(
          label: item.text,
          checkBox: Checkbox(
            value: item.value,
            onChanged: (bool value) {
              _choose(item);
            },
            checkColor: hexToColor(MAIN_COLOR),
            activeColor: Colors.white,
          ),
        ),
      );
    }
    return checkboxes;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<RetributionProvider>().resetAllFilters();
      showTrashiProgressIndicator(context);
      await context.read<RetributionProvider>().getKabupatens();
      await context.read<RetributionProvider>().getKecamatans();
      await context.read<RetributionProvider>().getUPSTs();
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
          _buildFilterLabelText("Status"),
          Column(
            children: getAccountTypeCheckboxes(),
          ),
          Spacings.verticalSpace(24),
          _buildApplyFilterButton(),
        ],
      ),
    );
  }
}
