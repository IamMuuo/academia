import 'package:academia/exports/barrel.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class TodoHeatMap extends StatelessWidget {
  const TodoHeatMap({super.key, required this.todos});
  final List<Todo> todos;

  Map<DateTime, int> _generateDataSet(List<Todo> todos) {
    Map<DateTime, int> dataSet = {};

    for (var todo in todos) {
      DateTime dueDateWithoutTime =
          DateTime(todo.due.year, todo.due.month, todo.due.day);

      if (dataSet.containsKey(dueDateWithoutTime)) {
        dataSet[dueDateWithoutTime] = dataSet[dueDateWithoutTime]! + 1;
      } else {
        dataSet[dueDateWithoutTime] = 1;
      }

      // Date added
      DateTime dateAdded = DateTime(
          todo.dateAdded.year, todo.dateAdded.month, todo.dateAdded.day);

      if (dataSet.containsKey(dateAdded)) {
        dataSet[dateAdded] = dataSet[dateAdded]! + 1;
      } else {
        dataSet[dateAdded] = 1;
      }

      // Process dateCompleted (if present)
      if (todo.dateCompleted != null) {
        DateTime completedDateWithoutTime = DateTime(todo.dateCompleted!.year,
            todo.dateCompleted!.month, todo.dateCompleted!.day);

        // Add value to dataSet for completedDateWithoutTime
        if (dataSet.containsKey(completedDateWithoutTime)) {
          dataSet[completedDateWithoutTime] =
              dataSet[completedDateWithoutTime]! + 1;
        } else {
          dataSet[completedDateWithoutTime] = 1;
        }
      }
    }

    return dataSet;
  }

  Map<int, Color> _generateColorSet(Map<DateTime, int> dataSet) {
    final Map<int, Color> colorSet = {};

    // Calculate maximum occurrence to normalize colors
    int maxOccurrence = 0;
    for (final element in dataSet.values) {
      if (element > maxOccurrence) {
        maxOccurrence = element;
      }
    }

    dataSet.forEach((key, value) {
      // Calculate opacity based on occurrence
      double opacity = value.toDouble() / maxOccurrence.toDouble();
      // Make the red color darker based on opacity
      Color color = Colors.green.withOpacity(
          opacity.clamp(0.2, 1.0)); // Adjust opacity range as needed
      colorSet[value] = color;
    });

    return colorSet;
  }

  @override
  Widget build(BuildContext context) {
    final dataSet = _generateDataSet(todos);
    final colorSet = _generateColorSet(dataSet);
    return HeatMap(
      showText: false,
      size: 12,
      colorsets: colorSet,
      scrollable: true,
      datasets: dataSet,
    );
  }
}
