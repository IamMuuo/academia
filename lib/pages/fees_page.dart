import 'package:academia/constants/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FeesPage extends StatefulWidget {
  const FeesPage({super.key, required this.allStatements});
  final List<Map> allStatements;

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
    _statements = widget.allStatements;
    setState(() {
      _hasStatement = _statements.isNotEmpty;
      _isLoading = false;
    });

    super.initState();
  }

  void _runStatementFilter(String enteredKeyWord) {
    List<Map> results = [];
    if (enteredKeyWord.isEmpty) {
      results = _statements;
    } else {
      results = widget.allStatements
          .where((element) => element["description"]
              .toString()
              .toLowerCase()
              .trim()
              .contains(enteredKeyWord.toLowerCase()))
          .toList();
    }
    // refresh the ui
    setState(() {
      _statements = results;
    });
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
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: TextField(
                      onChanged: (value) => _runStatementFilter(value),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        hintText: "Activity fee",
                        label: Text("Search for statement"),
                        suffixIcon: Icon(CupertinoIcons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: ListView.builder(
                      itemCount: _statements.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: ListTile(
                              leading: const Icon(Icons.numbers),
                              title: Text(
                                _statements[index]["ref"].toString().trim(),
                              ),
                              subtitle: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    _statements[index]["description"]
                                        .toString()
                                        .trim(),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Debit ",
                                        style: normal.copyWith(
                                            color: Colors.red, fontSize: 10),
                                      ),
                                      Text(
                                        _statements[index]["debit"]
                                            .toString()
                                            .trim(),
                                        style: normal.copyWith(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Credit ",
                                        style: normal.copyWith(
                                            color: Colors.green, fontSize: 10),
                                      ),
                                      Text(
                                        _statements[index]["credit"]
                                            .toString()
                                            .trim(),
                                        style: normal.copyWith(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Balance ",
                                        style: normal.copyWith(
                                            color: Colors.blue, fontSize: 10),
                                      ),
                                      Text(
                                        _statements[index]["running_balance"]
                                            .toString()
                                            .trim(),
                                        style: normal.copyWith(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.today),
                                      const SizedBox(width: 8),
                                      Text(
                                        _statements[index]["posting_date"]
                                            .toString()
                                            .trim(),
                                        style: normal.copyWith(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            _statements = await magnet.fetchFeeStatement();
                            setState(() {
                              _hasStatement = _statements.isNotEmpty;
                              _isLoading = false;
                            });
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text("Try refreshing"),
                        )
                ],
              ),
      ),
    );
  }
}
