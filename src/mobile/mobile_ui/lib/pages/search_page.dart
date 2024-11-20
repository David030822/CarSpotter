import 'package:flutter/material.dart';
import 'package:mobile_ui/components/custom_button.dart';
import 'package:mobile_ui/components/my_text_field.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/pages/car_details_page.dart';
import 'package:mobile_ui/pages/dealer_cars_page.dart';
import 'package:mobile_ui/ApiService/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _dealerCars = [];

  void _searchDealerCars() async {
  setState(() {
    _isLoading = true;
    _dealerCars = [];
  });

  try {
    final carsJson = await ApiService.getCarsByDealer(_searchController.text.trim());
    final cars = carsJson.map<Car>((json) => Car.fromJson(json)).toList();
    setState(() {
      _dealerCars = cars;
    });

    // Navigálás a DealerCarsPage-re
    if (cars.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DealerCarsPage(
            cars: cars,
            name: _searchController.text.trim(),
            parentRoute: "/search",
          ),
        ),
      );
    } else {
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
                    if (_isLoading) CircularProgressIndicator(),
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
                  itemCount: _dealerCars.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final car = _dealerCars[index];

                    return ListTile(
                      leading: Image.network(
                        car['img_url'] ?? 'https://via.placeholder.com/150',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(car['model']),
                      subtitle: Text('Year: ${car['year']}'),
                      onTap: () {
                      
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarDetailsPage(car: Car.fromJson(car)),
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