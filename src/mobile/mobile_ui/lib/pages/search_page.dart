import 'package:flutter/material.dart';
import 'package:mobile_ui/components/custom_button.dart';
import 'package:mobile_ui/components/my_text_field.dart';
import 'package:mobile_ui/components/dealer_tile.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/models/dealer.dart';
import 'package:mobile_ui/pages/dealer_cars_page.dart';
import 'package:mobile_ui/services/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  bool _isLoading = false;
  List<Car> _dealerCars = [];
  Dealer? _dealer;

  void _searchDealerCars() async {
    setState(() {
      _isLoading = true;
      _dealerCars = [];
      _dealer = null;
    });

    try {
      final response =
          await ApiService.getCarsByDealer(_searchController.text.trim());

      final dealerJson = response['dealer'];
      final carsJson = response['cars'];

      _dealer = Dealer.fromJson(dealerJson);

      _dealerCars = carsJson.map<Car>((json) => Car.fromJson(json)).toList();

      setState(() {});

      if (_dealerCars.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No cars found for the dealer.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: MyTextField(
                              controller: _searchController,
                              hintText: 'Enter a dealer name',
                              obscureText: false,
                            ),
                          ),
                        ),
                        CustomButton(
                          color: Theme.of(context).colorScheme.tertiary,
                          textColor: Theme.of(context).colorScheme.outline,
                          onPressed: _searchDealerCars,
                          label: 'Search',
                        ),
                      ],
                    ),
                    if (_isLoading) const CircularProgressIndicator(),
                    if (!_isLoading &&
                        _dealerCars.isEmpty &&
                        _searchController.text.isNotEmpty)
                      Text(
                        'No cars found for "${_searchController.text}".',
                        style: TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _dealer != null ? 1 : 0,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Dealer dealer = _dealer!;

                    return DealerTile(
                      dealer: dealer,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DealerCarsPage(
                              cars: _dealerCars,
                              name: dealer.name,
                              parentRoute: '/home_page',
                            ),
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
        ),
      ),
    );
  }
}
