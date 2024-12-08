// given a goal list of completion days
// is the goal completed today

import 'package:mobile_ui/models/event.dart';

Map<String, String> parseEventName(String eventName) {
  final regex = RegExp(r'^(Sold|Bought) (.+) on (\d{4}-\d{2}-\d{2})$');
  final match = regex.firstMatch(eventName);

  if (match != null) {
    return {
      'type': match.group(1)!, // 'Sold' or 'Bought'
      'name': match.group(2)!, // 'Audi A6'
      'date': match.group(3)!, // '2024-12-08'
    };
  }

  throw FormatException('Invalid event name format');
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