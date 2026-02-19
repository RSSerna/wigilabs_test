import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wigilabs_test/src/data/database/app_database.dart';
import 'package:wigilabs_test/src/data/datasources/wishlist_local_datasource.dart';
import 'package:wigilabs_test/src/data/repositories/wishlist_repository_impl.dart';
import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';

class MockWishlistLocalDatasource extends Mock
    implements WishlistLocalDatasource {}

void main() {
  group('WishlistRepository', () {
    late WishlistRepositoryImpl repository;
    late MockWishlistLocalDatasource mockDatasource;

    setUp(() {
      mockDatasource = MockWishlistLocalDatasource();
      repository = WishlistRepositoryImpl(localDatasource: mockDatasource);
    });

    group('addWishlistItem', () {
      test('should add item successfully', () async {
        // Arrange
        final entity = WishlistItemEntity(
          id: '1',
          countryName: 'France',
          countryCode: 'FR',
          flagUrl: 'https://example.com/fr.png',
          addedAt: DateTime.now(),
        );

        when(() => mockDatasource.addWishlistItem(any()))
            .thenAnswer((_) async => {});

        // Act
        await repository.addWishlistItem(entity);

        // Assert
        verify(() => mockDatasource.addWishlistItem(any())).called(1);
      });

      test('should throw exception when datasource throws', () async {
        // Arrange
        final entity = WishlistItemEntity(
          id: '1',
          countryName: 'France',
          countryCode: 'FR',
          flagUrl: 'https://example.com/fr.png',
          addedAt: DateTime.now(),
        );

        when(() => mockDatasource.addWishlistItem(any()))
            .thenThrow(Exception('Database error'));

        // Act & Assert
        expect(
          () => repository.addWishlistItem(entity),
          throwsException,
        );
      });
    });

    group('removeWishlistItem', () {
      test('should remove item successfully', () async {
        // Arrange
        when(() => mockDatasource.removeWishlistItem('1'))
            .thenAnswer((_) async => {});

        // Act
        await repository.removeWishlistItem('1');

        // Assert
        verify(() => mockDatasource.removeWishlistItem('1')).called(1);
      });
    });

    group('getAllWishlistItems', () {
      test('should return list of items', () async {
        // Arrange
        final mockItems = [
          WishlistItemModel(
            id: '1',
            countryName: 'France',
            countryCode: 'FR',
            flagUrl: 'https://example.com/fr.png',
            addedAt: DateTime.now(),
          ),
        ];

        when(() => mockDatasource.getAllWishlistItems())
            .thenAnswer((_) async => mockItems);

        // Act
        final result = await repository.getAllWishlistItems();

        // Assert
        expect(result, isA<List<WishlistItemEntity>>());
        expect(result.length, 1);
        expect(result[0].countryName, 'France');
      });

      test('should return empty list when no items exist', () async {
        // Arrange
        when(() => mockDatasource.getAllWishlistItems())
            .thenAnswer((_) async => []);

        // Act
        final result = await repository.getAllWishlistItems();

        // Assert
        expect(result, isEmpty);
      });
    });

    group('isCountryInWishlist', () {
      test('should return true when country exists in wishlist', () async {
        // Arrange
        when(() => mockDatasource.isCountryInWishlist('FR'))
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.isCountryInWishlist('FR');

        // Assert
        expect(result, true);
      });

      test('should return false when country does not exist', () async {
        // Arrange
        when(() => mockDatasource.isCountryInWishlist('XX'))
            .thenAnswer((_) async => false);

        // Act
        final result = await repository.isCountryInWishlist('XX');

        // Assert
        expect(result, false);
      });
    });
  });
}
