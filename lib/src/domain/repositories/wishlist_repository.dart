import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';

abstract class WishlistRepository {
  Future<void> addWishlistItem(WishlistItemEntity item);
  Future<void> removeWishlistItem(String id);
  Future<List<WishlistItemEntity>> getAllWishlistItems();
  Future<WishlistItemEntity?> getWishlistItemById(String id);
  Future<bool> isCountryInWishlist(String countryCode);
  Future<void> clearWishlist();
}
