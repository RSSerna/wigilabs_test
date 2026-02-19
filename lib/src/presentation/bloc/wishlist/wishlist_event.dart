part of 'wishlist_bloc.dart';

sealed class WishlistEvent {
  const WishlistEvent();
}

class LoadWishlistEvent extends WishlistEvent {
  const LoadWishlistEvent();
}

class AddToWishlistEvent extends WishlistEvent {
  final WishlistItemEntity item;

  const AddToWishlistEvent({required this.item});
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final String id;

  const RemoveFromWishlistEvent({required this.id});
}

class CheckIfCountryInWishlistEvent extends WishlistEvent {
  final String countryCode;

  const CheckIfCountryInWishlistEvent({required this.countryCode});
}
