import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/car_tile.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/pages/car_details_page.dart';

class DealerCarsPage extends StatefulWidget {
  final List<Car> cars;
  final String name;
  final String parentRoute;

  const DealerCarsPage({
    Key? key,
    required this.cars,
    required this.name,
    required this.parentRoute
  }) : super(key: key);

  @override
  State<DealerCarsPage> createState() => _DealerCarsPageState();
}

class _DealerCarsPageState extends State<DealerCarsPage> {
    void editCarBox(Car car) {}
  void deleteCarBox(Car car) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context, widget.parentRoute
            );
          },
        ),
      ),
      // drawer: myDrawer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      editCar: (context) => editCarBox(widget.cars[index]),
                      deleteCar: (context) => deleteCarBox(widget.cars[index]),
                      onTap: () {
                        Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}