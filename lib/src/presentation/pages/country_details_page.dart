import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_test/src/domain/entities/country_entity.dart';
import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';
import 'package:wigilabs_test/src/presentation/bloc/wishlist/wishlist_bloc.dart';

class CountryDetailsPage extends StatefulWidget {
  final CountryEntity country;

  const CountryDetailsPage({
    super.key,
    required this.country,
  });

  @override
  State<CountryDetailsPage> createState() => _CountryDetailsPageState();
}

class _CountryDetailsPageState extends State<CountryDetailsPage> {
  bool _isInWishlist = false;

  @override
  void initState() {
    super.initState();
    _checkIfInWishlist();
  }

  void _checkIfInWishlist() async {
    final wishlistBloc = context.read<WishlistBloc>();
    wishlistBloc.add(
      CheckIfCountryInWishlistEvent(countryCode: widget.country.code),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.name),
        elevation: 0,
      ),
      body: BlocListener<WishlistBloc, WishlistState>(
        listener: (context, state) {
          if (state is CountryWishlistStatus) {
            setState(() {
              _isInWishlist = state.isInWishlist;
            });
          } else if (state is WishlistLoaded) {
            // Check if current country is in the loaded wishlist
            final isInWishlist = state.items.any(
              (item) => item.id == widget.country.code,
            );
            setState(() {
              _isInWishlist = isInWishlist;
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flag Image
              SizedBox(
                width: 320,
                height: 250,
                child: CachedNetworkImage(
                  imageUrl: widget.country.flagUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.flag, size: 64),
                  ),
                ),
              ),
              // Country Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.country.name,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Code: ${widget.country.code}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'Region',
                      widget.country.region,
                      context,
                    ),
                    _buildDetailRow(
                      'Capital',
                      widget.country.capital,
                      context,
                    ),
                    if (widget.country.population != null)
                      _buildDetailRow(
                        'Population',
                        widget.country.population!,
                        context,
                      ),
                    if (widget.country.area != null)
                      _buildDetailRow(
                        'Area (km²)',
                        widget.country.area!,
                        context,
                      ),
                    if (widget.country.languages != null &&
                        widget.country.languages!.isNotEmpty)
                      _buildDetailRow(
                        'Languages',
                        widget.country.languages!.join(', '),
                        context,
                      ),
                    if (widget.country.currencies != null &&
                        widget.country.currencies!.isNotEmpty)
                      _buildDetailRow(
                        'Currencies',
                        widget.country.currencies!.join(', '),
                        context,
                      ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Icon(_isInWishlist
                            ? Icons.favorite
                            : Icons.favorite_border),
                        label: Text(_isInWishlist
                            ? 'Remove from Wishlist'
                            : 'Add to Wishlist'),
                        onPressed: _toggleWishlist,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  void _toggleWishlist() {
    if (_isInWishlist) {
      context.read<WishlistBloc>().add(
            RemoveFromWishlistEvent(id: widget.country.code),
          );
    } else {
      final item = WishlistItemEntity(
        id: widget.country.code,
        countryName: widget.country.name,
        countryCode: widget.country.code,
        flagUrl: widget.country.flagUrl,
        addedAt: DateTime.now(),
      );
      context.read<WishlistBloc>().add(
            AddToWishlistEvent(item: item),
          );
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(!_isInWishlist
            ? '${widget.country.name} added to wishlist'
            : '${widget.country.name} removed from wishlist'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
