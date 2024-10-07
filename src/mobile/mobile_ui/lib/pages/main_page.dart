import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/car_tile.dart';
import 'package:mobile_ui/constants.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/pages/car_details_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  // get a car from the list
                  Car car = getMyCars()[index];
              
                  return CarTile(
                    car: car,
                    onTap: () {
                      Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CarDetailsPage(),
                          ),
                        );
                    },
                    onButtonTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}