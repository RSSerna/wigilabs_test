import 'package:wigilabs_test/src/domain/entities/country_entity.dart';

abstract class CountriesRepository {
  Future<List<CountryEntity>> getEuropeanCountries();
  Future<CountryEntity?> getCountryByName(String name);
}
