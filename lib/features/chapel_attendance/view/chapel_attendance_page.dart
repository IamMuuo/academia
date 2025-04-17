import 'dart:async';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:academia/utils/validator/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:vibration/vibration.dart';

class ChapelAttendancePage extends StatefulWidget {
  const ChapelAttendancePage({super.key});

  @override
  State<ChapelAttendancePage> createState() => _ChapelAttendancePageState();
}

class _ChapelAttendancePageState extends State<ChapelAttendancePage>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
      // required options for the scanner
      );
  final TextEditingController stdAdm = TextEditingController();
  StreamSubscription<Object?>? _subscription;
  bool isLoading = false;
  String prevAdm = "";

  void _handleBarCode(BarcodeCapture event) async {
    Map rawData = event.raw as Map;

    var admno = rawData['data'][0]['rawValue'];

    if (prevAdm == admno) return;
    stdAdm.text = admno;
    _showAdmissionInput();

    final today = DateTime.now();
    BlocProvider.of<AttendanceBloc>(context).add(
      AttendanceMarkingRequested(
        record: AttendanceModelData(
          studentID: admno,
          date: DateTime(today.year, today.month, today.day).toLocal(),
          checkIn: 'present',
          campus: 'athi river',
        ),
      ),
    );
    if (await Vibration.hasVibrator()) {
      await Vibration.vibrate(
        duration: 32,
        sharpness: 250,
      );
    }
    prevAdm = admno;
    stdAdm.clear();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = controller.barcodes.listen(_handleBarCode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  DateTime _getNextTuesday() {
    DateTime now = DateTime.now();
    if (now.weekday == DateTime.tuesday && now.hour < 10) {
      return now.copyWith(hour: 10, minute: 0, second: 0);
    }
    now = DateTime.now().copyWith(hour: 0, minute: 0, second: 0);
    int daysToAdd = (DateTime.tuesday - now.weekday + 7) % 7;
    daysToAdd = daysToAdd == 0 ? 7 : daysToAdd;
    return now.add(Duration(days: daysToAdd));
  }

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = controller.barcodes.listen(_handleBarCode);

  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    await controller.dispose();
  }

  void _showAdmissionInput() => showModalBottomSheet(
      context: context,
      builder: (context) {
        // final TextEditingController stdAdm = TextEditingController();
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 42.0,
            bottom: 16.0,
          ),
          child: BlocListener<AttendanceBloc, AttendanceState>(
            listener: (context, state) {
              if (state is AttendanceMarkedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                return;
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: stdAdm,
                    inputFormatters: [
                      AdmnoDashFormatter(),
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          final today = DateTime.now();
                          BlocProvider.of<AttendanceBloc>(context).add(
                            AttendanceMarkingRequested(
                              record: AttendanceModelData(
                                studentID: stdAdm.text,
                                date:
                                    DateTime(today.year, today.month, today.day)
                                        .toLocal(),
                                checkIn: 'present',
                                campus: 'athi river',
                              ),
                            ),
                          );
                        },
                        icon: Icon(Clarity.check_line),
                      ),
                      hintText: "xx-xxxx",
                      label: const Text("Student Admission Number"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  BlocBuilder<AttendanceBloc, AttendanceState>(
                    buildWhen: (statA, stateB) {
                      if (stateB is AttendanceLoadingState ||
                          stateB is AttendaceErrorState) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      if (state is AttendanceLoadingState) {
                        return Column(
                          spacing: 12,
                          children: [
                            Lottie.asset(
                              "assets/lotties/search.json",
                              height: 200,
                              width: 200,
                            ),
                          ],
                        );
                      }
                      if (state is AttendaceErrorState) {
                        return Column(
                          spacing: 12,
                          children: [
                            Lottie.asset(
                              "assets/lotties/cat-error.json",
                              height: 200,
                              width: 200,
                            ),
                            Text(
                              state.error,
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                        );
                      }
                      return Column(
                        spacing: 12,
                        children: [
                          Lottie.asset(
                            "assets/lotties/bunny.json",
                            height: 200,
                            width: 200,
                          ),
                          Text(
                            "Please provide a student admission number to continue",
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 128,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/scan.jpg",
                fit: BoxFit.cover,
              ),
              title: Text("Chapel").animate(delay: 250.ms).fadeIn(
                    curve: Curves.easeInCubic,
                    duration: 1000.ms,
                  ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.pushNamed("profile");
                },
                icon: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (stateA, stateB) {
                    if (stateB is AuthenticatedState) return true;
                    return false;
                  },
                  builder: (context, state) => CircleAvatar(
                    backgroundImage: MemoryImage(
                      (state as AuthenticatedState).user.picture ??
                          Uint8List(0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: MultiSliver(
              //spacing: 12,
              children: [
                Text(
                  "Get started marking chapel attendance. Scan to continue",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontFamily: GoogleFonts.lora().fontFamily,
                      ),
                ).animate(delay: 1000.ms).fadeIn(
                      curve: Curves.bounceIn,
                      duration: 1500.ms,
                    ),
                SizedBox(height: 16),
                Container(
                  constraints: BoxConstraints(
                    minWidth: 250,
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.width,
                    minHeight: 250,
                  ),
                  child: MobileScanner(
                    controller: controller,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: TimerCountdown(
                      timeTextStyle:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontFamily: GoogleFonts.dynaPuff().fontFamily,
                              ),
                      format: CountDownTimerFormat.daysHoursMinutesSeconds,
                      endTime: _getNextTuesday(),
                      onEnd: () {
                        context.goNamed("home");
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12),
                FilledButton.icon(
                  label: Text("Try with admission number"),
                  onPressed: _showAdmissionInput,
                  icon: Icon(Clarity.id_badge_solid),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
