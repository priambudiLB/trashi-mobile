import 'package:flutter/cupertino.dart';
import 'package:trashi/pages/home_screen/components/news_card.dart';

class NewsCardContainer extends StatefulWidget {
  final double spaceBetweenCards = 16;
  final List<Map<String, String>> newsCards = [
    {
      "title":
          "vel eros donec ac odio tempor orci dapibus ultrices in iaculis nunc sed augue lacus",
      "source": "national geographic",
      "imageURL":
          "https://1.bp.blogspot.com/-fwGiMC_sLO8/Xyi9BZnn_LI/AAAAAAAAK4s/w9sbBJ0CWskxznHkVSFyMRyAsphyP9EMQCLcBGAsYHQ/s1280/maxresdefault-min.jpg",
    },
    {
      "title":
          "sed egestas egestas fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae elementum",
      "source": "Kompas",
      "imageURL":
          "https://media-assets-ggwp.s3.ap-southeast-1.amazonaws.com/2020/10/haikyuu-season-4-episode-14-part-2-rilis-640x360.jpg",
    },
    {
      "title":
          "turpis egestas integer eget aliquet nibh praesent tristique magna sit",
      "source": "Detik",
      "imageURL":
          "https://awsimages.detik.net.id/api/wm/2020/07/20/manga-haikyuu-ciptaan-haruichi-furudate-tamat-hari-ini_169.jpeg?wid=60&w=650&v=1&t=jpeg",
    },
    {
      "title": "posuere morbi leo urna molestie",
      "source": "Google",
      "imageURL":
          "https://gizmostory.com/wp-content/uploads/2020/08/Haikyuu-Season-4-1200x720.jpg",
    },
  ];

  @override
  _NewsCardContainerState createState() => _NewsCardContainerState();
}

class _NewsCardContainerState extends State<NewsCardContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(runSpacing: widget.spaceBetweenCards, children: <Widget>[
        for (var newsCard in widget.newsCards)
          NewsCard(
              title: newsCard["title"],
              source: newsCard["source"],
              imageURL: newsCard["imageURL"]),
      ]),
    );
  }
}


// widget.newsCards
//             .map((e) => new NewsCard(
//                   title: e["title"],
//                   source: e["source"],
//                   imageURL: e["imageURL"],
//                 ))
//             .toList(),