import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wigilabs_test/src/data/database/app_database.dart';
import 'package:wigilabs_test/src/data/datasources/wishlist_local_datasource.dart';
import 'package:wigilabs_test/src/data/repositories/wishlist_repository_impl.dart';
import 'package:wigilabs_test/src/domain/entities/wishlist_item_entity.dart';

class MockWishlistLocalDatasource extends Mock
    implements WishlistLocalDatasource {}

class FakeWishlistItemEntity extends Fake implements WishlistItemEntity {}

class FakeWishlistItemModel extends Fake implements WishlistItemModel {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeWishlistItemEntity());
    registerFallbackValue(FakeWishlistItemModel());
  });

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

      test('should throw exception when item not found', () async {
        // Arrange
        when(() => mockDatasource.removeWishlistItem('invalid'))
            .thenThrow(Exception('Item not found'));

        // Act & Assert
        expect(
          () => repository.removeWishlistItem('invalid'),
          throwsException,
        );
      });

      test('should pass correct id to datasource', () async {
        // Arrange
        when(() => mockDatasource.removeWishlistItem('2'))
            .thenAnswer((_) async => {});

        // Act
        await repository.removeWishlistItem('2');

        // Assert
        verify(() => mockDatasource.removeWishlistItem('2')).called(1);
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
          WishlistItemModel(
            id: '2',
            countryName: 'Spain',
            countryCode: 'ES',
            flagUrl: 'https://example.com/es.png',
            addedAt: DateTime.now(),
          ),
        ];

        when(() => mockDatasource.getAllWishlistItems())
            .thenAnswer((_) async => mockItems);

        // Act
        final result = await repository.getAllWishlistItems();

        // Assert
        expect(result, isA<List<WishlistItemEntity>>());
        expect(result.length, 2);
        expect(result[0].countryName, 'France');
        expect(result[1].countryName, 'Spain');
      });

      test('should return empty list when no items exist', () async {
        // Arrange
        when(() => mockDatasource.getAllWishlistItems())
            .thenAnswer((_) async => []);

        // Act
        final result = await repository.getAllWishlistItems();

        // Assert
        expect(result, isEmpty);
        verify(() => mockDatasource.getAllWishlistItems()).called(1);
      });

      test('should throw exception when datasource throws', () async {
        // Arrange
        when(() => mockDatasource.getAllWishlistItems())
            .thenThrow(Exception('Database error'));

        // Act & Assert
        expect(
          () => repository.getAllWishlistItems(),
          throwsException,
        );
      });

      test('should convert WishlistItemModel to WishlistItemEntity', () async {
        // Arrange
        final now = DateTime.now();
        final mockItems = [
          WishlistItemModel(
            id: '1',
            countryName: 'Germany',
            countryCode: 'DE',
            flagUrl: 'https://example.com/de.png',
            addedAt: now,
          ),
        ];

        when(() => mockDatasource.getAllWishlistItems())
            .thenAnswer((_) async => mockItems);

        // Act
        final result = await repository.getAllWishlistItems();

        // Assert
        expect(result[0].id, '1');
        expect(result[0].countryName, 'Germany');
        expect(result[0].countryCode, 'DE');
        expect(result[0].flagUrl, 'https://example.com/de.png');
        expect(result[0].addedAt, now);
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
        verify(() => mockDatasource.isCountryInWishlist('FR')).called(1);
      });

      test('should return false when country does not exist', () async {
        // Arrange
        when(() => mockDatasource.isCountryInWishlist('XX'))
            .thenAnswer((_) async => false);

        // Act
        final result = await repository.isCountryInWishlist('XX');

        // Assert
        expect(result, false);
        verify(() => mockDatasource.isCountryInWishlist('XX')).called(1);
      });

      test('should throw exception when datasource throws', () async {
        // Arrange
        when(() => mockDatasource.isCountryInWishlist('FR'))
            .thenThrow(Exception('Database error'));

        // Act & Assert
        expect(
          () => repository.isCountryInWishlist('FR'),
          throwsException,
        );
      });
    });

    group('clearWishlist', () {
      test('should clear all items successfully', () async {
        // Arrange
        when(() => mockDatasource.clearWishlist()).thenAnswer((_) async => {});

        // Act
        await repository.clearWishlist();

        // Assert
        verify(() => mockDatasource.clearWishlist()).called(1);
      });

      test('should throw exception when datasource throws', () async {
        // Arrange
        when(() => mockDatasource.clearWishlist())
            .thenThrow(Exception('Database error'));

        // Act & Assert
        expect(
          () => repository.clearWishlist(),
          throwsException,
        );
      });
    });
  });
}
