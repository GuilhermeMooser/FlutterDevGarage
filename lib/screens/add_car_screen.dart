import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car_model.dart';
import '../providers/car_provider.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen();

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final yearController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Carro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                controller: brandController,
                decoration: const InputDecoration(labelText: 'Marca'),
              ),
              TextFormField(
                controller: yearController,
                decoration: const InputDecoration(labelText: 'Ano'),
              ),
              TextFormField(
                controller: imageController,
                decoration: const InputDecoration(labelText: 'URL da Imagem'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newCar = Car(
                      name: nameController.text,
                      brand: brandController.text,
                      year: yearController.text,
                      imageUrl: imageController.text,
                    );
                    Provider.of<CarProvider>(
                      context,
                      listen: false,
                    ).addCar(newCar);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
