import 'package:flutter/material.dart';

class NewsCard extends StatefulWidget {
  final double newsCardTitleFont = 12;
  final double newsCardSourceFont = 8;
  final double newsCardTitlePadding = 26;
  final double newsCardHeight = 120;
  final double newsCardTitleHeight = 60.5;
  final double borderRadius = 20;

  final String title;
  final String source;
  final String imageURL;

  const NewsCard({Key key, this.title, this.source, this.imageURL})
      : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.newsCardHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: Colors.white),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Container(
                    padding: EdgeInsets.all(widget.newsCardTitlePadding),
                    child: Wrap(
                      children: [
                        Container(
                          height: widget.newsCardTitleHeight,
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: widget.newsCardTitleFont,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          child: Text(widget.source,
                              style: TextStyle(
                                fontSize: widget.newsCardSourceFont,
                                fontWeight: FontWeight.w300,
                              )),
                          alignment: Alignment.centerLeft,
                        )
                      ],
                    ))),
            Expanded(
                flex: 4,
                child: ClipRRect(
                  child: Image.network(
                    widget.imageURL,
                    fit: BoxFit.cover,
                    height: widget.newsCardHeight,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ))
          ],
        ));
  }
}
