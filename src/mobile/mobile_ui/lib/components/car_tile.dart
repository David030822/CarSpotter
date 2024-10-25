import 'package:flutter/material.dart';
import 'package:mobile_ui/models/car.dart';

class CarTile extends StatelessWidget {
  Car car;
  void Function() onTap;
  void Function()? onButtonTap;

  CarTile({
    super.key,
    required this.car,
    required this.onTap,
    required this.onButtonTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        width: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // car image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      car.imagePath,
                      height: 100,
                      width: 150,
                    ),
                  ),
                ),
      
                // name
                Padding(
                  padding: const EdgeInsets.only(right: 70.0),
                  child: Column(
                    children: [
                      Text(
                        car.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      
            // kilometers + manufacture year
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.fuelType,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),

                      Text(
                        "${car.kilometers.toString()} Km",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        )
                      ),
              
                      Text(
                        "Manufactured in ${car.year}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "${car.price.toString()} €",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
      
                  // button to edit car details
                  GestureDetector(
                    onTap: onButtonTap,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: const Icon(
                        Icons.tune,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}