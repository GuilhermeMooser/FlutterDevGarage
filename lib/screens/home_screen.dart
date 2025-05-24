import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/car_provider.dart';
import '../widgets/car_card.dart';
import 'add_car_screen.dart';
import 'car_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeCars();
  }

  Future<void> _initializeCars() async {
    final provider = Provider.of<CarProvider>(context, listen: false);
    // Aqui você pode chamar:
    await provider.fetchAndSaveFromApi(); // se quiser puxar da API
    // await provider.loadCars(); // apenas carrega do banco local
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('devGarage'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : carProvider.cars.isEmpty
          ? const Center(child: Text('Nenhum carro cadastrado.'))
          : ListView.builder(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCarScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}