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

class FakeWishlistItemEntity extends Fake implements WishlistItemEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeWishlistItemEntity());
  });

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

      blocTest<WishlistBloc, WishlistState>(
        'should emit WishlistError when add operation fails',
        build: () {
          when(() => mockAddToWishlistUsecase(any()))
              .thenThrow(Exception('Failed to add item'));

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
          isA<WishlistError>(),
        ],
      );

      blocTest<WishlistBloc, WishlistState>(
        'should call addToWishlistUsecase with correct item',
        build: () {
          final item = WishlistItemEntity(
            id: '2',
            countryName: 'Spain',
            countryCode: 'ES',
            flagUrl: 'https://example.com/es.png',
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
              id: '2',
              countryName: 'Spain',
              countryCode: 'ES',
              flagUrl: 'https://example.com/es.png',
              addedAt: DateTime.now(),
            ),
          ),
        ),
        verify: (bloc) {
          verify(() => mockAddToWishlistUsecase(any())).called(1);
        },
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

      blocTest<WishlistBloc, WishlistState>(
        'should emit WishlistError when remove operation fails',
        build: () {
          when(() => mockRemoveFromWishlistUsecase('invalid'))
              .thenThrow(Exception('Item not found'));

          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWishlistEvent(id: 'invalid')),
        expect: () => [
          isA<WishlistError>(),
        ],
      );

      blocTest<WishlistBloc, WishlistState>(
        'should call removeFromWishlistUsecase with correct id',
        build: () {
          when(() => mockRemoveFromWishlistUsecase('1'))
              .thenAnswer((_) async => {});

          when(() => mockGetAllWishlistItemsUsecase())
              .thenAnswer((_) async => []);

          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWishlistEvent(id: '1')),
        verify: (bloc) {
          verify(() => mockRemoveFromWishlistUsecase('1')).called(1);
        },
      );
    });

    group('CheckIfCountryInWishlistEvent', () {
      blocTest<WishlistBloc, WishlistState>(
        'should emit CountryWishlistStatus with true when country exists',
        build: () {
          when(() => mockIsCountryInWishlistUsecase('FR'))
              .thenAnswer((_) async => true);

          return wishlistBloc;
        },
        act: (bloc) =>
            bloc.add(const CheckIfCountryInWishlistEvent(countryCode: 'FR')),
        expect: () => [
          isA<CountryWishlistStatus>()
              .having((state) => state.isInWishlist, 'isInWishlist', true),
        ],
      );

      blocTest<WishlistBloc, WishlistState>(
        'should emit CountryWishlistStatus with false when country not exists',
        build: () {
          when(() => mockIsCountryInWishlistUsecase('XX'))
              .thenAnswer((_) async => false);

          return wishlistBloc;
        },
        act: (bloc) =>
            bloc.add(const CheckIfCountryInWishlistEvent(countryCode: 'XX')),
        expect: () => [
          isA<CountryWishlistStatus>()
              .having((state) => state.isInWishlist, 'isInWishlist', false),
        ],
      );

      blocTest<WishlistBloc, WishlistState>(
        'should emit WishlistError when check operation fails',
        build: () {
          when(() => mockIsCountryInWishlistUsecase('FR'))
              .thenThrow(Exception('Database error'));

          return wishlistBloc;
        },
        act: (bloc) =>
            bloc.add(const CheckIfCountryInWishlistEvent(countryCode: 'FR')),
        expect: () => [
          isA<WishlistError>(),
        ],
      );
    });

    group('ClearWishlistEvent', () {
      blocTest<WishlistBloc, WishlistState>(
        'should emit [WishlistLoading, WishlistLoaded] when clear succeeds',
        build: () {
          when(() => mockClearWishlistUsecase()).thenAnswer((_) async => {});

          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const ClearWishlistEvent()),
        expect: () => [
          const WishlistLoading(),
          const WishlistLoaded(items: []),
        ],
      );

      blocTest<WishlistBloc, WishlistState>(
        'should emit [WishlistLoading, WishlistError] when clear fails',
        build: () {
          when(() => mockClearWishlistUsecase())
              .thenThrow(Exception('Failed to clear'));

          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const ClearWishlistEvent()),
        expect: () => [
          const WishlistLoading(),
          isA<WishlistError>(),
        ],
      );

      blocTest<WishlistBloc, WishlistState>(
        'should call clearWishlistUsecase',
        build: () {
          when(() => mockClearWishlistUsecase()).thenAnswer((_) async => {});

          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const ClearWishlistEvent()),
        verify: (bloc) {
          verify(() => mockClearWishlistUsecase()).called(1);
        },
      );
    });
  });
}
