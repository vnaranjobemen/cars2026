import 'package:cars2026/services/car_http_service.dart';
import 'package:flutter/material.dart';
import 'package:cars2026/view/cars_list.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key, required this.carHttpService});

  final CarHttpService carHttpService;

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cars'),
      ),
      body: InfiniteCarsList(carHttpService: widget.carHttpService),
    );
  }
}
