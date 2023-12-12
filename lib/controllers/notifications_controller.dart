import 'package:academia/constants/common.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {

  // fetches the event calendar
  Future<void> fetchAcademicCalendar() async {
    var events = await magnet.fetchAcademicCalendar();
    if (events.isNotEmpty) {
      await appDB.put("academic_calendar", events);
    }
  }
}
