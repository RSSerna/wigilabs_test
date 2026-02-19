import 'package:drift/drift.dart';
import 'package:wigilabs_test/src/data/models/wishlist_item_model.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [WishlistTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  // Wishlist operations
  Future<void> addWishlistItem(WishlistItemModel item) async {
    await into(wishlistTable).insertOnConflictUpdate(item);
  }

  Future<void> removeWishlistItem(String id) async {
    await (delete(wishlistTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<WishlistItemModel>> getAllWishlistItems() async {
    return await select(wishlistTable).get();
  }

  Future<WishlistItemModel?> getWishlistItemById(String id) async {
    return await (select(wishlistTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<bool> isCountryInWishlist(String countryCode) async {
    final result = await (select(wishlistTable)
          ..where((tbl) => tbl.countryCode.equals(countryCode)))
        .getSingleOrNull();
    return result != null;
  }

  Future<void> clearWishlist() async {
    await delete(wishlistTable).go();
  }
}
