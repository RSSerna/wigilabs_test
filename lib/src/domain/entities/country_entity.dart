class CountryEntity {
  final String name;
  final String code;
  final String region;
  final String flagUrl;
  final String capital;
  final String? population;
  final String? area;
  final List<String>? languages;
  final List<String>? currencies;

  const CountryEntity({
    required this.name,
    required this.code,
    required this.region,
    required this.flagUrl,
    required this.capital,
    this.population,
    this.area,
    this.languages,
    this.currencies,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code;

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}
