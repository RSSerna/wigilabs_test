import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';
import 'package:wigilabs_test/src/domain/usecases/wishlist_usecase.dart';
import 'package:wigilabs_test/src/presentation/bloc/wishlist/wishlist_bloc.dart';

class MockAddToWishlistUsecase extends Mock implements AddToWishlistUsecase {}

class MockRemoveFromWishlistUsecase extends Mock
    implements RemoveFromWishlistUsecase {}

class MockGetAllWishlistItemsUsecase extends Mock
    implements GetAllWishlistItemsUsecase {}

class MockIsCountryInWishlistUsecase extends Mock
    implements IsCountryInWishlistUsecase {}

class MockClearWishlistUsecase extends Mock implements ClearWishlistUsecase {}

void main() {
  group('WishlistBloc', () {
    late WishlistBloc wishlistBloc;
    late MockAddToWishlistUsecase mockAddToWishlistUsecase;
    late MockRemoveFromWishlistUsecase mockRemoveFromWishlistUsecase;
    late MockGetAllWishlistItemsUsecase mockGetAllWishlistItemsUsecase;
    late MockIsCountryInWishlistUsecase mockIsCountryInWishlistUsecase;
    late MockClearWishlistUsecase mockClearWishlistUsecase;

    setUp(() {
      mockAddToWishlistUsecase = MockAddToWishlistUsecase();
      mockRemoveFromWishlistUsecase = MockRemoveFromWishlistUsecase();
      mockGetAllWishlistItemsUsecase = MockGetAllWishlistItemsUsecase();
      mockIsCountryInWishlistUsecase = MockIsCountryInWishlistUsecase();
      mockClearWishlistUsecase = MockClearWishlistUsecase();

      wishlistBloc = WishlistBloc(
        addToWishlistUsecase: mockAddToWishlistUsecase,
        removeFromWishlistUsecase: mockRemoveFromWishlistUsecase,
        getAllWishlistItemsUsecase: mockGetAllWishlistItemsUsecase,
        isCountryInWishlistUsecase: mockIsCountryInWishlistUsecase,
        clearWishlistUsecase: mockClearWishlistUsecase,
      );
    });

    tearDown(() {
      wishlistBloc.close();
    });

    group('LoadWishlistEvent', () {
      blocTest<WishlistBloc, WishlistState>(
        'should emit [WishlistLoading, WishlistLoaded] when data is retrieved successfully',
        build: () {
          final items = [
            WishlistItemEntity(
              id: '1',
              countryName: 'France',
              countryCode: 'FR',
              flagUrl: 'https://example.com/fr.png',
              addedAt: DateTime.now(),
            ),
          ];

          when(() => mockGetAllWishlistItemsUsecase())
              .thenAnswer((_) async => items);

          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const LoadWishlistEvent()),
        expect: () => [
          const WishlistLoading(),
          isA<WishlistLoaded>(),
        ],
      );

      blocTest<WishlistBloc, WishlistState>(
        'should emit [WishlistLoading, WishlistError] when an error occurs',
        build: () {
          when(() => mockGetAllWishlistItemsUsecase())
              .thenThrow(Exception('Database error'));

          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const LoadWishlistEvent()),
        expect: () => [
          const WishlistLoading(),
          isA<WishlistError>(),
        ],
      );
    });

    group('AddToWishlistEvent', () {
      blocTest<WishlistBloc, WishlistState>(
        'should add item and reload wishlist',
        build: () {
          final item = WishlistItemEntity(
            id: '1',
            countryName: 'Italy',
            countryCode: 'IT',
            flagUrl: 'https://example.com/it.png',
            addedAt: DateTime.now(),
          );

          when(() => mockAddToWishlistUsecase(any()))
              .thenAnswer((_) async => {});

          when(() => mockGetAllWishlistItemsUsecase())
              .thenAnswer((_) async => [item]);

          return wishlistBloc;
        },
        act: (bloc) => bloc.add(
          AddToWishlistEvent(
            item: WishlistItemEntity(
              id: '1',
              countryName: 'Italy',
              countryCode: 'IT',
              flagUrl: 'https://example.com/it.png',
              addedAt: DateTime.now(),
            ),
          ),
        ),
        expect: () => [
          isA<WishlistLoaded>(),
        ],
      );
    });

    group('RemoveFromWishlistEvent', () {
      blocTest<WishlistBloc, WishlistState>(
        'should remove item and reload wishlist',
        build: () {
          when(() => mockRemoveFromWishlistUsecase('1'))
              .thenAnswer((_) async => {});

          when(() => mockGetAllWishlistItemsUsecase())
              .thenAnswer((_) async => []);

          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWishlistEvent(id: '1')),
        expect: () => [
          isA<WishlistLoaded>(),
        ],
      );
    });
  });
}
