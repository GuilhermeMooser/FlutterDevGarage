import 'package:flutter/material.dart';
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
          .then((_) => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Carro'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                value!.isEmpty ? 'Informe o nome do carro' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _brand,
                decoration: InputDecoration(labelText: 'Marca'),
                onSaved: (value) => _brand = value!,
              ),
              TextFormField(
                initialValue: _year,
                decoration: InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _year = value!,
              ),
              TextFormField(
                initialValue: _imageUrl,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
                onSaved: (value) => _imageUrl = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
