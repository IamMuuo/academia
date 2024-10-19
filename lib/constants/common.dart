// const String urlPrefix = "https://daystar-backend-atrocious-jpg.vercel.app";
// For local development

import 'package:academia/exports/barrel.dart';

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

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

String trimTo99Characters(String text) {
  if (text.length <= 99) {
    return text;
  } else {
    return '${text.substring(0, 96)}...';
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

/// Returns the pecentage of time gone
double calculateSemesterPercent(DateTime start, DateTime end) {
  Duration totalDuration = end.difference(start);

  DateTime now = DateTime.now();
  Duration elapsedDuration = now.difference(start);

  double percentage =
      (elapsedDuration.inMilliseconds / totalDuration.inMilliseconds) * 100;

  if (percentage < 0) {
    return 0;
  } else if (percentage > 100) {
    return 100;
  } else {
    return percentage;
  }
}

// Extension method to convert weekday number to string
extension WeekdayToString on DateTime {
  String weekdayToString() {
    switch (weekday) {
      case DateTime.monday:
        return "MONDAY";
      case DateTime.tuesday:
        return "TUESDAY";
      case DateTime.wednesday:
        return "WEDNESDAY";
      case DateTime.thursday:
        return "THURSDAY";
      case DateTime.friday:
        return "FRIDAY";
      case DateTime.saturday:
        return "SATURDAY";
      case DateTime.sunday:
        return "SUNDAY";
      default:
        return "";
    }
  }
}
