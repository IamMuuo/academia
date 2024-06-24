export 'todo_home_screen.dart';
export 'models/models.dart';
export 'controllers/todo_controller.dart';
export 'widgets/widgets.dart';
import "package:intl/intl.dart";

// Helper functions
String trimAndEllipsis(String input, int maxLength) {
  if (input.length <= maxLength) {
    return input;
  } else {
    return "${input.substring(0, maxLength)}...";
  }
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('EEEE, d MMM y • H:mm a').format(dateTime);
}
