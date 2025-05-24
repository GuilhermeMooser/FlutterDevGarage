import 'package:flutter/material.dart';

import '../models/car_model.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;

  const CarDetailScreen({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car.name)),
      body: Column(
        children: [
          Hero(
            tag: car.id.toString(),
            child: Image.network(
              car.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(car.name, style: Theme.of(context).textTheme.headlineSmall),
                Text("Marca: ${car.brand}"),
                Text("Ano: ${car.year}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
