import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_test/src/domain/entities/country_entity.dart';
import 'package:wigilabs_test/src/domain/usecases/countries_usecase.dart';

part 'country_details_event.dart';
part 'country_details_state.dart';

class CountryDetailsBloc
    extends Bloc<CountryDetailsEvent, CountryDetailsState> {
  final GetCountryByNameUsecase getCountryByNameUsecase;

  CountryDetailsBloc({
    required this.getCountryByNameUsecase,
  }) : super(const CountryDetailsInitial()) {
    on<FetchCountryDetailsEvent>(_onFetchCountryDetails);
  }

  Future<void> _onFetchCountryDetails(
    FetchCountryDetailsEvent event,
    Emitter<CountryDetailsState> emit,
  ) async {
    emit(const CountryDetailsLoading());
    try {
      final country = await getCountryByNameUsecase(event.countryName);
      if (country != null) {
        emit(CountryDetailsLoaded(country: country));
      } else {
        emit(const CountryDetailsError(message: 'Country not found'));
      }
    } catch (e) {
      emit(CountryDetailsError(message: e.toString()));
    }
  }
}
