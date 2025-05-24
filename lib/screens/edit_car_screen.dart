import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/car_model.dart';
import '../providers/car_provider.dart';

class EditCarScreen extends StatefulWidget {
  final Car car;

  const EditCarScreen({super.key, required this.car});

  @override
  State<EditCarScreen> createState() => _EditCarScreenState();
}

class _EditCarScreenState extends State<EditCarScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _brand;
  late String _year;
  late String _imageUrl;

  final themeColor = const Color(0xFFFFCA28);
  @override
  void initState() {
    super.initState();
    _name = widget.car.name;
    _brand = widget.car.brand;
    _year = widget.car.year;
    _imageUrl = widget.car.imageUrl;
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedCar = Car(
        id: widget.car.id,
        name: _name,
        brand: _brand,
        year: _year,
        imageUrl: _imageUrl,
      );

      Provider.of<CarProvider>(context, listen: false)
          .updateCar(updatedCar)
          .then((_) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Carro atualizado com sucesso!'),
            backgroundColor: Colors.greenAccent.shade700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Carro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: _buildInputDecoration('Nome', Icons.directions_car),
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe o nome do carro' : null,
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _brand,
                decoration: _buildInputDecoration('Marca', Icons.local_offer),
                style: const TextStyle(color: Colors.white),
                onSaved: (value) => _brand = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _year,
                decoration: _buildInputDecoration('Ano', Icons.calendar_today),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o ano';
                  if (int.tryParse(value) == null) return 'Digite um ano válido';
                  return null;
                },
                onSaved: (value) => _year = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _imageUrl,
                decoration: _buildInputDecoration('URL da Imagem', Icons.image_outlined),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.url,
                onSaved: (value) => _imageUrl = value!,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _saveForm,
                child: const Text(
                  'Salvar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}