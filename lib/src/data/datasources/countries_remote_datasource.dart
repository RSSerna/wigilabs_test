import 'package:wigilabs_test/src/core/config/http_client_base.dart';
import 'package:wigilabs_test/src/data/models/country_model.dart';

abstract interface class CountriesRemoteDatasource {
  Future<List<CountryModel>> getEuropeanCountries();
  Future<CountryModel?> getCountryByName(String name);
}

class CountriesRemoteDatasourceImpl implements CountriesRemoteDatasource {
  final HttpClient _httpClient;

  CountriesRemoteDatasourceImpl({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<List<CountryModel>> getEuropeanCountries() async {
    try {
      final response = await _httpClient.get<List>(
        '/region/europe',
      );
      final List<dynamic> data = response;
      return data
          .map((json) => CountryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CountryModel?> getCountryByName(String name) async {
    try {
      final response = await _httpClient.get<List>(
        '/translation/$name',
      );
      final List<dynamic> data = response;
      if (data.isEmpty) return null;
      return CountryModel.fromJson(data.first as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
