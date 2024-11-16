import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/car_tile.dart';
import 'package:mobile_ui/constants.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/pages/car_details_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void editCarBox(Car car) {}
  void deleteCarBox(Car car) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Cars',
              style: GoogleFonts.dmSerifText(
                fontSize: 36,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    // get a car from the list
                    Car car = getMyCars()[index];
                
                    return CarTile(
                      car: car,
                      editCar: (context) => editCarBox(car),
                      deleteCar: (context) => deleteCarBox(car),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarDetailsPage(car: car),
                          ),
                        );
                      },
                      onButtonTap: () {},
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}