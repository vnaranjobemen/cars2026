import 'package:flutter/material.dart';
import 'package:cars2026/view/cars_page.dart';
import 'package:cars2026/services/car_http_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key, CarHttpService? carHttpService})
    : _carHttpService = carHttpService ?? CarHttpService();

  final CarHttpService _carHttpService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cars 2026',
      home: CarsPage(carHttpService: _carHttpService),
    );
  }
}
