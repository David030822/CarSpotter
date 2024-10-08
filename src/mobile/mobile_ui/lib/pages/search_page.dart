import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/custom_button.dart';
import 'package:mobile_ui/components/dealer_tile.dart';
import 'package:mobile_ui/components/my_text_field.dart';
import 'package:mobile_ui/constants.dart';
import 'package:mobile_ui/models/dealer.dart';
import 'package:mobile_ui/pages/dealer_cars_page.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   'Search Page',
            //   style: GoogleFonts.dmSerifText(
            //     fontSize: 48,
            //     color: Theme.of(context).colorScheme.inversePrimary,
            //   )
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the row contents
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: _searchController,
                          hintText: 'Enter a dealer name',
                          obscureText: false,
                        ),
                      ),
                      CustomButton(
                        color: Theme.of(context).colorScheme.tertiary,
                        textColor: Theme.of(context).colorScheme.outline,
                        onPressed: () {},
                        label: 'Search',
                      ),
                    ],
                  ),
                  Text(
                    'Most popular dealers',
                    style: GoogleFonts.dmSerifText(
                      fontSize: 36,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    )
                  ),
                ],
              ),
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
                            builder: (context) => DealerCarsPage(cars: dealer.cars),
                          ),
                        );
                    },
                    onButtonTap: () {
                      setState(() {
                        dealer.isFavorited = !dealer.isFavorited;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(dealer.isFavorited
                              ? '${dealer.name} added to favorites'
                              : '${dealer.name} removed from favorites'),
                        ),
                      );
                    },
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