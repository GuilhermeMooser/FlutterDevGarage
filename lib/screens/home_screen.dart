import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/car_provider.dart';
import '../widgets/car_card.dart';
import 'add_car_screen.dart';
import 'car_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('devGarage')),
      body: FutureBuilder(
        future: provider.loadCars(),
        builder: (context, snapshot) {
          return Consumer<CarProvider>(
            builder: (context, carProvider, child) {
              return ListView.builder(
                itemCount: carProvider.cars.length,
                itemBuilder: (context, index) {
                  final car = carProvider.cars[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CarDetailScreen(car: car),
                        ),
                      );
                    },
                    child: Hero(
                      tag: car.id.toString(),
                      child: CarCard(car: car),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddCarScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
