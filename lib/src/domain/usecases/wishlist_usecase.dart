import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';
import 'package:wigilabs_test/src/domain/repositories/wishlist_repository.dart';

class AddToWishlistUsecase {
  final WishlistRepository repository;

  AddToWishlistUsecase({required this.repository});

  Future<void> call(WishlistItemEntity item) async {
    return await repository.addWishlistItem(item);
  }
}

class RemoveFromWishlistUsecase {
  final WishlistRepository repository;

  RemoveFromWishlistUsecase({required this.repository});

  Future<void> call(String id) async {
    return await repository.removeWishlistItem(id);
  }
}

class GetAllWishlistItemsUsecase {
  final WishlistRepository repository;

  GetAllWishlistItemsUsecase({required this.repository});

  Future<List<WishlistItemEntity>> call() async {
    return await repository.getAllWishlistItems();
  }
}

class IsCountryInWishlistUsecase {
  final WishlistRepository repository;

  IsCountryInWishlistUsecase({required this.repository});

  Future<bool> call(String countryCode) async {
    return await repository.isCountryInWishlist(countryCode);
  }
}

class ClearWishlistUsecase {
  final WishlistRepository repository;

  ClearWishlistUsecase({required this.repository});

  Future<void> call() async {
    return await repository.clearWishlist();
  }
}
