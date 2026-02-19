import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wigilabs_test/src/domain/entities/country_entity.dart';
import 'package:wigilabs_test/src/domain/usecases/countries_usecase.dart';
import 'package:wigilabs_test/src/presentation/bloc/countries/countries_bloc.dart';

class MockGetEuropeanCountriesUsecase extends Mock
    implements GetEuropeanCountriesUsecase {}

void main() {
  group('CountriesBloc', () {
    late CountriesBloc countriesBloc;
    late MockGetEuropeanCountriesUsecase mockGetEuropeanCountriesUsecase;

    setUp(() {
      mockGetEuropeanCountriesUsecase = MockGetEuropeanCountriesUsecase();
      countriesBloc = CountriesBloc(
        getEuropeanCountriesUsecase: mockGetEuropeanCountriesUsecase,
      );
    });

    tearDown(() {
      countriesBloc.close();
    });

    group('FetchCountriesEvent', () {
      blocTest<CountriesBloc, CountriesState>(
        'should emit [CountriesLoading, CountriesLoaded] when data is retrieved successfully',
        build: () {
          final countries = [
            const CountryEntity(
              name: 'Germany',
              code: 'DE',
              region: 'Europe',
              flagUrl: 'https://example.com/de.png',
              capital: 'Berlin',
            ),
            const CountryEntity(
              name: 'France',
              code: 'FR',
              region: 'Europe',
              flagUrl: 'https://example.com/fr.png',
              capital: 'Paris',
            ),
          ];

          when(() => mockGetEuropeanCountriesUsecase())
              .thenAnswer((_) async => countries);

          return countriesBloc;
        },
        act: (bloc) => bloc.add(const FetchCountriesEvent()),
        expect: () => [
          const CountriesLoading(),
          CountriesLoaded(countries: any(that: isA<List<CountryEntity>>())),
        ],
        verify: (_) {
          verify(() => mockGetEuropeanCountriesUsecase()).called(1);
        },
      );

      blocTest<CountriesBloc, CountriesState>(
        'should emit [CountriesLoading, CountriesError] when an error occurs',
        build: () {
          when(() => mockGetEuropeanCountriesUsecase())
              .thenThrow(Exception('Network error'));

          return countriesBloc;
        },
        act: (bloc) => bloc.add(const FetchCountriesEvent()),
        expect: () => [
          const CountriesLoading(),
          isA<CountriesError>(),
        ],
      );
    });
  });
}
