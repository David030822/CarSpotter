import 'package:flutter/material.dart';
import 'package:mobile_ui/components/my_drawer.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/models/dealer.dart';
import 'package:mobile_ui/models/user.dart';

var myDefaultBackgroundColor = Colors.grey[300];

var myAppBar = AppBar(
      backgroundColor: Colors.grey[800]
);

var myDrawer = const MyDrawer();

List<User> users = [
  User(
    firstName: 'David',
    lastName: 'Demeter',
    email: 'demeter.david@gmail.com',
    phoneNum: '0745805425',
  ),
  User(
  firstName: 'Emma',
  lastName: 'Johnson',
  email: 'emma.johnson@gmail.com',
  phoneNum: '0765481234',
  ),
  User(
    firstName: 'Liam',
    lastName: 'Smith',
    email: 'liam.smith@gmail.com',
    phoneNum: '0754123467',
  ),
  User(
    firstName: 'Sophia',
    lastName: 'Brown',
    email: 'sophia.brown@gmail.com',
    phoneNum: '0773219876',
  ),
  User(
    firstName: 'Noah',
    lastName: 'Davis',
    email: 'noah.davis@gmail.com',
    phoneNum: '0723456789',
  ),
  User(
    firstName: 'Ava',
    lastName: 'Taylor',
    email: 'ava.taylor@gmail.com',
    phoneNum: '0734567890',
  ),
];

List<User> getUserList(){
  return users;
}

List<Dealer> dealers = [
  Dealer(
    id: 0,
    name: 'David BYS\n     Cars',
    location: 'Ivanesti',
    activeSince: 2024,
    imagePath: 'assets/images/DavidBysCars.png',
    cars: davidCars,
    isFavorited: true
  ),
  Dealer(
    id: 0,
    name: 'Cristal Auto',
    location: 'Targu Mures',
    activeSince: 2016,
    imagePath: 'assets/images/CristalAuto.png',
    cars: cristalCars,
    isFavorited: false
  ),
  Dealer(
    id: 0,
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

List<Car> myCars = [
  Car(
    name: 'Audi A6',
    year: 2018,
    kilometers: 137521,
    fuelType: 'Diesel',
    price: 27500,
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