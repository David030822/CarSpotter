import 'package:flutter/material.dart';
import 'package:mobile_ui/models/dealer.dart';

class DealerTile extends StatelessWidget {
  Dealer dealer;
  void Function()? onButtonTap;
  void Function() onTap;

  DealerTile({
    super.key,
    required this.dealer,
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
            // dealer logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      dealer.imagePath,
                      height: 100,
                      width: 150,
                    ),
                  ),
                ),
      
                // name
                Padding(
                  padding: const EdgeInsets.only(right: 65.0),
                  child: Column(
                    children: [
                      Text(
                        dealer.name,
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
      
            // location + active since
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dealer.location,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        )
                      ),
              
                      const SizedBox(height: 5),
              
                      Text(
                        "Active since ${dealer.activeSince}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
      
                  // button to add to favourites
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
                        Icons.favorite,
                        color: Colors.red,
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