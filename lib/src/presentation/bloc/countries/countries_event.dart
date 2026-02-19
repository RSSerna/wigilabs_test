part of 'countries_bloc.dart';

sealed class CountriesEvent {
  const CountriesEvent();
}

class FetchCountriesEvent extends CountriesEvent {
  const FetchCountriesEvent();
}
