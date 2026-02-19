// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      name: json['name'] == null
          ? null
          : CountryNameModel.fromJson(json['name'] as Map<String, dynamic>),
      cca2: json['cca2'] as String?,
      ccn3: json['ccn3'] as String?,
      region: json['region'] as String?,
      capital:
          (json['capital'] as List<dynamic>?)?.map((e) => e as String).toList(),
      flags: json['flags'] == null
          ? null
          : FlagsModel.fromJson(json['flags'] as Map<String, dynamic>),
      population: (json['population'] as num?)?.toInt(),
      area: (json['area'] as num?)?.toDouble(),
      languages: (json['languages'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      currencies: (json['currencies'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, CurrencyModel.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cca2': instance.cca2,
      'ccn3': instance.ccn3,
      'region': instance.region,
      'capital': instance.capital,
      'flags': instance.flags,
      'population': instance.population,
      'area': instance.area,
      'languages': instance.languages,
      'currencies': instance.currencies,
    };

CountryNameModel _$CountryNameModelFromJson(Map<String, dynamic> json) =>
    CountryNameModel(
      common: json['common'] as String?,
      official: json['official'] as String?,
    );

Map<String, dynamic> _$CountryNameModelToJson(CountryNameModel instance) =>
    <String, dynamic>{
      'common': instance.common,
      'official': instance.official,
    };

FlagsModel _$FlagsModelFromJson(Map<String, dynamic> json) => FlagsModel(
      png: json['png'] as String?,
      svg: json['svg'] as String?,
      alt: json['alt'] as String?,
    );

Map<String, dynamic> _$FlagsModelToJson(FlagsModel instance) =>
    <String, dynamic>{
      'png': instance.png,
      'svg': instance.svg,
      'alt': instance.alt,
    };

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) =>
    CurrencyModel(
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
    };
