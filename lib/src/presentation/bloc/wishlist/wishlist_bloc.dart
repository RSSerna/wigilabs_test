import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';
import 'package:wigilabs_test/src/domain/usecases/wishlist_usecase.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final AddToWishlistUsecase addToWishlistUsecase;
  final RemoveFromWishlistUsecase removeFromWishlistUsecase;
  final GetAllWishlistItemsUsecase getAllWishlistItemsUsecase;
  final IsCountryInWishlistUsecase isCountryInWishlistUsecase;
  final ClearWishlistUsecase clearWishlistUsecase;

  WishlistBloc({
    required this.addToWishlistUsecase,
    required this.removeFromWishlistUsecase,
    required this.getAllWishlistItemsUsecase,
    required this.isCountryInWishlistUsecase,
    required this.clearWishlistUsecase,
  }) : super(const WishlistInitial()) {
    on<LoadWishlistEvent>(_onLoadWishlist);
    on<AddToWishlistEvent>(_onAddToWishlist);
    on<RemoveFromWishlistEvent>(_onRemoveFromWishlist);
    on<CheckIfCountryInWishlistEvent>(_onCheckIfCountryInWishlist);
    on<ClearWishlistEvent>(_onClearWishlist);
  }

  Future<void> _onLoadWishlist(
    LoadWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(const WishlistLoading());
    try {
      final items = await getAllWishlistItemsUsecase();
      emit(WishlistLoaded(items: items));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  Future<void> _onAddToWishlist(
    AddToWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      await addToWishlistUsecase(event.item);

      // Reload wishlist to reflect changes
      final items = await getAllWishlistItemsUsecase();
      emit(WishlistLoaded(items: items));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      await removeFromWishlistUsecase(event.id);

      // Reload wishlist to reflect changes
      final items = await getAllWishlistItemsUsecase();
      emit(WishlistLoaded(items: items));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  Future<void> _onCheckIfCountryInWishlist(
    CheckIfCountryInWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      final isInWishlist = await isCountryInWishlistUsecase(event.countryCode);
      emit(CountryWishlistStatus(isInWishlist: isInWishlist));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  Future<void> _onClearWishlist(
    ClearWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      emit(const WishlistLoading());

      await clearWishlistUsecase();

      emit(const WishlistLoaded(items: []));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }
}
