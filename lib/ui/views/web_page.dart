import 'package:entry_assignment/core/viewmodels/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  final String image_url;
  WebPage({Key key, @required this.image_url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'GitHub Repository',
        context: context,
        actionsItems: null,
      ),
      body: WebView(
        initialUrl: image_url,
      ),
    );
  }
}
