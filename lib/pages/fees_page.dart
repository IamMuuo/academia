import 'package:academia/constants/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FeesPage extends StatefulWidget {
  const FeesPage({super.key});

  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  bool _hasStatement = false;
  bool _isLoading = false;
  List<Map> _statements = [];

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    // _statements = await magnet.fetchFeeStatement();
    debugPrint(_statements.toString());
    setState(() {
      _hasStatement = _statements.isNotEmpty;
      _isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fee Statement"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.xmark),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Information",
                content: Column(
                  children: [
                    Image.asset("assets/images/bot_love.png", height: 100),
                    const Text(
                      "On this page everything is as is on the portal visit finance office incase of any inconsitencies or queries for clarification",
                    )
                  ],
                ),
              );
            },
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: _hasStatement
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Feature coming soon!"),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/images/bot_sad.png",
                    height: 300,
                    width: 300,
                  ),
                  const Text(
                    "Hang on tight as we crunch some numbers to provide your fee Statement",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  _isLoading
                      ? LoadingAnimationWidget.hexagonDots(
                          color: Theme.of(context).primaryColorDark, size: 60)
                      : TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.refresh),
                          label: const Text("Try refreshing"),
                        )
                ],
              ),
      ),
    );
  }
}
