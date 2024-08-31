import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/ask_me/models/models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/controllers.dart';
import 'widgets.dart';
import 'package:path/path.dart' as path;


class ModalContent extends StatefulWidget {  
  int? id;
  String? title; 
  String? filepath;
  int? avgScore;
  ModalContent({
    super.key,
    this.id,
    this.title,
    this.filepath, 
    this.avgScore,
  });

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  String? _filePath; 
  String? _fileName;
  bool isLoading = false;

  final QuizSettingsController quizSettingsController = Get.put(QuizSettingsController());
  final FilesController filesController = Get.put(FilesController());
  final AskMeService _askMeService = AskMeService();

  late TextEditingController titleController;
  //TextEditingController titleController = TextEditingController(); 
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();

   @override
  void initState() {
    super.initState();
    // Initialize titleController with the provided title or an empty string if null
    titleController = TextEditingController(text: widget.title ?? '');

    // Set _filePath and _fileName if filepath is provided
    if (widget.filepath != null) {
      _filePath = widget.filepath;
      _fileName = widget.filepath?.split('/').last;
    }
  }

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
      PlatformFile pickedFile = result.files.first;
      if (pickedFile.path == null) {
        throw Exception("File path is null");
      }
      // Get the file size in bytes

      int fileSizeInBytes = pickedFile.size;

      // Define the maximum file size (10MB)
      const int maxFileSizeInBytes = 10 * 1024 * 1024; // 10MB

      // Check if the file size exceeds the maximum allowed size
      if (fileSizeInBytes > maxFileSizeInBytes) {
        throw Exception("File size exceeds the maximum limit of 10MB.");
      }

      File originalFile = File(pickedFile.path!);

      //Get the app's documents directory
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      // Create a unique file name to prevent conflicts
      String uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}';

      // Define the new path
      String newPath = path.join(appDocPath, uniqueFileName);

      // Copy the file
      File copiedFile = await originalFile.copy(newPath);


      setState(() {
        _filePath = copiedFile.path;
        _fileName = copiedFile.path.split('/').last;
      });
      debugPrint("File: $_filePath");
      debugPrint("File Name: $_fileName");
    } else {
      // User canceled the picker
      setState(() {
        _filePath = null;
        _fileName = null; 
      });
    }
  } catch (e) {
    debugPrint("Error picking file: $e");
    showDialog(
      // ignore: use_build_context_synchronously
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text("Failed to upload the file: $e"),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          ),
        ],
      )
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // The maximum allowed time in seconds 
    const int maxTimeInSeconds = 1800; // 30 minutes

     //Update controllers with current values from QuizSettingsController
    void updateControllers() {
      minuteController.text = quizSettingsController.minute.value.toString();
      secondsController.text = quizSettingsController.seconds.value.toString();
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
                ChoiceWidget(label: 'Multiple choice', multipleChoice: true),
                const SizedBox(width: 10),
                ChoiceWidget(label: 'True/False', multipleChoice:  false,),
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
                      Obx(() {
                      // Update the controller values whenever the observed values change
                      updateControllers();
                      return TimeInputField(
                        label: "Minutes",
                        controller: minuteController,
                        onChanged: (value) {
                          quizSettingsController.minute.value = int.tryParse(value) ?? 00;
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
                          quizSettingsController.seconds.value = int.tryParse(value) ?? 00;
                        },
                      );
                    }),
                  ]
                ),
              ],
            ),
            const SizedBox(height: 20.0,),
            const Text(
              "Select a PDF file to upload (Max 10MB):",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5,),
            Row(
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
                child: Text('$_fileName'),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: 
                  isLoading ? 
                    Lottie.asset(
                      "assets/lotties/loading.json",
                      height: 45,
                    ) :
                    FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () async {
                        int? minuteValue = int.tryParse(minuteController.text);
                        int? secondsValue = int.tryParse(secondsController.text);
                        int totalTime = (minuteValue ?? 0) * 60 + (secondsValue ?? 0);
                        //Ensuring title and file path are not null
                        if (titleController.text.isEmpty || _filePath == null) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Error"),
                              content: const Text("Please fill all the fields please"),
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
                        //Ensuring time selected does not exceed specified limit
                        if (totalTime > maxTimeInSeconds) {
                          showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Oops!"),
                              content: const Text("You can't set more than 15 minutes"),
                              actions: [
                                FilledButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Ok"),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        //Validating file existence
                        File file = File(_filePath!);
                        if (!await file.exists()) {
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context, 
                            builder: (context) => AlertDialog(
                              title: const Text("File Not Found"),
                              content: const Text("The uploaded file could not be found. Please re-upload the file."),
                              actions: [
                                FilledButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Ok"),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        quizSettingsController.setTimer(minuteValue!, secondsValue!);
                        try {
                          setState(() {
                          isLoading = true;
                          });
                          int? fileId;
                          AskMeFiles? newFile;
                          //Existing file in the local db hence the file will be updated
                          if(widget.id != null) {
                            final sameFile = AskMeFiles(
                              id: widget.id,
                              title: titleController.text, 
                              filePath: _filePath!, 
                              avgScore: widget.avgScore!,
                            );
                            await filesController.updateFile(sameFile);
                            fileId = widget.id; // Use the existing file ID
                            debugPrint("Field Id of existing file is $fileId");
                          } 
                          else{
                            //Executing this block means the file does not exist, hence the entry would be added to local db
                            AskMeFiles file = AskMeFiles(
                              title: titleController.text,
                              filePath: _filePath!,
                              avgScore: 0,
                            );
                            await filesController.addFile(file);

                            // Reload files to get the updated list
                            await filesController.loadFiles();
                            
                            // Find the newly added file
                            final addedFiles = filesController.files.where((f) => f.filePath == file.filePath).toList();
                            if (addedFiles.isNotEmpty) {
                              newFile = addedFiles.last; // Assuming the newly added file is the last one
                              fileId = newFile.id;
                            } else {
                              throw Exception('Failed to retrieve the new file ID.');
                            }
                          }                  
                          final questionsResponse = await _askMeService.fetchQuestions(        
                            title: titleController.text,
                            filePath: _filePath!,
                            multipleChoice: quizSettingsController.multipleChoice.value,
                          );
                          setState(() {
                            isLoading = false;
                          });
                          debugPrint("After clicking Generate Button");
                          debugPrint("Title: ${titleController.text}");
                          debugPrint("File Path: $_filePath");
                          debugPrint("Question Type: ${quizSettingsController.multipleChoice.value}");
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return QuestionScreen(
                                    multipleChoiceQuiz: quizSettingsController.multipleChoice.value == true ? questionsResponse as MultipleChoiceQuiz : null,
                                    trueFalseQuiz: quizSettingsController.multipleChoice.value == true ? null : questionsResponse as TrueFalseQuiz,
                                    title: titleController.text,
                                    id: fileId,
                                    filePath: _filePath!,
                                );
                              }                            
                            ),
                          );
                        } catch (e) {
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Error"),
                              content: Text(e.toString()),
                              actions: [
                                FilledButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Oh ok"),
                                ),
                              ],
                            ),
                          );
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