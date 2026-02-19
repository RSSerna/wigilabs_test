part of 'country_details_bloc.dart';

sealed class CountryDetailsEvent {
  const CountryDetailsEvent();
}

class FetchCountryDetailsEvent extends CountryDetailsEvent {
  final String countryName;

  const FetchCountryDetailsEvent({required this.countryName});
}
