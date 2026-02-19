import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wigilabs_test/src/data/datasources/countries_remote_datasource.dart';
import 'package:wigilabs_test/src/data/models/country_model.dart';
import 'package:wigilabs_test/src/data/repositories/countries_repository_impl.dart';
import 'package:wigilabs_test/src/domain/entities/country_entity.dart';

class MockCountriesRemoteDatasource extends Mock
    implements CountriesRemoteDatasource {}

void main() {
  group('CountriesRepository', () {
    late CountriesRepositoryImpl repository;
    late MockCountriesRemoteDatasource mockDatasource;

    setUp(() {
      mockDatasource = MockCountriesRemoteDatasource();
      repository = CountriesRepositoryImpl(remoteDatasource: mockDatasource);
    });

    group('getEuropeanCountries', () {
      test('should return list of CountryEntity when call is successful',
          () async {
        // Arrange
        final mockModels = [
          CountryModel(
            name: CountryNameModel(common: 'Germany'),
            cca2: 'DE',
            region: 'Europe',
            capital: ['Berlin'],
            flags: FlagsModel(
              png: 'https://example.com/de.png',
              svg: 'https://example.com/de.svg',
            ),
          ),
        ];

        when(() => mockDatasource.getEuropeanCountries())
            .thenAnswer((_) async => mockModels);

        // Act
        final result = await repository.getEuropeanCountries();

        // Assert
        expect(result, isA<List<CountryEntity>>());
        expect(result.length, 1);
        expect(result[0].name, 'Germany');
        expect(result[0].code, 'DE');
        verify(() => mockDatasource.getEuropeanCountries()).called(1);
      });

      test('should throw exception when datasource throws', () async {
        // Arrange
        when(() => mockDatasource.getEuropeanCountries())
            .thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () => repository.getEuropeanCountries(),
          throwsException,
        );
      });
    });

    group('getCountryByName', () {
      test('should return CountryEntity when country is found', () async {
        // Arrange
        final mockModel = CountryModel(
          name: CountryNameModel(common: 'Spain'),
          cca2: 'ES',
          region: 'Europe',
          capital: ['Madrid'],
          flags: FlagsModel(
            png: 'https://example.com/es.png',
          ),
        );

        when(() => mockDatasource.getCountryByName('Spain'))
            .thenAnswer((_) async => mockModel);

        // Act
        final result = await repository.getCountryByName('Spain');

        // Assert
        expect(result, isA<CountryEntity>());
        expect(result?.name, 'Spain');
        expect(result?.code, 'ES');
      });

      test('should return null when country is not found', () async {
        // Arrange
        when(() => mockDatasource.getCountryByName('NonExistent'))
            .thenAnswer((_) async => null);

        // Act
        final result = await repository.getCountryByName('NonExistent');

        // Assert
        expect(result, isNull);
      });
    });
  });
}
