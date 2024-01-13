import 'dart:math';

import 'package:weather/domain/i_weather_repo.dart';
import 'package:weather/domain/weather.dart';
import 'package:weather/infrastructure/network_exception.dart';

class WeatherRepositoryImpl extends IWeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(const Duration(seconds: 1), () {
      final random = Random();

      if (random.nextBool()) {
        throw NetworkException();
      }

      return Weather(
        cityName: cityName,
        tempratureC: 20 + random.nextInt(50) + random.nextDouble(),
      );
    });
  }
}
