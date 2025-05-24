import 'package:flutter/material.dart';

import '../models/car_model.dart';
import '../services/car_database.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => _cars;

  Future<void> loadCars() async {
    _cars = await CarDatabase.instance.getCars();
    notifyListeners();
  }

  Future<void> addCar(Car car) async {
    await CarDatabase.instance.insertCar(car);
    await loadCars();
  }
}
