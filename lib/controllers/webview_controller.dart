import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageController extends GetxController {
  WebViewPageController({required this.link}) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          if (request.url.startsWith("https://www.github.com/") ||
              request.url.startsWith("https://elearnig.daystar.ac.ke") ||
              request.url.startsWith("https://student.daystar.ac.ke/")) {
            return NavigationDecision.navigate;
          } else {
            return NavigationDecision.prevent;
          }
        },
      ))
      ..loadRequest(Uri.parse(link));
  }
  final String link;
  late WebViewController controller;
}
