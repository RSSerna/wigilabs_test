import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';
import 'package:wigilabs_test/src/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:wigilabs_test/src/presentation/widgets/wishlist_item_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  bool _useOptimizations = true;
  bool _isStressTestRunning = false;

  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(const LoadWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        elevation: 0,
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    // Stress Test Control Panel
                    stressContainer(context),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.favorite_border,
                                size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text('No countries in your wishlist yet'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Browse Countries'),
                            ),
                          ]),
                    )
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Stress Test Control Panel
                stressContainer(context),
                // Wishlist Items
                Expanded(
                  child: ListView.builder(
                    // Performance optimizations to prevent jank
                    addRepaintBoundaries: true,
                    cacheExtent: 250.0,
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return RepaintBoundary(
                        child: WishlistItemCard(
                          item: item,
                          onDelete: () {
                            context
                                .read<WishlistBloc>()
                                .add(RemoveFromWishlistEvent(id: item.id));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is WishlistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<WishlistBloc>()
                          .add(const LoadWishlistEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Container stressContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      // color: Colors.grey[100],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Performance Test',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text('Optimized'),
                  Switch(
                    value: _useOptimizations,
                    onChanged: _isStressTestRunning
                        ? null
                        : (value) {
                            setState(() {
                              _useOptimizations = value;
                            });
                          },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      _isStressTestRunning ? null : () => _runStressTest(50),
                  child: _isStressTestRunning
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Add 50 Countries'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isStressTestRunning
                      ? null
                      : () {
                          context
                              .read<WishlistBloc>()
                              .add(const ClearWishlistEvent());
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[300],
                  ),
                  child: const Text('Clear All'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Run stress test with or without optimizations
  Future<void> _runStressTest(int count) async {
    setState(() => _isStressTestRunning = true);

    try {
      if (_useOptimizations) {
        await _stressTestWithOptimizations(count);
      } else {
        await _stressTestWithoutOptimizations(count);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Added $count countries - Mode: ${_useOptimizations ? 'Optimized' : 'Unoptimized'}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isStressTestRunning = false);
      }
    }
  }

  Future<void> _stressTestWithOptimizations(int count) async {
    final stopwatch = Stopwatch()..start(); // ✅ Inicia cronómetro

    try {
      for (int i = 0; i < count; i++) {
        await compute(_performHeavyProcessing, 0);

        final item = _createTestItem(i);

        if (mounted) {
          context.read<WishlistBloc>().add(AddToWishlistEvent(item: item));
        }
      }
    } finally {
      stopwatch.stop(); // ✅ Detiene cronómetro
      debugPrint(
          'Optimized: ${stopwatch.elapsedMilliseconds}ms (${(stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(2)}s)');
    }
  }

  /// Stress test WITHOUT optimizations (no compute, blocks UI)
  Future<void> _stressTestWithoutOptimizations(int count) async {
    final stopwatch = Stopwatch()..start(); // ✅ Inicia cronómetro

    try {
      for (int i = 0; i < count; i++) {
        _performHeavyProcessing(i);

        final item = _createTestItem(i);

        if (mounted) {
          context.read<WishlistBloc>().add(AddToWishlistEvent(item: item));
        }
      }
    } finally {
      stopwatch.stop(); // ✅ Detiene cronómetro

      // ✅ Actualiza el UI con el tiempo
      debugPrint(
          'Without Optimization: ${stopwatch.elapsedMilliseconds}ms (${(stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(2)}s)');
    }
  }
}

/// Create a test wishlist item
WishlistItemEntity _createTestItem(int index) {
  return WishlistItemEntity(
    id: 'test_stress_${DateTime.now().millisecondsSinceEpoch}_$index',
    countryName: 'Test Country $index',
    countryCode: 'TC$index',
    flagUrl: 'https://example.com/flag.png',
    addedAt: DateTime.now(),
  );
}

int _performHeavyProcessing(int x) {
  int sum = 0;
  for (int i = 0; i < 50000000; i++) {
    sum += i;
    if (i % 10000000 == 0) {
      sum = sum ~/ 2;
      sum = sum * 3;
    }
  }
  return sum;
}
