import 'package:cars2026/model/car_model.dart';
import 'package:cars2026/services/car_http_service.dart';
import 'package:flutter/material.dart';

class InfiniteCarsList extends StatefulWidget {
  const InfiniteCarsList({super.key, required this.carHttpService});

  final CarHttpService carHttpService;

  @override
  State<InfiniteCarsList> createState() => _InfiniteCarsListState();
}

class _InfiniteCarsListState extends State<InfiniteCarsList> {
  static const int _pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  final List<CarModel> _cars = <CarModel>[];

  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  double _offset = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadNextPage();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    _offset = _scrollController.offset;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadNextPage();
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoading || !_hasMore) {
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final newCars = await widget.carHttpService.getCarsPage(
        _currentPage,
        _pageSize,
      );

      setState(() {
        _cars.addAll(newCars);
        _currentPage++;
        _hasMore = newCars.length == _pageSize;
      });
    } catch (error) {
      setState(() {
        _error = error.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cars.isEmpty && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_cars.isEmpty && _error != null) {
      return Center(child: Text('Error: $_error'));
    }

    if (_cars.isEmpty) {
      return const Center(child: Text('No cars found'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Offset: ${_offset.toStringAsFixed(0)}'),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _cars.length + (_isLoading || _hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= _cars.length) {
                if (_error != null) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error: $_error'),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final car = _cars[index];
              return ListTile(
                title: Text('${car.make} ${car.model}'),
                subtitle: Text('${car.year} · ${car.type}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
