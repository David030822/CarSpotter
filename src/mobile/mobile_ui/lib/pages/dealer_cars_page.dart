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
  List<Car> soldCars = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Cars from ${widget.name}',
                  style: GoogleFonts.dmSerifText(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              if (widget.cars.isEmpty)
                Center(
                  child: Text(
                    'No cars from\nthis dealer yet...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSerifText(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true, // Constrain height
                  physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
                  itemCount: widget.cars.length,
                  itemBuilder: (context, index) {
                    return CarTile(
                      car: widget.cars[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CarDetailsPage(car: widget.cars[index]),
                          ),
                        );
                      },
                    );
                  },
                ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Sold cars',
                  style: GoogleFonts.dmSerifText(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (soldCars.isEmpty)
                Center(
                  child: Text(
                    'No sold cars yet...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSerifText(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: soldCars.length,
                  itemBuilder: (context, index) {
                    return CarTile(
                      car: soldCars[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CarDetailsPage(car: soldCars[index]),
                          ),
                        );
                      },
                    );
                  },
                ),

              const SizedBox(height: 20),

              Center(
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
      ),
    );
  }
}