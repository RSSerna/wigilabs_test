import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';

class WishlistItemCard extends StatelessWidget {
  final WishlistItemEntity item;
  final VoidCallback onDelete;

  const WishlistItemCard({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: item.flagUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[300],
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.flag),
            ),
          ),
          title: Text(item.countryName),
          subtitle: Text(
            'Added: ${item.addedAt.toString().split(' ')[0]}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: const Icon(Icons.swipe_left, color: Colors.grey),
        ),
      ),
    );
  }
}
