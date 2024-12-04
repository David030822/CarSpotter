import 'package:isar/isar.dart';

part 'event.g.dart';

@Collection()
class Event {
  // event id
  Id id = Isar.autoIncrement;

  // event name
  late String name;

  // completed days
  List<DateTime> completedDays = [
    // DateTime(year, month, day),
    // DateTime(2024, 8, 22),
    // DateTime(2024, 8, 23),
  ];
}