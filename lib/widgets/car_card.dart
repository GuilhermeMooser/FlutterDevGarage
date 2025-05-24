import 'package:flutter/material.dart';

import '../models/car_model.dart';

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(
          car.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(car.name),
        subtitle: Text('${car.brand} • ${car.year}'),
      ),
    );
  }
}
