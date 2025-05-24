import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car_model.dart';
import '../providers/car_provider.dart';
import 'edit_car_screen.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditCarScreen(car: car),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _confirmDelete(context, carProvider),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              car.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text("Modelo: ${car.name}", style: TextStyle(fontSize: 20)),
            Text("Marca: ${car.brand}", style: TextStyle(fontSize: 18)),
            Text("Ano: ${car.year}", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, CarProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Excluir carro'),
        content: Text('Deseja excluir este carro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await provider.deleteCar(car.id!);
              Navigator.of(ctx).pop(); // Fecha o dialog
              Navigator.of(context).pop(); // Volta da tela de detalhe
            },
            child: Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}