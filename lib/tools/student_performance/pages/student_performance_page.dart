import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum StudentPerfomanceParameter { audit, transcript }

class StudentPerformancePage extends StatefulWidget {
  const StudentPerformancePage({
    super.key,
    required this.parameter,
  });
  final StudentPerfomanceParameter parameter;

  @override
  State<StudentPerformancePage> createState() => _StudentPerformancePageState();
}

class _StudentPerformancePageState extends State<StudentPerformancePage> {
  final SettingsController _settingsController = Get.find<SettingsController>();
  final UserController _userController = Get.find<UserController>();
  bool documentLocked = true;
  int currentPage = 0, totalPages = 0;
  bool isReady = false;
  String errorMessage = '';

  Future<Uint8List> _loadPdf() async {
    try {
      setState(() {
        isReady = false;
      });
      final response = await http.get(Uri.parse(widget.parameter ==
              StudentPerfomanceParameter.transcript
          ? "https://student.daystar.ac.ke/Downloads/STDAUDIT-${_userController.user.value!.admissionNumber}.pdf"
          : "https://student.daystar.ac.ke/Downloads/PROVISIONAL%20RESULTS-${_userController.user.value!.admissionNumber}.pdf"));
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
  void initState() {
    super.initState();

    if (_settingsController.settings.value.showAudit &&
        widget.parameter == StudentPerfomanceParameter.audit) {
      documentLocked = false;
      return;
    }

    if (_settingsController.settings.value.showTranscript &&
        widget.parameter == StudentPerfomanceParameter.transcript) {
      documentLocked = false;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.parameter == StudentPerfomanceParameter.audit
              ? "Student Audit"
              : "Student Transcript",
        ),
      ),
      body: documentLocked
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "The requested document cannot be loaded because the document is locked from the settings page",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : FutureBuilder(
              future: _loadPdf(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? snapshot.hasError
                        ? Center(
                            child: Column(
                              children: [
                                Image.asset("assets/images/bot_sad.png"),
                                Text(
                                  snapshot.error.toString(),
                                ),
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
                                onRender: (pages) {
                                  setState(() {});
                                },
                                onError: (error) {
                                  debugPrint("Error");
                                },
                              ),
                            ],
                          )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Loading .."),
                          ],
                        ),
                      );
              }),
    );
  }
}
