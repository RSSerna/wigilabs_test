part of 'countries_bloc.dart';

sealed class CountriesState {
  const CountriesState();
}

class CountriesInitial extends CountriesState {
  const CountriesInitial();
}

class CountriesLoading extends CountriesState {
  const CountriesLoading();
}

class CountriesLoaded extends CountriesState {
  final List<CountryEntity> countries;

  const CountriesLoaded({required this.countries});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountriesLoaded &&
          runtimeType == other.runtimeType &&
          countries == other.countries;

  @override
  int get hashCode => countries.hashCode;
}

class CountriesError extends CountriesState {
  final String message;

  const CountriesError({required this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountriesError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
