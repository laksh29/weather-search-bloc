import 'package:bloc/bloc.dart';
import 'package:weather/domain/i_weather_repo.dart';
import 'package:weather/domain/weather.dart';
import 'package:weather/infrastructure/network_exception.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final IWeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(const WeatherLoading());
      final result = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather: result));
    } on NetworkException {
      emit(const WeatherError(
          errorMessage: "Couldn't fetch weather. Is the device online?"));
    }
  }
}
