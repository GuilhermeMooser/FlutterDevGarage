import 'package:flutter/material.dart';

import '../models/car_model.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final bool isFeatured;

  const CarCard({super.key, required this.car, this.isFeatured = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      height: isFeatured ? 220 : 120,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.shade900.withOpacity(0.5)),
        boxShadow: isFeatured
            ? [
          BoxShadow(
            color: Colors.purple.shade900.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ]
            : [],
      ),
      child: Row(
        children: [
          Hero(
            tag: car.id.toString(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                car.imageUrl,
                width: isFeatured ? width * 0.35 : width * 0.25,
                height: isFeatured ? width * 0.35 : width * 0.20,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: isFeatured ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  car.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  car.brand,
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 14,
                  ),
                ),
                if (isFeatured)
                  Text(
                    'Ano: ${car.year}',
                    style: const TextStyle(color: Colors.white70),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
