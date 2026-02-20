import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_test/app_exports.dart';
import 'package:wigilabs_test/src/presentation/pages/country_details_page.dart';
import 'package:wigilabs_test/src/presentation/widgets/country_card.dart';

class CountriesListPage extends StatefulWidget {
  const CountriesListPage({super.key});

  @override
  State<CountriesListPage> createState() => _CountriesListPageState();
}

class _CountriesListPageState extends State<CountriesListPage> {
  final Set<String> _countriesInWishlist = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    context.read<CountriesBloc>().add(const FetchCountriesEvent());
    // Load wishlist items on init
    context.read<WishlistBloc>().add(const LoadWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('European Countries'),
        elevation: 0,
      ),
      body: BlocListener<WishlistBloc, WishlistState>(
        listener: (context, state) {
          if (state is WishlistLoaded) {
            setState(() {
              _countriesInWishlist.clear();
              for (var item in state.items) {
                _countriesInWishlist.add(item.countryCode);
              }
            });
          }
        },
        listenWhen: (previous, current) {
          // Rebuild _countriesInWishlist whenever wishlist changes
          return current is WishlistLoaded;
        },
        child: BlocBuilder<CountriesBloc, CountriesState>(
          builder: (context, state) {
            if (state is CountriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CountriesLoaded) {
              return ListView.builder(
                // Performance optimizations to prevent jank
                addRepaintBoundaries: true,
                cacheExtent: 250.0,
                itemCount: state.countries.length,
                itemBuilder: (context, index) {
                  final country = state.countries[index];
                  return RepaintBoundary(
                    child: CountryCard(
                      country: country,
                      isInWishlist: _countriesInWishlist.contains(country.code),
                      onTap: () => _navigateToDetails(context, country),
                      onWishlistToggle: () => _toggleWishlist(context, country),
                    ),
                  );
                },
              );
            } else if (state is CountriesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<CountriesBloc>()
                            .add(const FetchCountriesEvent());
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
      ),
    );
  }

  void _navigateToDetails(BuildContext context, CountryEntity country) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryDetailsPage(country: country),
      ),
    ).then((_) {
      // Reload wishlist when returning from details page
      print('Returned from details page, reloading wishlist...');
      if (context.mounted) {
        context.read<WishlistBloc>().add(const LoadWishlistEvent());
      }
    });
  }

  void _toggleWishlist(BuildContext context, CountryEntity country) {
    if (_countriesInWishlist.contains(country.code)) {
      // Remove from wishlist
      context.read<WishlistBloc>().add(
            RemoveFromWishlistEvent(id: country.code),
          );
    } else {
      // Add to wishlist
      final item = WishlistItemEntity(
        id: country.code,
        countryName: country.name,
        countryCode: country.code,
        flagUrl: country.flagUrl,
        addedAt: DateTime.now(),
      );
      context.read<WishlistBloc>().add(
            AddToWishlistEvent(item: item),
          );
    }
  }
}
