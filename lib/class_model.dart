import 'dart:convert';

/// Model de cotxe per mapejar dades de l'API (RapidAPI) a objectes Dart.
class CarModel {
  final int id;
  final int year;
  final String make;
  final String model;
  final String type;

  const CarModel({
    required this.id,
    required this.year,
    required this.make,
    required this.model,
    required this.type,
  });

  /// Converteix la instància actual a `Map<String, dynamic>`.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'make': make,
      'model': model,
      'type': type,
    };
  }

  /// Crea una instància de [CarModel] a partir d'un map.

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'],
      year: map['year'],
      make: map['make'],
      model: map['model'],
      type: map['type'],
    );
  }
}

/// Converteix un JSON en format `String` a una llista de [CarModel].
///
/// El JSON d'entrada ha de ser un array.
List<CarModel> carsModelFromJson(String str) =>
    List<CarModel>.from(json.decode(str).map((x) => CarModel.fromMap(x)));
