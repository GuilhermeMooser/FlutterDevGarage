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
    final themeColor = const Color(0xFFFFCA28);
    final carProvider = Provider.of<CarProvider>(context);
    final updatedCar = carProvider.getById(car.id!); // Atualiza sempre o carro mais recente

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          updatedCar.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFCA28),
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Excluir carro',
            onPressed: () => _confirmDelete(context, carProvider),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: 'car-image-${updatedCar.id}',
                child: Image.network(
                  updatedCar.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Car info
            _infoLabel("Nome do modelo"),
            _infoText(updatedCar.name),

            _infoLabel("Fabricante"),
            _infoText(updatedCar.brand),

            _infoLabel("Ano de fabricação"),
            _infoText(updatedCar.year.toString()),

            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditCarScreen(car: updatedCar),
                    ),
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.black),
                label: const Text(
                  "Editar informações",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _infoLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 12),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 13,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _infoText(String value) {
    return Text(
      value,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  void _confirmDelete(BuildContext context, CarProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Excluir este carro?',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        content: const Text(
          'Esta ação não poderá ser desfeita.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () async {
              await provider.deleteCar(car.id!);
              Navigator.of(ctx).pop(); // Fecha o dialog
              Navigator.of(context).pop(); // Volta da tela de detalhe

              // Mostra o Snackbar na tela anterior (após Navigator.pop)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Carro excluído com sucesso.'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            child: const Text(
              'Excluir',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

}