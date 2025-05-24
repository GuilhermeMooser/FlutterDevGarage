import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/car_model.dart';

class CarApiService {
  static const String baseUrl = 'https://683124c46205ab0d6c3b59f2.mockapi.io/api/car';

  static Future<List<Car>> fetchCars() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((car) => Car.fromMap(car)).toList();
    } else {
      throw Exception('Erro ao buscar carros da API');
    }
  }
}
