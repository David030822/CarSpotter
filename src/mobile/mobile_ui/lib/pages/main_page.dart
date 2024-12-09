import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/my_drawer.dart';
import 'package:mobile_ui/components/own_car_tile.dart';
import 'package:mobile_ui/models/own_car.dart';
import 'package:mobile_ui/pages/chatbot_page.dart';
import 'package:mobile_ui/pages/own_car_details_page.dart';
import 'package:mobile_ui/services/api_service.dart';
import 'package:mobile_ui/services/auth_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isLoading = false;
  List<OwnCar> _myOwnCars = [];

  // text editing controllers
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _carYearController = TextEditingController();
  final TextEditingController _kilometersController = TextEditingController();
  final TextEditingController _fuelTypeController = TextEditingController();
  final TextEditingController _chassisController = TextEditingController();
  final TextEditingController _gearboxController = TextEditingController();
  final TextEditingController _engineSizeController = TextEditingController();
  final TextEditingController _horsepowerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _buyPriceController = TextEditingController();
  final TextEditingController _spentController = TextEditingController();
  final TextEditingController _soldFor = TextEditingController();
  final TextEditingController _imagePath = TextEditingController();

  void initState() {
    super.initState();
    loadOwnCars();
  }

  void loadOwnCars() async {
    setState(() {
      _isLoading = true;
      _myOwnCars = [];
    });

    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception("User is not logged in");
      }
      final userId = await AuthService.getUserIdFromToken(token);
      if (userId == null) {
        throw Exception("Invalid user ID");
      }
      _myOwnCars = await ApiService.getOwnCars(userId);

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

  // add new own car
  void addNewOwnCar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _carNameController,
                  decoration: const InputDecoration(
                    hintText: 'Car name',
                  ),
                ),
                TextField(
                  controller: _carYearController,
                  decoration: const InputDecoration(
                    hintText: 'Manufacture year',
                  ),
                ),
                TextField(
                  controller: _kilometersController,
                  decoration: const InputDecoration(
                    hintText: 'Kilometers',
                  ),
                ),
                TextField(
                  controller: _fuelTypeController,
                  decoration: const InputDecoration(
                    hintText: 'Fuel type',
                  ),
                ),
                TextField(
                  controller: _chassisController,
                  decoration: const InputDecoration(
                    hintText: 'Chassis type',
                  ),
                ),
                TextField(
                  controller: _gearboxController,
                  decoration: const InputDecoration(
                    hintText: 'Gearbox type',
                  ),
                ),
                TextField(
                  controller: _engineSizeController,
                  decoration: const InputDecoration(
                    hintText: 'Engine size',
                  ),
                ),
                TextField(
                  controller: _horsepowerController,
                  decoration: const InputDecoration(
                    hintText: 'Horsepower',
                  ),
                ),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    hintText: 'Selling for',
                  ),
                ),
                TextField(
                  controller: _buyPriceController,
                  decoration: const InputDecoration(
                    hintText: 'Bought for',
                  ),
                ),
                TextField(
                  controller: _spentController,
                  decoration: const InputDecoration(
                    hintText: 'Money spent on',
                  ),
                ),
                TextField(
                  controller: _soldFor,
                  decoration: const InputDecoration(
                    hintText: 'Sold for',
                  ),
                ),
                TextField(
                  controller: _imagePath,
                  decoration: const InputDecoration(
                    hintText: 'Image path',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: () async {
              // get the new car data
              String newCarName = _carNameController.text;
              int newCarYear = int.parse(_carYearController.text);
              int newCarKilometers = int.parse(_kilometersController.text);
              String newCarChassis = _chassisController.text;
              String newCarGearbox = _gearboxController.text;
              String newCarFuelType = _fuelTypeController.text;
              int newCarHorsepower = int.parse(_horsepowerController.text);
              int newCarEngineSize = int.parse(_engineSizeController.text);
              double boughtFor = double.parse(_buyPriceController.text);
              double spentOn = double.parse(_spentController.text);
              double sellingFor = double.parse(_priceController.text);
              double soldFor = double.parse(_soldFor.text);
              String imagePath = _imagePath.text;

              OwnCar newCar = OwnCar(
                name: newCarName,
                fuelType: newCarFuelType,
                kilometers: newCarKilometers,
                year: newCarYear,
                price: sellingFor,
                chassis: newCarChassis,
                gearbox: newCarGearbox,
                engineSize: newCarEngineSize,
                horsepower: newCarHorsepower,
                buyPrice: boughtFor,
                spent: spentOn,
                sellPrice: soldFor,
                imagePath: imagePath
              );

              try {
                final token = await AuthService.getToken();
                if (token == null) {
                  throw Exception("User is not authenticated");
                }
                final userId = await AuthService.getUserIdFromToken(token);
                if (userId == null) {
                  throw Exception("Invalid user ID");
                }

                // Call the API service to add the new car
                await ApiService.addNewOwnCar(userId, newCar);

                // Reload cars after adding a new one
                loadOwnCars();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }

              // Pop box
              Navigator.pop(context);

              // Clear controllers
              _carNameController.clear();
              _carYearController.clear();
              _kilometersController.clear();
              _fuelTypeController.clear();
              _chassisController.clear();
              _gearboxController.clear();
              _engineSizeController.clear();
              _horsepowerController.clear();
              _priceController.clear();
              _buyPriceController.clear();
              _spentController.clear();
            },
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              // Pop box
              Navigator.pop(context);

              // Clear controllers
              _carNameController.clear();
              _carYearController.clear();
              _kilometersController.clear();
              _fuelTypeController.clear();
              _chassisController.clear();
              _gearboxController.clear();
              _engineSizeController.clear();
              _horsepowerController.clear();
              _priceController.clear();
              _buyPriceController.clear();
              _spentController.clear();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // edit own car
  void editCarBox(OwnCar ownCar) {
    // set the controller's text to the car's current properties
    _carNameController.text = ownCar.name;
    _carYearController.text = ownCar.year.toString();
    _kilometersController.text = ownCar.kilometers.toString();
    _fuelTypeController.text = ownCar.fuelType;
    _chassisController.text = ownCar.chassis;
    _gearboxController.text = ownCar.gearbox; 
    _engineSizeController.text = ownCar.engineSize.toString();
    _horsepowerController.text = ownCar.horsepower.toString();
    _priceController.text = ownCar.price.toString();
    _buyPriceController.text = ownCar.buyPrice.toString();
    _spentController.text = ownCar.spent.toString();
    _soldFor.text = ownCar.sellPrice.toString();
    _imagePath.text = ownCar.imagePath;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _carNameController,
                  decoration: const InputDecoration(
                    hintText: 'Car name',
                  ),
                ),
                TextField(
                  controller: _carYearController,
                  decoration: const InputDecoration(
                    hintText: 'Manufacture year',
                  ),
                ),
                TextField(
                  controller: _kilometersController,
                  decoration: const InputDecoration(
                    hintText: 'Kilometers',
                  ),
                ),
                TextField(
                  controller: _fuelTypeController,
                  decoration: const InputDecoration(
                    hintText: 'Fuel type',
                  ),
                ),
                TextField(
                  controller: _chassisController,
                  decoration: const InputDecoration(
                    hintText: 'Chassis type',
                  ),
                ),
                TextField(
                  controller: _gearboxController,
                  decoration: const InputDecoration(
                    hintText: 'Gearbox type',
                  ),
                ),
                TextField(
                  controller: _engineSizeController,
                  decoration: const InputDecoration(
                    hintText: 'Engine size',
                  ),
                ),
                TextField(
                  controller: _horsepowerController,
                  decoration: const InputDecoration(
                    hintText: 'Horsepower',
                  ),
                ),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    hintText: 'Selling for',
                  ),
                ),
                TextField(
                  controller: _buyPriceController,
                  decoration: const InputDecoration(
                    hintText: 'Bought for',
                  ),
                ),
                TextField(
                  controller: _spentController,
                  decoration: const InputDecoration(
                    hintText: 'Money spent on',
                  ),
                ),
                TextField(
                  controller: _soldFor,
                  decoration: const InputDecoration(
                    hintText: 'Sold for',
                  ),
                ),
                TextField(
                  controller: _imagePath,
                  decoration: const InputDecoration(
                    hintText: 'Image path',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: () async {
              // get the new car data
              String newCarName = _carNameController.text;
              int newCarYear = int.parse(_carYearController.text);
              int newCarKilometers = int.parse(_kilometersController.text);
              String newCarChassis = _chassisController.text;
              String newCarGearbox = _gearboxController.text;
              String newCarFuelType = _fuelTypeController.text;
              int newCarHorsepower = int.parse(_horsepowerController.text);
              int newCarEngineSize = int.parse(_engineSizeController.text);
              double boughtFor = double.parse(_buyPriceController.text);
              double spentOn = double.parse(_spentController.text);
              double sellingFor = double.parse(_priceController.text);
              double soldFor = double.parse(_soldFor.text);
              String imagePath = _imagePath.text;

              OwnCar updatedCar = OwnCar(
                name: newCarName,
                fuelType: newCarFuelType,
                kilometers: newCarKilometers,
                year: newCarYear,
                price: sellingFor,
                chassis: newCarChassis,
                gearbox: newCarGearbox,
                engineSize: newCarEngineSize,
                horsepower: newCarHorsepower,
                buyPrice: boughtFor,
                spent: spentOn,
                sellPrice: soldFor,
                imagePath: imagePath
              );

              try {
                final token = await AuthService.getToken();
                if (token == null) {
                  throw Exception("User is not authenticated");
                }
                
                final userId = await AuthService.getUserIdFromToken(token);
                if (userId == null) {
                  throw Exception("Invalid user ID");
                }

                // Validate car ID
                if (ownCar.id == null) {
                  throw Exception("Invalid car ID");
                }

                // Call the API service to add the new car
                await ApiService.editOwnCar(userId, ownCar.id!, updatedCar);

                // Reload cars after adding a new one
                loadOwnCars();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }

              // Pop box
              Navigator.pop(context);

              // Clear controllers
              _carNameController.clear();
              _carYearController.clear();
              _kilometersController.clear();
              _fuelTypeController.clear();
              _chassisController.clear();
              _gearboxController.clear();
              _engineSizeController.clear();
              _horsepowerController.clear();
              _priceController.clear();
              _buyPriceController.clear();
              _spentController.clear();
            },
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // Clear controllers
              _carNameController.clear();
              _carYearController.clear();
              _kilometersController.clear();
              _fuelTypeController.clear();
              _chassisController.clear();
              _gearboxController.clear();
              _engineSizeController.clear();
              _horsepowerController.clear();
              _priceController.clear();
              _buyPriceController.clear();
              _spentController.clear();
            },
            child: const Text('Cancel'),
          ),
        ],
      )
    );
  }

  // delete car box
  void deleteCarBox(OwnCar ownCar) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to delete?'),
        actions: [
          // delete button
          MaterialButton(
            onPressed: () async {
              // delete from db
              try {
                // Get token
                final token = await AuthService.getToken();
                if (token == null) {
                  throw Exception("User is not authenticated");
                }

                // Get user ID
                final userId = await AuthService.getUserIdFromToken(token);
                if (userId == null) {
                  throw Exception("Invalid user ID");
                }

                // Validate car ID
                if (ownCar.id == null) {
                  throw Exception("Invalid car ID");
                }

                // Call API to delete the car
                await ApiService.deleteOwnCar(userId, ownCar.id!);

                // Reload the list of cars after deletion
                loadOwnCars();

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Car deleted successfully')),
                );
              } catch (e) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }

              // pop box
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: const MyDrawer(),
        floatingActionButton: Stack(
          children: [
            // Add Car Button
            Positioned(
              bottom: 5, // Offset for positioning
              right: 18,
              child: FloatingActionButton(
                onPressed: addNewOwnCar,
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: const Icon(Icons.add),
              ),
            ),

            // Chatbot Button
            Positioned(
              bottom: 5, // Offset for positioning
              left: 45,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatbotPage()),
                  );
                },
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: const Icon(Icons.chat),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Cars',
                style: GoogleFonts.dmSerifText(
                  fontSize: 36,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: ListView.builder(
                    itemCount: _myOwnCars.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      OwnCar ownCar = _myOwnCars[index];

                      return OwnCarTile(
                        ownCar: ownCar,
                        editCar: (context) {
                          editCarBox(ownCar);
                        },
                        deleteCar: (context) {
                          deleteCarBox(ownCar);
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OwnCarDetailsPage(ownCar: ownCar),
                            ),
                          );
                        },
                        onButtonTap: () {
                          // Additional button tap action if needed
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
      ));
  }
}
