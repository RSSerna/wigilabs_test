import 'package:wigilabs_test/src/data/database/app_database.dart';

abstract interface class WishlistLocalDatasource {
  Future<void> addWishlistItem(WishlistItemModel item);
  Future<void> removeWishlistItem(String id);
  Future<List<WishlistItemModel>> getAllWishlistItems();
  Future<WishlistItemModel?> getWishlistItemById(String id);
  Future<bool> isCountryInWishlist(String countryCode);
  Future<void> clearWishlist();
}

class WishlistLocalDatasourceImpl implements WishlistLocalDatasource {
  final AppDatabase database;

  WishlistLocalDatasourceImpl({required this.database});

  @override
  Future<void> addWishlistItem(WishlistItemModel item) async {
    await database.addWishlistItem(item);
  }

  @override
  Future<void> removeWishlistItem(String id) async {
    await database.removeWishlistItem(id);
  }

  @override
  Future<List<WishlistItemModel>> getAllWishlistItems() async {
    return await database.getAllWishlistItems();
  }

  @override
  Future<WishlistItemModel?> getWishlistItemById(String id) async {
    return await database.getWishlistItemById(id);
  }

  @override
  Future<bool> isCountryInWishlist(String countryCode) async {
    return await database.isCountryInWishlist(countryCode);
  }

  @override
  Future<void> clearWishlist() async {
    await database.clearWishlist();
  }
}
