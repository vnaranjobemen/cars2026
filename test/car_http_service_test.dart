import 'package:cars2026/car_http_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Agrupa pruebas de integración del servicio HTTP real.
  group('CarHttpService (real API)', () {
    late CarHttpService service;

    // Inicializa el servicio antes de cada test.
    setUp(() {
      service = CarHttpService();
    });

    // Espera después de cada test para evitar rate limiting.
    tearDown(() async {
      await Future.delayed(const Duration(seconds: 2));
    });

    test(
      // Verifica que la API responde con datos y respeta el límite esperado.
      'fetchCars returns a non-empty list with API limit respected',
      () async {
        // Llamada real al endpoint.
        final cars = await service.getCars();

        // Debe haber al menos un auto.
        expect(cars, isNotEmpty);

        // El tamaño no debe exceder el límite esperado (10 en este caso).
        expect(cars.length, lessThanOrEqualTo(10));
      },
      // Timeout para evitar tests colgados por red lenta.
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      // Verifica que cada auto tenga los campos mínimos poblados.
      'fetchCars returns cars with required fields populated',
      () async {
        final cars = await service.getCars();

        // Recorre todos los resultados y valida campos obligatorios.
        for (final car in cars) {
          expect(car.id, isNotNull);
          expect(car.year, greaterThan(0));
          expect(car.make, isNotEmpty);
          expect(car.model, isNotEmpty);
          expect(car.type, isNotEmpty);
        }
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      // Verifica estabilidad básica: múltiples llamadas consecutivas funcionan.
      'fetchCars can be called multiple times successfully',
      () async {
        final first = await service.getCars();
        await Future.delayed(const Duration(seconds: 2));
        final second = await service.getCars();

        // Ambas respuestas deben contener datos.
        expect(first, isNotEmpty);
        expect(second, isNotEmpty);

        // El tipo de ID debe ser consistente entre llamadas.
        expect(first.first.id.runtimeType, equals(second.first.id.runtimeType));
      },
      timeout: const Timeout(Duration(seconds: 45)),
    );

    test(
      // Verifica que getCarsLimitted devuelve como máximo el límite solicitado.
      'getCarsLimitted returns list up to requested limit',
      () async {
        const limit = 3;
        final cars = await service.getCarsLimitted(limit: limit);

        expect(cars, isNotEmpty);
        expect(cars.length, lessThanOrEqualTo(limit));
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      // Verifica que getCarsPage aplica paginación con page y limit.
      'getCarsPage returns list up to requested limit for given page',
      () async {
        const page = 1;
        const limit = 5;

        final cars = await service.getCarsPage(page, limit);

        expect(cars, isNotEmpty);
        expect(cars.length, lessThanOrEqualTo(limit));
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );
  });
}
