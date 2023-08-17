import 'package:academia/controllers/webview_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatelessWidget {
  const WebviewPage({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    WebViewPageController webPageController =
        Get.put(WebViewPageController(link: url));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.xmark),
        ),
        backgroundColor: Colors.blue,
        title: Text(title),
      ),
      body: WebViewWidget(controller: webPageController.controller),
    );
  }
}
