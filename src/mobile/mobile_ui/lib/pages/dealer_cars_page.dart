import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/car_tile.dart';
import 'package:mobile_ui/components/my_drawer.dart';
import 'package:mobile_ui/constants.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/pages/car_details_page.dart';

class DealerCarsPage extends StatelessWidget {
  final List<Car> cars;

  const DealerCarsPage({Key? key, required this.cars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Cars from this Dealer',
          style: GoogleFonts.dmSerifText(
            fontSize: 24,
            color: Theme.of(context).colorScheme.inversePrimary,
          )
        ),
      ),
      drawer: myDrawer,
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return cars.isEmpty ? Text(
            'No cars from\nthis dealer yet...',
            style: GoogleFonts.dmSerifText (
              fontSize: 24,
              color: Theme.of(context).colorScheme.inversePrimary,
            )
        ) : CarTile(
            car: cars[index],
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarDetailsPage(),
                ),
              );
            },
            onButtonTap: () {
              // Handle button tap, e.g., edit car details
            },
          );
        },
      ),
    );
  }
}