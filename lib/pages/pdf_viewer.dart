import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({
    super.key,
    required this.title,
    required this.url,
  });
  final String title, url;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PDFViewController _pdfViewerController;
  int currentPage = 0, totalPages = 0;
  bool isReady = false;
  String errorMessage = '';

  Future<Uint8List> _loadPdf() async {
    try {
      setState(() {
        isReady = false;
      });
      final response = await http.get(Uri.parse(widget.url));
      if (response.statusCode != 200) {
        throw "Error while fetching content";
      }

      setState(() {
        isReady = true;
      });
      return response.bodyBytes;
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
    return Uint8List(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Information",
                  content: Column(
                    children: [
                      Image.asset("assets/images/bot_love.png", height: 100),
                      const Text(
                        "Swipe down to reveal more pages, pinch out to zoom out, pinch in to zoom",
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.info)),
        ],
      ),
      body: FutureBuilder(
          future: _loadPdf(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? snapshot.hasError
                    ? Center(
                        child: Column(
                          children: [
                            Image.asset("assets/images/bot_sad.png"),
                            Text(snapshot.error.toString()),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          PDFView(
                            fitPolicy: FitPolicy.BOTH,
                            pdfData: snapshot.data,
                            pageFling: true,
                            defaultPage: currentPage,
                            onPageChanged: (page, total) {
                              setState(() {
                                currentPage = page!;
                              });
                            },
                            onRender: (_pages) {
                              setState(() {});
                            },
                            onError: (error) {
                              debugPrint("Error");
                            },
                          ),
                        ],
                      )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.flickr(
                          leftDotColor: Theme.of(context).primaryColor,
                          rightDotColor: Theme.of(context).primaryColorDark,
                          size: 80,
                        ),
                        const Text("Loading .."),
                      ],
                    ),
                  );
          }),
    );
  }
}
