import 'package:flutter/material.dart';

import '../models/car_model.dart';
import '../services/car_api_service.dart';
import '../services/car_database.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => _cars;

  Future<void> loadCars() async {
    _cars = await CarDatabase.instance.getCars();
    notifyListeners();
  }

  Future<void> addCar(Car car) async {
    await CarDatabase.instance.insertCarIfNotExists(car);
    await loadCars();
  }

  Future<void> updateCar(Car car) async {
    if (car.id == null) return;
    await CarDatabase.instance.updateCar(car);
    await loadCars();
  }

  Future<void> deleteCar(int id) async {
    await CarDatabase.instance.deleteCar(id);
    await loadCars();
  }

  Car getById(int id) {
    return _cars.firstWhere((car) => car.id == id);
  }

  Future<void> fetchAndSaveFromApi() async {
    final apiCars = await CarApiService.fetchCars();
    for (var car in apiCars) {
      await CarDatabase.instance.insertCarIfNotExists(car);
    }
    await loadCars();
  }
}
