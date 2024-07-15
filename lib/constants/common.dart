// const String urlPrefix = "https://daystar-backend-atrocious-jpg.vercel.app";
// For local development

import 'package:magnet/magnet.dart';

late Magnet magnet;

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String title() {
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.toCapitalized())
        .join(' ');

    // return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

// Returns the day percent gone
double dayPercentGone() {
  DateTime now = DateTime.now();
  DateTime startOfDay = DateTime(now.year, now.month, now.day);
  DateTime endOfDay = startOfDay.add(
    const Duration(
      days: 1,
    ),
  );

  double elapsedSeconds = now.difference(startOfDay).inSeconds.toDouble();
  double totalSeconds = endOfDay.difference(startOfDay).inSeconds.toDouble();

  double percent = (elapsedSeconds / totalSeconds) * 100;
  return percent;
}

double weekPercentGone() {
  DateTime now = DateTime.now();

  // Determine the start of the current week (assuming week starts on Monday)
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  startOfWeek = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

  // Determine the end of the current week
  DateTime endOfWeek = startOfWeek.add(
    const Duration(
      days: 7,
    ),
  );

  // Calculate the number of seconds elapsed since the start of the week
  double elapsedSeconds = now.difference(startOfWeek).inSeconds.toDouble();

  // Calculate the total number of seconds in a week
  double totalSeconds = endOfWeek.difference(startOfWeek).inSeconds.toDouble();

  // Calculate the percentage of the week gone
  double percent = (elapsedSeconds / totalSeconds) * 100;

  return percent;
}

int getNumericDayOfWeek(String dayOfWeek) {
  switch (dayOfWeek.toLowerCase()) {
    case 'monday':
      return 1;
    case 'tuesday':
      return 2;
    case 'wednesday':
      return 3;
    case 'thursday':
      return 4;
    case 'friday':
      return 5;
    case 'saturday':
      return 6;
    case 'sunday':
      return 7;
    default:
      return 0; // Handle unknown dayOfWeek
  }
}
