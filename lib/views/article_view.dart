import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  final String url;
  final String source;

  const ArticleScreen({Key key, this.url, this.source}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        actions: [
          GestureDetector(
            onTap: () {
              share(context, widget.url);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.share,
              ),
            ),
          )
        ],
      ),
      body: WebView(
        initialUrl: widget.url,
        onWebViewCreated: (controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}

void share(BuildContext context, String url) {
  final RenderBox box = context.findRenderObject();
  final String text = "Article Url";
  Share.share(
    url,
    subject: text,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}
