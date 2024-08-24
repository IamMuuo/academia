import 'package:academia/exports/barrel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';
import '../pages/pages.dart';
import 'widgets.dart';


class HardCodedQuestion {
  String id;
  String question;
  List<String> choices; // Either multple choice ot True/False
  String correctAnswer;

  HardCodedQuestion({
    required this.id,
    required this.question,
    required this.choices,
    required this.correctAnswer,
  });
}
class ModalContent extends StatefulWidget {  
  ModalContent({super.key});

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  String? _filePath; 
  String? _fileName;

  final QuizSettingsController timerController = Get.put(QuizSettingsController());
  final FilesController filesController = Get.put(FilesController());

  TextEditingController titleController = TextEditingController(); 
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();

  List<HardCodedQuestion> questions = [
    HardCodedQuestion(
      id: '1',
      question: 'What is the capital of France?',
      choices: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correctAnswer: 'Paris',
    ),
    HardCodedQuestion(
      id: '2',
      question: 'What is the largest planet in our solar system?',
      choices: ['Earth', 'Jupiter', 'Mars', 'Saturn'],
      correctAnswer: 'Jupiter',
    ),
    HardCodedQuestion(
      id: '3',
      question: 'What is the chemical symbol for water?',
      choices: ['H2O', 'O2', 'CO2', 'NaCl'],
      correctAnswer: 'H2O',
    ),
    HardCodedQuestion(
      id: '4',
      question: 'What is the hardest natural substance on Earth?',
      choices: ['Gold', 'Iron', 'Diamond', 'Platinum'],
      correctAnswer: 'Diamond',
    ),
    HardCodedQuestion(
      id: '5',
      question: 'Who wrote "To Kill a Mockingbird"?',
      choices: ['Harper Lee', 'J.K. Rowling', 'Ernest Hemingway', 'Mark Twain'],
      correctAnswer: 'Harper Lee',
    ),
    HardCodedQuestion(
      id: '6',
      question: 'Which element has the chemical symbol "Au"?',
      choices: ['Silver', 'Gold', 'Iron', 'Copper'],
      correctAnswer: 'Gold',
    ),
    HardCodedQuestion(
      id: '7',
      question: 'What is the largest ocean on Earth?',
      choices: ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
      correctAnswer: 'Pacific Ocean',
    ),
    HardCodedQuestion(
      id: '8',
      question: 'Who painted the Mona Lisa?',
      choices: ['Vincent van Gogh', 'Leonardo da Vinci', 'Pablo Picasso', 'Claude Monet'],
      correctAnswer: 'Leonardo da Vinci',
    ),
    HardCodedQuestion(
      id: '9',
      question: 'What is the smallest prime number?',
      choices: ['0', '1', '2', '3'],
      correctAnswer: '2',
    ),
    HardCodedQuestion(
      id: '10',
      question: 'Which planet is known as the Red Planet?',
      choices: ['Venus', 'Mars', 'Mercury', 'Neptune'],
      correctAnswer: 'Mars',
    ),
  ];

  //Function to handle uploading of files
 Future<void> _pickFile() async {
  try {
    debugPrint("Upload button pressed");
    // Opens the file picker and allows user to select files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      // If a file is selected, update the file name and path
      PlatformFile file = result.files.first;
      setState(() {
        _filePath = file.path;
        _fileName = file.name;
      });
      debugPrint("File: $_filePath");
      //debugPrint("File name: $_fileName");
    } else {
      // User canceled the picker
      setState(() {
        _filePath = null;
        _fileName = null; 
      });
    }
  } catch (e) {
    debugPrint("Error picking file: $e");
    rethrow;
  }
}
  


  @override
  Widget build(BuildContext context) {
    // Define the maximum allowed time in seconds
    const int maxTimeInSeconds = 900; // 15 minutes

     //Update controllers with current values from QuizSettingsController
    void updateControllers() {
      minuteController.text = timerController.minute.value.toString();
      secondsController.text = timerController.seconds.value.toString();
    }

    // Update controllers when the widget is built
    updateControllers();

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.length == null) {
                  return "Please enter a title";
                }
                return null;
                },
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: "Please Enter Title for your Document",
                label: const Text("Title"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            const Text(
              'Question type',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                ChoiceWidget(label: 'Multiple choice'),
                const SizedBox(width: 10),
                ChoiceWidget(label: 'True/False'),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Set a timer",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    // //Obx(() => TimeInputField(label: "Seconds",  controller: minuteController)),
                    // TimeInputField(label: "Seconds",  controller: minuteController),
                    // //TimeInputField(label: "Minute", initialValue: 2),
                    // const Text(" : ", style: TextStyle(fontSize: 20)),
                    // //Obx(() => TimeInputField(label: "Seconds", controller: secondsController)),
                    // TimeInputField(label: "Seconds", controller: secondsController)
                    // //TimeInputField(label: "Seconds", initialValue: 30),
                      Obx(() {
                      // Update the controller values whenever the observed values change
                      updateControllers();
                      return TimeInputField(
                        label: "Minutes",
                        controller: minuteController,
                        onChanged: (value) {
                          timerController.minute.value = int.tryParse(value) ?? 00;
                        },
                      );
                    }),
                    const Text(" : ", style: TextStyle(fontSize: 20)),
                    Obx(() {
                      // Update the controller values whenever the observed values change
                      updateControllers();
                      return TimeInputField(
                        label: "Seconds",
                        controller: secondsController,
                        onChanged: (value) {
                          timerController.seconds.value = int.tryParse(value) ?? 00;
                        },
                      );
                    }),
                  ]
                ),
              ],
            ),
            const SizedBox(height: 20.0,),
            const Text(
              "Upload a file:",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              //mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton(
                  
                  onPressed: () async{
                    
                    await _pickFile();
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text("Upload a File"),
                ),
              ],
            ),
            if(_filePath != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('File Path: $_fileName'),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async{
                    int? minuteValue = int.tryParse(minuteController.text)!;
                    int? secondsValue = int.tryParse(secondsController.text)!;
                    int _totalTime = minuteValue * 60 + secondsValue; // use minutes and seconds
        
                    if (titleController.text.isEmpty) {
                      showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Error"),
                              content:
                                  const Text("Please enter the title"),
                              actions: [
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Oh ok"),
                                ),
                              ],
                            ),
                          );
                          return;
                    }
                    else {
                      if (_totalTime < maxTimeInSeconds) {
                      timerController.setTimer(minuteValue, secondsValue); 

                      

                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => QuestionScreen(
                          questions: questions,
                          title: titleController.text,
                          filePath: _filePath!,
                        ))
                      );
                      }
                      else {
                      showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Oops!"),
                          content: const Text("You can't put more than 15 minutes"),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              }, 
                              child: const Text("Ok"),
                            ),
                          ],
                        )
                      );
                    } 
                    }          
                  }, 
                  child: const Text("Generate"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}