import 'package:academia/exports/barrel.dart';
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
  final FilesAndScoresController filesAndScoresController =
      Get.put(FilesAndScoresController());

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
        // toolbarHeight: 75,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);   
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Information"),
                  content: const Text(
                      "Want to test whether you have understood the notes from class? Don't worry, we have got you covered by simply uploading your pdf notes from class and our AI model will generate ten questions for you to test yourself. "),
                  actions: [
                    FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Oh ok")),
                  ],
                ),
              );
            },
            icon: const Icon(Ionicons.information_circle),
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/askMe_Home.jpeg',
              fit: BoxFit.cover,
              height: 400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: Container(
                //color: lightColorScheme.tertiary,
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  if (filesAndScoresController.files.isEmpty) {
                    return CustomPaint(
                      painter: DottedBorderPainter(),
                      child: const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Text(
                            'Interact with our AI model to get started',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filesAndScoresController.files.length,
                        itemBuilder: (context, index) {
                          final file = filesAndScoresController.files[index];
                          final fileScores = filesAndScoresController.scores
                              .where((score) => score.filesId == file.id)
                              .toList();
                          // final fileScores = filesAndScoresController.fetchScoresByFileId(file.id!);
                          return ExpansionTile(
                            title: Text(file.title),
                            children: [
                              ListTile(
                                title: Text(
                                  'Average score is: ${file.avgScore}/10',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Wrap(
                                  spacing: 8.0,
                                  children: fileScores.map((score) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Score ${fileScores.indexOf(score) + 1}:',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${score.score}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          child: const Text(
                                              '+ Generate more questions from this file',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Confirm Deletion'),
                                                  content: const Text(
                                                      'Are you sure you want to clear this file?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child:
                                                          const Text('Cancel'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text('Clear'),
                                                      onPressed: () {
                                                        filesAndScoresController
                                                            .deleteFile(file);
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog after deletion
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'x Clear this file from the history list',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  }
                })),
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

  Future<void> _bottomSheet(BuildContext context,
      {int? id, String? title, String? filepath, int? avgScore}) {
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
