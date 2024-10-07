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
    imagePath: 'assets/images/DavidBysCars.png'
  ),
  Dealer(
    name: 'Cristal Auto',
    location: 'Targu Mures',
    activeSince: 2016,
    imagePath: 'assets/images/CristalAuto.png'
  ),
  Dealer(
    name: 'Royal\nAutomobile\nMures',
    location: 'Targu Mures',
    activeSince: 2020,
    imagePath: 'assets/images/Royal.png'
  ),
  Dealer(
    name: 'David BYS Cars',
    location: 'Ivanesti',
    activeSince: 2024,
    imagePath: 'assets/images/DavidBysCars.png'
  ),
  Dealer(
    name: 'David BYS Cars',
    location: 'Ivanesti',
    activeSince: 2024,
    imagePath: 'assets/images/DavidBysCars.png'
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
    imagePath: 'assets/images/AudiA6.jpg'
  ),
  Car(
    name: 'Audi A3',
    year: 2012,
    kilometers: 217151,
    fuelType: 'Diesel',
    imagePath: 'assets/images/AudiA3.jpg'
  ),
  Car(
    name: 'Audi A4',
    year: 2019,
    kilometers: 141257,
    fuelType: 'Diesel',
    imagePath: 'assets/images/AudiA4.jpg'
  ),
];

List<Car> getMyCars() {
  return myCars;
}