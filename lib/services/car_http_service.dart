import 'package:cars2026/model/car_model.dart';
import 'package:http/http.dart' as http;

/*
 * Service o Datasource per a obtenir els cotxes des del servidor. 
 * Utilitza l'API de RapidAPI per a fer les peticions HTTP i obtenir les dades dels cotxes. 
 * Té tres mètodes: 
 *  - getCars() per obtenir tots els cotxes
 *  - getCarsLimitted() per obtenir un nombre limitat de cotxes
 *  - getCarsPage() per obtenir una pàgina específica de cotxes amb un límit de pàgina. 
 * Cada mètode retorna una llista de CarModel o llença una excepció si la petició falla.
 * 
 * Si haguessim de gestionar més d'un servei, tindriem  ua capa per sobre. Seria el Repository, que gestionaria les diferents fonts de dades (HTTP, local, etc) i faria la lògica * de negoci per decidir quina font utilitzar en cada moment.
 */
class CarHttpService {
  final String serverUrl = 'https://car-data.p.rapidapi.com/cars';
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

  Future<List<CarModel>> getCarsLimitted({int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$serverUrl?limit=$limit'),
      headers: {'X-RapidAPI-Key': _headerKey, 'X-RapidAPI-Host': _headerHost},
    );

    if (response.statusCode == 200) {
      return carsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load cars');
    }
  }

  Future<List<CarModel>> getCarsPage(int page, int limit) async {
    final response = await http.get(
      Uri.parse('$serverUrl?page=$page&limit=$limit'),
      headers: {'X-RapidAPI-Key': _headerKey, 'X-RapidAPI-Host': _headerHost},
    );

    if (response.statusCode == 200) {
      return carsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load cars');
    }
  }
}
