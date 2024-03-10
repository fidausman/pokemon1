import 'package:app/shared/models/article.dart';
import 'package:flutter/material.dart';

class NewsDetailsScreen extends StatefulWidget {
  final Article article;
  const NewsDetailsScreen({
    super.key,
    required this.article,
  });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: height * .45,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(40)),
                  child: Image.network(
                    widget.article.urlToImage!,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcFOPu1YDIeX4wKXG3cI-wgDeS7OznQgdJ5A&usqp=CAU");
                    },
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
                height: height * 0.6,
                margin: EdgeInsets.only(top: height * 0.4),
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(40)),
                ),
                child: ListView(children: [
                  Text(widget.article.title,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(children: [
                    Expanded(
                      child: Text(widget.article.source.name,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600)),
                    ),
                    Text(widget.article.publishedAt.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500)),
                  ]),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(widget.article.content,
                      style: TextStyle(fontSize: 15, color: Colors.black87))
                ]))
          ],
        ));
  }
}
