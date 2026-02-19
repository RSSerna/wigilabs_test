import 'package:wigilabs_test/src/data/database/app_database.dart';
import 'package:wigilabs_test/src/data/datasources/wishlist_local_datasource.dart';
import 'package:wigilabs_test/src/data/mappers/wishlist_item_model_mapper.dart';
import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';
import 'package:wigilabs_test/src/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDatasource localDatasource;

  WishlistRepositoryImpl({required this.localDatasource});

  @override
  Future<void> addWishlistItem(WishlistItemEntity item) async {
    try {
      final WishlistItemModel model = item.toModel();
      await localDatasource.addWishlistItem(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeWishlistItem(String id) async {
    try {
      await localDatasource.removeWishlistItem(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WishlistItemEntity>> getAllWishlistItems() async {
    try {
      final models = await localDatasource.getAllWishlistItems();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WishlistItemEntity?> getWishlistItemById(String id) async {
    try {
      final model = await localDatasource.getWishlistItemById(id);
      return model?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isCountryInWishlist(String countryCode) async {
    try {
      return await localDatasource.isCountryInWishlist(countryCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearWishlist() async {
    try {
      await localDatasource.clearWishlist();
    } catch (e) {
      rethrow;
    }
  }
}
