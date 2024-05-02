import 'package:get/get.dart';
import 'package:academia/models/models.dart';

class DashboardController extends GetxController {
  double get weekPercent {
    int weekDay = DateTime.now().weekday;
    return weekDay / 7;
  }

  double get semesterPercent {
    var month = DateTime.now().month;
    if (month > DateTime.january && month < DateTime.april) {
      return month / DateTime.april;
    } else if (month > DateTime.april && month < DateTime.july) {
      return month / DateTime.july;
    }
    return month / DateTime.december;
  }

  String get getDayPercentQuote {
    if (daypercent > 0.75) {
      return "Take a break!";
    } else if (daypercent > 0.5) {
      return "Sun down approaches";
    } else if (daypercent > 0.25) {
      return "Its almost midday☀️";
    }
    return "The early bird..!";
  }

  String get getWeekPercentQuote {
    if (weekPercent > 0.75) {
      return "The weekend 🙃!";
    } else if (daypercent > 0.5) {
      return "Weekend is coming😉";
    } else if (daypercent > 0.25) {
      return "Focus, its tough we get it";
    }
    return "Nothing to say?";
  }

  String get getSemesterPercentQuote {
    if (semesterPercent > 0.90) {
      return "Relax, it was a tough one!😅";
    } else if (semesterPercent > 0.75) {
      return "Projects, exams panic!";
    } else if (semesterPercent > 0.5) {
      return "Its about to get real messy";
    } else if (semesterPercent > 0.25) {
      return "CATS CATS, cats all the way";
    }
    return "Ready, aim shoot!";
  }

  double get daypercent {
    int hours = DateTime.now().hour;
    return (hours / 24);
  }

  int get classesTodayCount {
    return 0;
  }

  int get numberofTasks {
    return 0;
  }

  int get classesTommorrowCount {
    return 0;
  }

  List<Course> get classesToday {
    return List.empty();
  }

  List<Course> get classesTommorrow {
    return List.empty();
  }
}
