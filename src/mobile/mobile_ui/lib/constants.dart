import 'package:flutter/material.dart';
import 'package:mobile_ui/components/my_drawer.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/models/dealer.dart';
import 'package:mobile_ui/models/friend.dart';

var myDefaultBackgroundColor = Colors.grey[300];

var myAppBar = AppBar(
      backgroundColor: Colors.grey[800]
);

var myDrawer = const MyDrawer();

List<Dealer> dealers = [
  Dealer(
    name: 'David BYS\n     Cars',
    location: 'Ivanesti',
    activeSince: 2024,
    imagePath: 'assets/images/DavidBysCars.png',
    cars: davidCars,
    isFavorited: true
  ),
  Dealer(
    name: 'Cristal Auto',
    location: 'Targu Mures',
    activeSince: 2016,
    imagePath: 'assets/images/CristalAuto.png',
    cars: cristalCars,
    isFavorited: false
  ),
  Dealer(
    name: 'Royal\nAutomobile\nMures',
    location: 'Targu Mures',
    activeSince: 2020,
    imagePath: 'assets/images/Royal.png',
    cars: royalCars,
    isFavorited: false
  )
];

List<Dealer> getDealerList() {
  return dealers;
}

List<Friend> friends = [
  Friend(
    name: 'Mitch',
    email: 'mitchkoko22@gmail.com'
  ),
  Friend(
    name: 'Sarah',
    email: 'sarahjones98@yahoo.com'
  ),
  Friend(
    name: 'David',
    email: 'davidbrown23@hotmail.com'
  ),
  Friend(
    name: 'Emily',
    email: 'emilysmith11@gmail.com'
  ),
  Friend(
    name: 'Alex',
    email: 'alexjohnson77@outlook.com'
  ),
];

List<Friend> getFriendList() {
  return friends;
}

List<Car> myCars = [
  Car(
    name: 'Audi A6',
    year: 2018,
    kilometers: 137521,
    fuelType: 'Diesel',
    price: 30500,
    imagePath: 'assets/images/AudiA6.jpg',
    gearbox: 'Automatic',
    chassis: 'Combi',
    engineSize: 1968,
    horsepower: 204
  ),
  Car(
    name: 'Audi A3',
    year: 2012,
    kilometers: 217151,
    fuelType: 'Diesel',
    price: 7500,
    imagePath: 'assets/images/AudiA3.jpg',
    gearbox: 'Manual',
    chassis: 'Compact',
    engineSize: 1968,
    horsepower: 140
  ),
  Car(
    name: 'Audi A4',
    year: 2019,
    kilometers: 141257,
    fuelType: 'Diesel',
    price: 18500,
    imagePath: 'assets/images/AudiA4.jpg',
    gearbox: 'Automatic',
    chassis: 'Combi',
    engineSize: 1968,
    horsepower: 150
  ),
];

List<Car> getMyCars() {
  return myCars;
}

List<Car> davidCars = myCars;

List<Car> getDavidCars() {
  return davidCars;
}

List<Car> royalCars = [];
List<Car> cristalCars = [];