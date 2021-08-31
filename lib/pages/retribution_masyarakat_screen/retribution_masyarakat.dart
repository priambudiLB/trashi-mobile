import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:formz/formz.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/payment/payment_web_view_screen.dart';
import 'package:trashi/pages/retribution_masyarakat_screen/components/payment.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';
import 'package:trashi/pages/retribution_masyarakat_screen/provider.dart';

class RetributionMasyarakat extends StatelessWidget {
  static const String PATH = "retribution_masyarakat";
  const RetributionMasyarakat({Key key}) : super(key: key);
  _buildSearchField(String label) {
    TextFormField textFormField = TextFormField(
      cursorColor: hexToColor('#909090'),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 15),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(
            Icons.search,
            color: hexToColor('#909090'),
          ), // icon is 48px widget.
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: hexToColor("#909090"), width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );

    return Column(
      children: [
        Container(
          height: 48,
          child: textFormField,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<RetributionMasyarakatProvider>().statusFetchData ==
            FormzStatus.submissionSuccess &&
        context
                .watch<RetributionMasyarakatProvider>()
                .pembayaranRetribusiResponse !=
            null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context
            .read<RetributionMasyarakatProvider>()
            .setCreateStatus(FormzStatus.pure);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWebViewScreen(
              url: context
                  .read<RetributionMasyarakatProvider>()
                  .pembayaranRetribusiResponse
                  .invoiceURL,
            ),
          ),
        );
      });
    }
    return Layout(
      height: 40,
      title: Text(
        "Pembayaran Retribusi",
        // textAlign: TextAlign.end,
        style: TextStyle(
            fontFamily: "Avenir",
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20),
      ),
      body: context.watch<RetributionMasyarakatProvider>().statusFetchData ==
              FormzStatus.submissionInProgress
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Container(
                    // child: _buildSearchField('Search'),
                    // margin: EdgeInsets.only(top: 16),
                    ),
                Payment(),
              ],
            ),
    );
  }
}
