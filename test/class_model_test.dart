import 'package:cars2026/class_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Proves unitàries del model de dades de cotxe.
  group('CarModel', () {
    // Comprova la serialització de l'objecte a map.
    test('toMap converts model to map', () {
      const model = CarModel(
        id: 2,
        year: 2021,
        make: 'Honda',
        model: 'Civic',
        type: 'Sedan',
      );

      final map = model.toMap();

      expect(map['id'], 2);
      expect(map['year'], 2021);
      expect(map['make'], 'Honda');
      expect(map['model'], 'Civic');
      expect(map['type'], 'Sedan');
    });

    // Valida la construcció des d'un map amb conversions de tipus.
    test('fromMap creates model with expected values', () {
      final model = CarModel.fromMap(<String, dynamic>{
        'id': 1,
        'year': 2020,
        'make': 'Toyota',
        'model': 'Corolla',
        'type': 'Sedan',
      });

      expect(model.id, 1);
      expect(model.year, 2020);
      expect(model.make, 'Toyota');
      expect(model.model, 'Corolla');
      expect(model.type, 'Sedan');
    });

    // Verifica la conversió d'un JSON array a llista de models.
    test('listFromJsonString parses JSON array into list', () {
      const jsonString = '''
      [{"id":9582,"year":2008,"make":"Buick","model":"Enclave","type":"SUV"},{"id":9583,"year":2006,"make":"MINI","model":"Convertible","type":"Convertible"}
      ]
      ''';

      final list = carsModelFromJson(jsonString);

      //Un
      expect(list.length, 2);
      expect(list.first.year, 2008);
      expect(list.first.make, "Buick");
      expect(list.first.model, "Enclave");
      expect(list.first.type, "SUV");

      //Altre
      expect(list.last.year, 2006);
      expect(list.last.make, "MINI");
      expect(list.last.model, "Convertible");
      expect(list.last.type, "Convertible");
    });
  });
}
