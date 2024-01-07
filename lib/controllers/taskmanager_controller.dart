import 'package:get/get.dart';

class TaskManagerController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }
}
