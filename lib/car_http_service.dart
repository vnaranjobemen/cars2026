import 'package:cars2026/class_model.dart';
import 'package:http/http.dart' as http;

class CarHttpService {
  final String serverUrl =
      'https://car-data.p.rapidapi.com/cars?limit=10&page=0';
  final String _headerKey =
      '7c00063cc0mshd06eb3f7234b024p167924jsn67c78b190f6a';
  final String _headerHost = 'car-data.p.rapidapi.com';

  Future<List<CarModel>> getCars() async {
    final response = await http.get(
      Uri.parse(serverUrl),
      headers: {'X-RapidAPI-Key': _headerKey, 'X-RapidAPI-Host': _headerHost},
    );

    if (response.statusCode == 200) {
      return carsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load cars');
    }
  }
}
