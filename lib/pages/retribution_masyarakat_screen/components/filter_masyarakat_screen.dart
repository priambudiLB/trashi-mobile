import 'package:flutter/material.dart';
import 'package:trashi/components/dropdown_selection.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/http_request/models/kabupaten.dart';
import 'package:trashi/http_request/models/kecamatan.dart';
import 'package:trashi/http_request/models/upst.dart';
import 'package:trashi/pages/profile_screen_redesign/provider.dart';
import 'package:trashi/pages/profile_screen_redesign/role_type.dart';
import 'package:trashi/pages/registration_screen/components/account_type_checkbox.dart';
import 'package:trashi/pages/retribution_masyarakat_screen/provider.dart';
import 'package:trashi/pages/retribution_screen/provider/provider.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/utils/checkbox_configs.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';
import 'package:trashi/http_request/models/retribusi.dart';
import 'package:trashi/constants/retribution_status.dart';
import 'package:trashi/constants/time.dart';

class FilterMasyarakatScreen extends StatefulWidget {
  static const String PATH = "retributionFilterAdmin";

  @override
  _FilterMasyarakatScreen createState() => _FilterMasyarakatScreen();
}

class _FilterMasyarakatScreen extends State<FilterMasyarakatScreen> {
  Widget _buildYearDropdown() {
    return DropdownSelection<String>(
      items: [
        '2019',
        '2020',
        '2021',
        '2022',
        '2023',
        '2024',
        '2025',
        '2026',
        '2027',
        '2028',
        '2029',
        '2030'
      ],
      getLabel: (String value) {
        return value;
      },
      onChanged: (String value) {
        context.read<RetributionMasyarakatProvider>().yearFilter = value;
      },
    );
  }

  Widget _buildMonthDropdown() {
    return DropdownSelection<String>(
      items: [
        '01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10',
        '11',
        '12'
      ],
      getLabel: (String value) {
        return getMonthTextFromString(value);
      },
      onChanged: (String value) {
        context.read<RetributionMasyarakatProvider>().monthFilter = value;
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
        String yearMonthFilter;
        if (context.read<RetributionMasyarakatProvider>().yearFilter != null ||
            context.read<RetributionMasyarakatProvider>().monthFilter != null) {
          yearMonthFilter =
              context.read<RetributionMasyarakatProvider>().yearFilter +
                  context.read<RetributionMasyarakatProvider>().monthFilter;
        }

        context.read<RetributionMasyarakatProvider>().getRetribusiListFilterV2 =
            GetRetribusiListFilterV2(
          status: context.read<RetributionMasyarakatProvider>().status?.asInt,
          yearMonth: yearMonthFilter,
        );

        showTrashiProgressIndicator(context);

        await context.read<RetributionMasyarakatProvider>().getList(
              filter: context
                  .read<RetributionMasyarakatProvider>()
                  .getRetribusiListFilterV2,
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
    context.read<RetributionMasyarakatProvider>().status =
        getRetributionStatusByText(
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

  Widget _buildFilterRTRW() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Bulan'),
            ),
            Spacings.horizontalSpace(10),
            Expanded(
              child: Text('Tahun'),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildMonthDropdown(),
            ),
            Spacings.horizontalSpace(10),
            Expanded(
              child: _buildYearDropdown(),
            ),
          ],
        ),
        Spacings.verticalSpace(24),
        _buildFilterLabelText("Status"),
        Column(
          children: getAccountTypeCheckboxes(),
        ),
        Spacings.verticalSpace(24),
        _buildApplyFilterButton(),
        Spacings.verticalSpace(24),
      ],
    );
  }

  Widget _buildFilterContent() {
    return _buildFilterRTRW();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<RetributionMasyarakatProvider>().resetAllFilters();
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
      body: ListView(
        children: [_buildFilterContent()],
      ),
    );
  }
}
