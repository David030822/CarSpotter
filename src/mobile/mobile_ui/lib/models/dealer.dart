import 'package:mobile_ui/models/car.dart';

class Dealer {
  final String name;
  final String location;
  final int activeSince;
  final String imagePath;
  List<Car> cars;
  bool isFavorited;

  Dealer({
    required this.name,
    required this.location,
    required this.activeSince,
    required this.imagePath,
    required this.cars,
    required this.isFavorited
  });
}