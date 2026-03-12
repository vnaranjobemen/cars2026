import 'package:cars2026/model/car_model.dart';
import 'package:cars2026/services/car_http_service.dart';
import 'package:flutter/material.dart';

/*
 * Stateful Widget
*/
class CarsList1 extends StatefulWidget {
  const CarsList1({super.key, required this.carHttpService});

  final CarHttpService carHttpService;

  @override
  State<CarsList1> createState() => _CarsList1State();
}

/*
 * L'Estat de l'Stateful Widget (és el que fa que es repin amb el métode bu)
*/
class _CarsList1State extends State<CarsList1> {
  List<CarModel> _cars = [];
  bool _isLoading = true;
  String? _error;

  // Mètode privat per carregar els cotxes, és cridat a initState
  Future<void> _loadCars() async {
    try {
      final cars = await widget.carHttpService.getCarsLimitted(limit: 10);
      setState(() {
        _cars = cars;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  //Mètode per inicialitzar l'estat. Carrega els cotxes quan el widget és creat
  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  //Mètode per pintar la llista de cotxes. Mostra un indicador de càrrega mentre es carreguen, un missatge d'error si hi ha un error, o la llista de cotxes si s'han carregat correctament
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    return ListView.builder(
      itemCount: _cars.length,
      itemBuilder: (context, index) {
        final car = _cars[index];
        return ListTile(
          title: Text('${car.make} ${car.model}'),
          subtitle: Text('${car.year} · ${car.type}'),
        );
      },
    );
  }
}
