import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/car_tile.dart';
import 'package:mobile_ui/components/my_drawer.dart';
import 'package:mobile_ui/constants.dart';
import 'package:mobile_ui/models/car.dart';
import 'package:mobile_ui/pages/car_details_page.dart';
import 'package:mobile_ui/pages/statistics_page.dart';
import 'package:mobile_ui/services/api_service.dart';
import 'package:mobile_ui/services/auth_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isLoading = false;
  List<Car> _myCars = [];
  void editCarBox(Car car) {}
  void deleteCarBox(Car car) {}

  void initState() {
    super.initState();
    loadOwnCars();
  }

  void loadOwnCars() async {
    setState(() {
      _isLoading = true;
      _myCars = [];
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
      _myCars = await ApiService.getOwnCars(userId);

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
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatisticsPage()),
            );
          },
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Cars',
                  style: GoogleFonts.dmSerifText(
                    fontSize: 36,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: ListView.builder(
                    itemCount: _myCars.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      
                      Car car = _myCars[index];

                      return CarTile(
                        car: car,
                        editCar: (context) => editCarBox(car),
                        deleteCar: (context) => deleteCarBox(car),
                        onTap: () {
                          // Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailsPage(car: car),
                            ),
                          );
                        },
                        onButtonTap: () {},
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
