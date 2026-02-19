import 'package:wigilabs_test/src/domain/entities/country_entity.dart';
import 'package:wigilabs_test/src/domain/repositories/countries_repository.dart';

class GetEuropeanCountriesUsecase {
  final CountriesRepository repository;

  GetEuropeanCountriesUsecase({required this.repository});

  Future<List<CountryEntity>> call() async {
    return await repository.getEuropeanCountries();
  }
}

class GetCountryByNameUsecase {
  final CountriesRepository repository;

  GetCountryByNameUsecase({required this.repository});

  Future<CountryEntity?> call(String name) async {
    return await repository.getCountryByName(name);
  }
}
