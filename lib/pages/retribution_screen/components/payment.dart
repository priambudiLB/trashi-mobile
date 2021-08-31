import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/form.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/components/snack_bar.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/constants/time.dart';
import 'package:trashi/pages/profile_screen_redesign/provider.dart';
import 'package:trashi/pages/retribution_screen/components/filter_button.dart';
import 'package:trashi/pages/retribution_screen/components/table_body.dart';
import 'package:trashi/pages/retribution_screen/components/table_header.dart';
import 'package:trashi/pages/retribution_screen/provider/provider.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/simple_button.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({
    Key key,
  }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isFirstTimeOpened = true;
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<RetributionProvider>().emptyToBeApprovedValues();
    context.read<RetributionProvider>().roleType =
        context.read<ProfileScreenProvider>().roleType;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<RetributionProvider>().isFetching = true;
      await context.read<RetributionProvider>().getRetribusiListByRole();
      context.read<RetributionProvider>().isFetching = false;

      setState(() {
        isFirstTimeOpened = false;
      });
    });
  }

  Widget _buildSelectedText() {
    int selectedRumahCount =
        context.watch<RetributionProvider>().toBeApprovedValues.keys.length;

    return Row(
      children: [
        Image.asset(
          "assets/images/Icon_success.png",
          width: 20,
        ),
        Spacings.horizontalSpace(5),
        Text('$selectedRumahCount Rumah selected')
      ],
    );
  }

  Widget _buildApprovalSection() {
    return context.watch<RetributionProvider>().toBeApprovedValues.keys.length >
            0
        ? Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: hexToColor('#FAFAFA'),
                  width: 4,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSelectedText(),
                SimpleTextButton(
                  label: 'Approve',
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildPopUpPassword();
                      },
                    );
                  },
                  textColor: Colors.white,
                  backgroundColor: hexToColor(MAIN_COLOR),
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  Future<void> _approveRetribusi() async {
    showTrashiProgressIndicator(context);

    await context.read<RetributionProvider>().approveRetribusiList();

    closeTrashiProgressIndicator(context);

    if (context.read<RetributionProvider>().isErrorOnApproval) {
      ScaffoldMessenger.of(context).showSnackBar(
        buildErrorSnackBar(
            message:
                context.watch<RetributionProvider>().approvalResultMessage),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildPopUpSuccessConfirmation();
        },
      );
    }
  }

  Widget _buildPopUpPassword() {
    final totalTarif =
        context.read<RetributionProvider>().getTarifToBeApproved();

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Container(
            width: double.infinity,
            height: 320,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Container(
                  height: 40,
                ),
                Material(
                  color: Colors.white,
                  child: Text(
                    "Masukkan Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: hexToColor("#4D4D4D")),
                  ),
                ),
                Spacings.verticalSpace(20),
                Material(
                  color: Colors.white,
                  child: Text(
                    'Silakan masukkan password untuk menyetujui pembayaran dengan jumlah Rp$totalTarif',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: hexToColor("#909090")),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacings.verticalSpace(20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    child: TrashiTextFormField(
                      controller: _passwordController,
                      label: "Password",
                      keyboardType: TextInputType.text,
                      isPasswordField: true,
                    ),
                  ),
                ),
                Spacings.verticalSpace(20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    child: Button(
                      onTap: () async {
                        bool success = await context
                            .read<RetributionProvider>()
                            .signInWithoutUpdateSessionByPhone(
                              _passwordController.text,
                            );

                        _passwordController.text = '';

                        if (!success &&
                            context
                                    .read<RetributionProvider>()
                                    .errorApproveMessage !=
                                '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            buildErrorSnackBar(
                              message: context
                                  .read<RetributionProvider>()
                                  .errorApproveMessage,
                            ),
                          );

                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop();
                          _approveRetribusi();
                        }
                      },
                      title: "Approve",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopUpSuccessConfirmation() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Container(
            width: double.infinity,
            height: 320,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Container(
                  height: 40,
                ),
                Image.asset("assets/images/Icon_success.png"),
                Container(
                  height: 20,
                ),
                Material(
                  color: Colors.white,
                  child: Text(
                    "Success",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: hexToColor("#4D4D4D")),
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: Text(
                    "Anda berhasil menyetujui pembayaran. Nota pembayaran otomatis dikirim ke akun masyarakat.",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: hexToColor("#909090")),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    child: Button(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      title: "Done",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<RetributionProvider>().isFetching || isFirstTimeOpened
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Payments',
                          style: TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w500,
                            color: hexToColor('#464646'),
                            fontSize: 16,
                          ),
                        ),
                        Container(height: 4),
                        Text(
                          getCurrentMonthYear(),
                          style: TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            color: hexToColor('#464646'),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Filter()
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 10),
                  decoration: BoxDecoration(
                      // color: hexToColor('#304860'),
                      border:
                          Border.all(width: 1, color: hexToColor('#F2F2F2')),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              TableHeader(
                                text: 'Nama',
                                flex: 4,
                              ),
                              TableHeader(
                                text: 'Tarif',
                                flex: 4,
                              ),
                              TableHeader(
                                text: 'Alamat Rumah',
                                flex: 6,
                              ),
                              if (context
                                  .read<RetributionProvider>()
                                  .shouldShowPenanggungJawabColumn())
                                TableHeader(
                                  text: 'Penanggung Jawab',
                                  flex: 4,
                                ),
                              TableHeader(
                                text: 'Status',
                                flex: 4,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: context
                              .watch<RetributionProvider>()
                              .getRetribusiListResponse
                              .list
                              .map(
                                (item) => TableBody(
                                  getRetribusiListItemResponse: item,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 4, bottom: 8),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Flexible(
                //         flex: 2,
                //         fit: FlexFit.tight,
                //         child: GestureDetector(
                //           onTap: () {},
                //           child: Container(
                //               width: 1000,
                //               height: 32,
                //               decoration: BoxDecoration(
                //                   // color: hexToColor('#304860'),
                //                   border: Border.all(
                //                       width: 1, color: hexToColor('#CBCBCB')),
                //                   borderRadius:
                //                       BorderRadius.all(Radius.circular(8))),
                //               child: Center(
                //                 child: Text(
                //                   "Prev",
                //                   style: TextStyle(
                //                     fontFamily: "Avenir",
                //                     fontWeight: FontWeight.w400,
                //                     color: hexToColor('#C4C4C4'),
                //                     fontSize: 12,
                //                   ),
                //                 ),
                //               )),
                //         ),
                //       ),
                //       Container(
                //         width: 16,
                //       ),
                //       Flexible(
                //         flex: 2,
                //         fit: FlexFit.tight,
                //         child: GestureDetector(
                //           onTap: () {},
                //           child: Container(
                //               width: 1000,
                //               height: 32,
                //               decoration: BoxDecoration(
                //                   // color: hexToColor('#304860'),
                //                   border: Border.all(
                //                       width: 1, color: hexToColor('#CBCBCB')),
                //                   borderRadius:
                //                       BorderRadius.all(Radius.circular(8))),
                //               child: Center(
                //                   child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Text(
                //                     "Page 1",
                //                     style: TextStyle(
                //                       fontFamily: "Avenir",
                //                       fontWeight: FontWeight.w400,
                //                       color: hexToColor('#464646'),
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                   SvgPicture.asset(
                //                       'assets/images/ic-chevron.svg'),
                //                 ],
                //               ))),
                //         ),
                //       ),
                //       Container(
                //         width: 16,
                //       ),
                //       Flexible(
                //         flex: 2,
                //         fit: FlexFit.tight,
                //         child: GestureDetector(
                //           onTap: () {},
                //           child: Container(
                //               width: 1000,
                //               height: 32,
                //               decoration: BoxDecoration(
                //                   // color: hexToColor('#304860'),
                //                   border: Border.all(
                //                       width: 1, color: hexToColor('#CBCBCB')),
                //                   borderRadius:
                //                       BorderRadius.all(Radius.circular(8))),
                //               child: Center(
                //                 child: Text(
                //                   "Next",
                //                   style: TextStyle(
                //                     fontFamily: "Avenir",
                //                     fontWeight: FontWeight.w400,
                //                     color: hexToColor('#464646'),
                //                     fontSize: 12,
                //                   ),
                //                 ),
                //               )),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                _buildApprovalSection(),
                Spacings.verticalSpace(20),
              ],
            ),
          );
  }
}
