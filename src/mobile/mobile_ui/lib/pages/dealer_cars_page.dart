import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/car_tile.dart';
import 'package:mobile_ui/components/custom_button.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/pages/car_details_page.dart';
import 'package:mobile_ui/pages/statistics_page.dart';

class DealerCarsPage extends StatefulWidget {
  final List<Car> cars;
  final String name;

  const DealerCarsPage({
    super.key,
    required this.cars,
    required this.name,
  });

  @override
  State<DealerCarsPage> createState() => _DealerCarsPageState();
}

class _DealerCarsPageState extends State<DealerCarsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 10),
                  child: Text(
                      'Cars from ${widget.name}',
                      style: GoogleFonts.dmSerifText(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      )
                    ),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: widget.cars.length,
                itemBuilder: (context, index) {
                  return widget.cars.isEmpty ? Text(
                    'No cars from\nthis dealer yet...',
                    style: GoogleFonts.dmSerifText (
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ) : CarTile(
                      car: widget.cars[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarDetailsPage(car: widget.cars[index]),
                          ),
                        );
                      },
                      onButtonTap: () {
                        // Handle button tap, e.g., edit car details
                      },
                    );
                  },
                ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomButton(
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatisticsPage(),
                    ),
                  );
                },
                label: 'See stats for ${widget.name}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}