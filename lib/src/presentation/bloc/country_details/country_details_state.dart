part of 'country_details_bloc.dart';

sealed class CountryDetailsState {
  const CountryDetailsState();
}

class CountryDetailsInitial extends CountryDetailsState {
  const CountryDetailsInitial();
}

class CountryDetailsLoading extends CountryDetailsState {
  const CountryDetailsLoading();
}

class CountryDetailsLoaded extends CountryDetailsState {
  final CountryEntity country;

  const CountryDetailsLoaded({required this.country});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryDetailsLoaded &&
          runtimeType == other.runtimeType &&
          country == other.country;

  @override
  int get hashCode => country.hashCode;
}

class CountryDetailsError extends CountryDetailsState {
  final String message;

  const CountryDetailsError({required this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryDetailsError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
