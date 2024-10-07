import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/dealer_tile.dart';
import 'package:mobile_ui/constants.dart';
import 'package:mobile_ui/models/dealer.dart';
import 'package:mobile_ui/pages/dealer_cars_page.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Favourite dealers',
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
                  // get a dealer from the list
                  Dealer dealer = getDealerList()[index];
              
                  return DealerTile(
                    dealer: dealer,
                    onTap: () {
                      Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DealerCarsPage(),
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
      ),
    );
  }
}