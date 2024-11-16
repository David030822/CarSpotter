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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                car.imagePath,
                height: 200,
                width: 300,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Car Details',
              style: GoogleFonts.dmSerifText(
                fontSize: 24,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              "Model: ${car.name}",
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              "Fuel type: ${car.fuelType}",
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              "Kilometers: ${car.kilometers.toString()}",
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              "Manufacture year: ${car.year.toString()}",
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              "Price: ${car.price.toString()}",
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              "Chassis type: ${car.chassis}",
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              "Gearbox: ${car.gearbox}",
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              "Engine size: ${car.engineSize.toString()} cm³",
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),

            const SizedBox(height: 15),

            Text(
              "Horsepower: ${car.horsepower.toString()}",
              style: GoogleFonts.dmSerifText(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),
          ],
        ),
      ),
    );
  }
}