import 'package:academia/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';
import '../widgets/widgets.dart';

class AskMeHome extends StatefulWidget {
  const AskMeHome({super.key});

  @override
  State<AskMeHome> createState() => _AskMeHomeState();
}

class _AskMeHomeState extends State<AskMeHome> {
  TextEditingController titleController = TextEditingController();
  final QuizSettingsController timerController = Get.put(QuizSettingsController());
  final FilesController filesController = Get.put(FilesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ask Me".toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 75,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // const SizedBox(height: 20,),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),          
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             "Ask Me".toUpperCase(),
          //             style: const  TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 32,
          //             ),
          //           ),
          //         ],
          //       ),              
          // ),
          //const SizedBox(height: 20,),
          Center(
            child: Image.asset(
              'assets/images/askMe_Home.jpeg',
              fit: BoxFit.cover,
              height: 400,
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            flex: 1,
            child: Container(
              //color: lightColorScheme.tertiary,
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                if (filesController.files.isEmpty) {
                  // return const Center(
                  //   child: Text(
                  //     "Interact with our AI model to get started",
                  //     style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  //   ),
                  // );
                  return CustomPaint(
                    painter: DottedBorderPainter(),
                    child: const SizedBox(
                      width: 400,
                      height: 100,
                      child: Center(
                        child: Text(
                          'Interact with our AI model to get started',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                        ),
                      ),
                    ),
                  );
                }
                else{
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filesController.files.length,
                    itemBuilder: (context, index) {
                      final file = filesController.files[index];
                      final fileScores = filesController.scores
                      .where((score) => score.filesId == file.id)
                      .toList();
                      return ExpansionTile(
                        title: Text(file.title),
                        children: [
                          ListTile(
                            title: Text('Average score is: ${file.avgScore}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Wrap(
                              spacing: 8.0,
                              children: fileScores.map((score) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Score ${fileScores.indexOf(score) + 1}:'),
                                    const Spacer(),
                                    Text('${score.score}'),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _bottomSheet(
                                        context,
                                        id: file.id,
                                        title: file.title,
                                        filepath: file.filePath,
                                        avgScore: file.avgScore,
                                      );
                                    }, 
                                    child: const Text('+ Generate more questions from this file', style: TextStyle()),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      filesController.deleteFile(file);
                                    }, 
                                    child: const Text('x clear this file from the history list', style: TextStyle(fontSize: 16, color: Colors.redAccent)),
                                  )
                                ],
                              ),
                            ),
                          ),
                         
                        ],
                      );
                    }
                  );
                }
              })
            ),             
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _bottomSheet(BuildContext context, {int? id,String? title, String? filepath, int? avgScore}) {
  return showModalBottomSheet(
    backgroundColor: lightColorScheme.onPrimary,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => FractionallySizedBox(
      heightFactor: 0.7,
      child: ModalContent(
        id: id,
        title: title,
        filepath: filepath,
        avgScore: avgScore,
      ),
    ),
  );
}

}