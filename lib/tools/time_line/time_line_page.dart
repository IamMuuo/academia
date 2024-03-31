import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:intl/intl.dart';

class TimeLinePage extends StatelessWidget {
  const TimeLinePage({super.key});

  Widget buildEventsWidget() {
    List<Widget> eventWidgets = <Widget>[];

    var events = appDB.get("academic_calendar");
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');

    for (var event in events) {
      eventWidgets.add(SemesterTimeLineTile(
          isFirst: event == events.first ? true : false,
          isLast: event == events.last ? true : false,
          isPast: inputFormat
                  .parse(event["stop"].toString().trim())
                  .isAfter(DateTime.now())
              ? false
              : true,
          title: event["name"],
          content:
              "${event['name'].toString().trim()} is sceduled between ${event['start'].toString().trim()} and ${event['stop'].toString().trim()}"));
    }
    return ListView(
      children: eventWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    NotificationsController controller = Get.find<NotificationsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semester Timeline"),
        elevation: 0,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.flickr(
                      rightDotColor: Theme.of(context).colorScheme.primary,
                      leftDotColor: Theme.of(context).colorScheme.tertiary,
                      size: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text("Hang on tight we're crunching numbers"),
                    ),
                  ],
                ),
              )
            : LiquidPullToRefresh(
                onRefresh: () async {
                  controller.isLoading.value = true;
                  await controller.fetchAcademicCalendar();
                  controller.isLoading.value = false;
                },
                height: 200,
                child: controller.hasCalendar
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: buildEventsWidget(),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/girl_sitted.png",
                              height: 200,
                            ),
                            const Text(
                              "Darn you got us but we are working to provide your semester's timeline",
                              textAlign: TextAlign.center,
                            ),
                            FilledButton.icon(
                              onPressed: () async {
                                controller.isLoading.value = true;
                                await controller.fetchAcademicCalendar();
                                controller.isLoading.value = false;
                              },
                              icon: const Icon(Ionicons.refresh),
                              label: const Text("Try again"),
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
