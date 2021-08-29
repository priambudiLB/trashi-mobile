// import 'package:flutter/material.dart';
// import 'package:trashi/components/retribution_payment_status.dart';
// import 'package:trashi/components/square_pagination_number.dart';
// import 'package:trashi/pages/retribution_screen/components/table_body.dart';
// import 'package:trashi/pages/retribution_screen/components/table_header.dart';
// import 'package:trashi/utils/commons.dart';

// class PastPayment extends StatelessWidget {
//   const PastPayment({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> pastPaymentData = [];

//     pastPaymentData.add({
//       'idTransaksi': 'RBS 00306',
//       'approvedDate': '21 Des 2020',
//       'alamatRumah': 'Jl.Cipinang Elok 1 no 5',
//       'status': 1
//     });
//     pastPaymentData.add({
//       'idTransaksi': 'RBS 00307',
//       'approvedDate': '22 Des 2020',
//       'alamatRumah': 'Jl.Cipinang Elok 1 no 8',
//       'status': 0
//     });
//     pastPaymentData.add({
//       'idTransaksi': 'RBS 00308',
//       'approvedDate': '22 Des 2020',
//       'alamatRumah': 'Jl.Cipinang Elok 1 no 8',
//       'status': 0
//     });
//     pastPaymentData.add({
//       'idTransaksi': 'RBS 00309',
//       'approvedDate': '22 Des 2020',
//       'alamatRumah': 'Jl.Cipinang Elok 1 no 8',
//       'status': 1
//     });
//     pastPaymentData.add({
//       'idTransaksi': 'RBS 00310',
//       'approvedDate': '22 Des 2020',
//       'alamatRumah': 'Jl.Cipinang Elok 1 no 8',
//       'status': 1
//     });
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Past Payment',
//                 style: TextStyle(
//                   fontFamily: "Poppins",
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 6, bottom: 10),
//             decoration: BoxDecoration(
//               color: hexToColor('#304860'),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(8),
//                 topRight: Radius.circular(8)
//               )
//             ),
//             width: double.infinity,
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 vertical: 4,
//               ),
//               child: Row(
//                 children: [
//                   TableHeader(
//                     text: 'ID\nTransaksi',
//                     flex: 4,
//                   ),
//                   TableHeader(
//                     text: 'Approval Date',
//                     flex: 4,
//                   ),
//                   TableHeader(
//                     text: 'Alamat Rumah',
//                     flex: 6,
//                   ),
//                   TableHeader(
//                     text: 'Status',
//                     flex: 4,
//                   ),
//                 ],
//               ),
//             )
//           ),
//           Column(
//             children: pastPaymentData.map(
//               (item) => TableBody(
//                 index: pastPaymentData.indexOf(item),
//                 items: [
//                   Text(
//                     item['idTransaksi'],
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                       fontSize: 12,
//                     ),
//                   ),
//                   Text(
//                     item['approvedDate'],
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                       fontSize: 12,
//                     ),
//                   ),
//                   Text(
//                     item['alamatRumah'],
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                       fontSize: 12,
//                     ),
//                   ),
//                   RetributionPaymentStatus(
//                     statusCode: item['status'],
//                   )
//                 ],
//               )
//             ).toList()
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 4, bottom: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SquarePaginationNumber(
//                   onTap: (){},
//                   number: "1",
//                   backgroundColor: hexToColor('#DFDFDF'),
//                 ),
//                 SquarePaginationNumber(
//                   onTap: (){},
//                   number: "2",
//                   backgroundColor: hexToColor('#FFFFFF'),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
