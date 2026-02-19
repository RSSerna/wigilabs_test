part of 'wishlist_bloc.dart';

sealed class WishlistState {
  const WishlistState();
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

class WishlistLoading extends WishlistState {
  const WishlistLoading();
}

class WishlistLoaded extends WishlistState {
  final List<WishlistItemEntity> items;

  const WishlistLoaded({required this.items});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistLoaded &&
          runtimeType == other.runtimeType &&
          items == other.items;

  @override
  int get hashCode => items.hashCode;
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError({required this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class CountryWishlistStatus extends WishlistState {
  final bool isInWishlist;

  const CountryWishlistStatus({required this.isInWishlist});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryWishlistStatus &&
          runtimeType == other.runtimeType &&
          isInWishlist == other.isInWishlist;

  @override
  int get hashCode => isInWishlist.hashCode;
}
