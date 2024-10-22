import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/pages/home_page.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;
  const CarDetailsPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage()
              ),
            );
          }
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Car Details',
              style: GoogleFonts.dmSerifText(
                fontSize: 24,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              car.name,
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              car.fuelType,
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              car.kilometers.toString(),
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              car.year.toString(),
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              car.price.toString(),
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              car.chassis,
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              car.gearbox,
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              car.engineSize.toString(),
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              car.horsepower.toString(),
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}