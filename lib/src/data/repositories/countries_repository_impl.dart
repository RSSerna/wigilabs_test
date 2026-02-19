import 'package:wigilabs_test/src/data/datasources/countries_remote_datasource.dart';
import 'package:wigilabs_test/src/data/mappers/country_model_mappers.dart';
import 'package:wigilabs_test/src/domain/entities/country_entity.dart';
import 'package:wigilabs_test/src/domain/repositories/countries_repository.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDatasource remoteDatasource;

  CountriesRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<CountryEntity>> getEuropeanCountries() async {
    try {
      final models = await remoteDatasource.getEuropeanCountries();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CountryEntity?> getCountryByName(String name) async {
    try {
      final model = await remoteDatasource.getCountryByName(name);
      return model?.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
