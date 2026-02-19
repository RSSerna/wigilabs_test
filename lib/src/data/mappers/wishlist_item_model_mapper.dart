import 'package:wigilabs_test/src/data/database/app_database.dart';
import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';

extension WishlistItemModelToEntity on WishlistItemModel {
  WishlistItemEntity toEntity() {
    return WishlistItemEntity(
      id: id,
      countryName: countryName,
      countryCode: countryCode,
      flagUrl: flagUrl,
      addedAt: addedAt,
    );
  }
}

extension WishlistItemEntityToModel on WishlistItemEntity {
  WishlistItemModel toModel() {
    return WishlistItemModel(
      id: id,
      countryName: countryName,
      countryCode: countryCode,
      flagUrl: flagUrl,
      addedAt: addedAt,
    );
  }
}
