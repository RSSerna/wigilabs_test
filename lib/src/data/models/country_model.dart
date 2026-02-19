import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  @JsonKey(name: 'name')
  final CountryNameModel? name;

  @JsonKey(name: 'cca2')
  final String? cca2;

  @JsonKey(name: 'ccn3')
  final String? ccn3;

  @JsonKey(name: 'region')
  final String? region;

  @JsonKey(name: 'capital')
  final List<String>? capital;

  @JsonKey(name: 'flags')
  final FlagsModel? flags;

  @JsonKey(name: 'population')
  final int? population;

  @JsonKey(name: 'area')
  final double? area;

  @JsonKey(name: 'languages')
  final Map<String, String>? languages;

  @JsonKey(name: 'currencies')
  final Map<String, CurrencyModel>? currencies;

  CountryModel({
    this.name,
    this.cca2,
    this.ccn3,
    this.region,
    this.capital,
    this.flags,
    this.population,
    this.area,
    this.languages,
    this.currencies,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}

@JsonSerializable()
class CountryNameModel {
  @JsonKey(name: 'common')
  final String? common;

  @JsonKey(name: 'official')
  final String? official;

  CountryNameModel({
    this.common,
    this.official,
  });

  factory CountryNameModel.fromJson(Map<String, dynamic> json) =>
      _$CountryNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryNameModelToJson(this);
}

@JsonSerializable()
class FlagsModel {
  @JsonKey(name: 'png')
  final String? png;

  @JsonKey(name: 'svg')
  final String? svg;

  @JsonKey(name: 'alt')
  final String? alt;

  FlagsModel({
    this.png,
    this.svg,
    this.alt,
  });

  factory FlagsModel.fromJson(Map<String, dynamic> json) =>
      _$FlagsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlagsModelToJson(this);
}

@JsonSerializable()
class CurrencyModel {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'symbol')
  final String? symbol;

  CurrencyModel({
    this.name,
    this.symbol,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);
}
