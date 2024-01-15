import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({
    super.key,
    required this.title,
    required this.url,
  });
  final String url;
  final String title;

  @override
  State<WebviewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebviewPage> {
  late final WebViewController _controller;
  double _loadingPercent = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(onWebResourceError: (error) {
        Get.snackbar("Error", error.description);
      }, onPageFinished: (url) {
        setState(() {
          _loadingPercent = 100;
        });
      }, onProgress: (progress) {
        setState(() {
          _loadingPercent = progress.toDouble();
        });
      }, onPageStarted: ((url) {
        setState(() {
          _loadingPercent = 0;
        });
      })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          LinearProgressIndicator(
            value: _loadingPercent / 100.0,
          )
        ],
      ),
    );
  }
}
