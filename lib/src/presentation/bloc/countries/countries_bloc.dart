import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_test/src/domain/entities/country_entity.dart';
import 'package:wigilabs_test/src/domain/usecases/countries_usecase.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final GetEuropeanCountriesUsecase getEuropeanCountriesUsecase;

  CountriesBloc({
    required this.getEuropeanCountriesUsecase,
  }) : super(const CountriesInitial()) {
    on<FetchCountriesEvent>(_onFetchCountries);
  }

  Future<void> _onFetchCountries(
    FetchCountriesEvent event,
    Emitter<CountriesState> emit,
  ) async {
    emit(const CountriesLoading());
    try {
      final countries = await getEuropeanCountriesUsecase();
      emit(CountriesLoaded(countries: countries));
    } catch (e) {
      emit(CountriesError(message: e.toString()));
    }
  }
}
