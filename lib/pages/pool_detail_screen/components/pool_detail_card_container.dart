import 'package:flutter/material.dart';
import 'package:trashi/pages/pool_detail_screen/components/pool_detail_card.dart';

class PoolDetailCardContainer extends StatefulWidget {
  final double spaceBetweenCards = 16;

  final List<Map<String, String>> poolDetailCards = [
    {
      "owner": "Hartanto",
      "address": "Jl. Y. Ujung No. 61 cipinang muara",
      "neighbourhood": "005",
      "hamlet": "003",
      "urbanVillage": "Jatinegara",
      "imageURL":
          "https://asset.kompas.com/crops/QEmJ7W5wYyLakYfqlgfIIBUyJrM=/0x0:0x0/780x390/data/photo/2019/07/09/3469889163.jpg",
    },
    {
      "owner": "Hartanto",
      "address": "Jl. Y. Ujung No. 61 cipinang muara",
      "neighbourhood": "005",
      "hamlet": "003",
      "urbanVillage": "Jatinegara",
      "imageURL":
          "https://asset.kompas.com/crops/QEmJ7W5wYyLakYfqlgfIIBUyJrM=/0x0:0x0/780x390/data/photo/2019/07/09/3469889163.jpg",
    },
    {
      "owner": "Hartanto",
      "address": "Jl. Y. Ujung No. 61 cipinang muara",
      "neighbourhood": "005",
      "hamlet": "003",
      "urbanVillage": "Jatinegara",
      "imageURL":
          "https://asset.kompas.com/crops/QEmJ7W5wYyLakYfqlgfIIBUyJrM=/0x0:0x0/780x390/data/photo/2019/07/09/3469889163.jpg",
    },
    {
      "owner": "Hartanto",
      "address": "Jl. Y. Ujung No. 61 cipinang muara",
      "neighbourhood": "005",
      "hamlet": "003",
      "urbanVillage": "Jatinegara",
      "imageURL":
          "https://asset.kompas.com/crops/QEmJ7W5wYyLakYfqlgfIIBUyJrM=/0x0:0x0/780x390/data/photo/2019/07/09/3469889163.jpg",
    },
    {
      "owner": "Hartanto",
      "address": "Jl. Y. Ujung No. 61 cipinang muara",
      "neighbourhood": "005",
      "hamlet": "003",
      "urbanVillage": "Jatinegara",
      "imageURL":
          "https://asset.kompas.com/crops/QEmJ7W5wYyLakYfqlgfIIBUyJrM=/0x0:0x0/780x390/data/photo/2019/07/09/3469889163.jpg",
    },
    {
      "owner": "Hartanto",
      "address": "Jl. Y. Ujung No. 61 cipinang muara",
      "neighbourhood": "005",
      "hamlet": "003",
      "urbanVillage": "Jatinegara",
      "imageURL":
          "https://asset.kompas.com/crops/QEmJ7W5wYyLakYfqlgfIIBUyJrM=/0x0:0x0/780x390/data/photo/2019/07/09/3469889163.jpg",
    },
    {
      "owner": "Hartanto",
      "address": "Jl. Y. Ujung No. 61 cipinang muara",
      "neighbourhood": "005",
      "hamlet": "003",
      "urbanVillage": "Jatinegara",
      "imageURL":
          "https://asset.kompas.com/crops/QEmJ7W5wYyLakYfqlgfIIBUyJrM=/0x0:0x0/780x390/data/photo/2019/07/09/3469889163.jpg",
    },
  ];

  @override
  _PoolDetailCardState createState() => _PoolDetailCardState();
}

class _PoolDetailCardState extends State<PoolDetailCardContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(runSpacing: widget.spaceBetweenCards, children: <Widget>[
        for (var poolDetailCard in widget.poolDetailCards)
          PoolDetailCard(
            owner: poolDetailCard["owner"],
            address: poolDetailCard["address"],
            neighbourhood: poolDetailCard["neighbourhood"],
            hamlet: poolDetailCard["hamlet"],
            urbanVillage: poolDetailCard["urbanVillage"],
            imageURL: poolDetailCard["imageURL"],
          )
      ]),
    );
  }
}
