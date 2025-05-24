import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/car_model.dart';
import '../providers/car_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/car_model.dart';
import '../providers/car_provider.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final yearController = TextEditingController();
  final imageController = TextEditingController();

  final themeColor = const Color(0xFFFFCA28);
  final Color purple = const Color(0xFF9C27B0);

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey.shade400),
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: themeColor, width: 2),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newCar = Car(
        name: nameController.text,
        brand: brandController.text,
        year: yearController.text,
        imageUrl: imageController.text,
      );

      Provider.of<CarProvider>(context, listen: false).addCar(newCar);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Carro adicionado com sucesso!'),
          backgroundColor: Colors.grey[900],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

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
                decoration: _buildInputDecoration('Nome', Icons.directions_car),
                style: const TextStyle(color: Colors.white),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe o nome do carro' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: brandController,
                decoration: _buildInputDecoration('Marca', Icons.local_offer),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: yearController,
                decoration: _buildInputDecoration('Ano', Icons.calendar_today),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o ano';
                  if (int.tryParse(value) == null) return 'Digite um ano válido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: imageController,
                decoration: _buildInputDecoration('URL da Imagem', Icons.image_outlined),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: _saveForm,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}