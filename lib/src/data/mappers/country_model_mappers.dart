import 'package:wigilabs_test/src/data/models/country_model.dart';
import 'package:wigilabs_test/src/domain/entities/country_entity.dart';

extension CountryModelToEntity on CountryModel {
  CountryEntity toEntity() {
    return CountryEntity(
      name: name?.common ?? '',
      code: cca2 ?? '',
      region: region ?? '',
      flagUrl: flags?.png ?? flags?.svg ?? '',
      capital: capital?.isNotEmpty == true ? capital!.first : 'N/A',
      population: population?.toString(),
      area: area?.toString(),
      languages: languages?.values.toList(),
      currencies: currencies?.values.map((c) => c.name ?? '').toList(),
    );
  }
}
