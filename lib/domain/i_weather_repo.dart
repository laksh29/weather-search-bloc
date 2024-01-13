import 'weather.dart';

abstract class IWeatherRepository {
  Future<Weather> fetchWeather(String cityName);
}
