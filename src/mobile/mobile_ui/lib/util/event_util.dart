// given a goal list of completion days
// is the goal completed today

import 'package:mobile_ui/models/event.dart';

bool isEventCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}

// prepare heat map dataset
Map<DateTime, int> prepHeatMapDataset(List<Event> events) {
  Map<DateTime, int> dataset = {};

  for(var event in events) {
    for(var date in event.completedDays) {
      // normalize date to avoid time mismatch
      final normalizedDate = DateTime(date.year, date.month, date.day);

      // if the date already exists in the dataset, increment its count
      if(dataset.containsKey(normalizedDate)) {
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
      } else {
        // initialize with 1
        dataset[normalizedDate] = 1;
      }
    }
  }

  return dataset;
}