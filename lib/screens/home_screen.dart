import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/cubit/weather_cubit.dart';

import '../domain/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityName = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _cityName.dispose();
  }

  void submitCityName(BuildContext context, String cityName) {
    log(cityName);
    final weatherCubit = context.read<WeatherCubit>();
    weatherCubit.getWeather(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
          if (state is WeatherError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        }, builder: (context, state) {
          if (state is WeatherInitial) {
            log("initial state");
            return buildInitialInput();
          } else if (state is WeatherLoading) {
            log("Loading state");
            return buildLoading();
          } else if (state is WeatherLoaded) {
            log("Loaded state");
            return buildLoaded(state.weather);
          } else {
            log("Error State");
            return buildInitialInput();
          }
        }),
      ),
    );
  }

  Widget buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget buildInitialInput() => Center(
        child: cityInputField(),
      );

  Container cityInputField() {
    return Container(
      height: 50,
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: TextFormField(
        controller: _cityName,
        decoration: InputDecoration(
            suffixIcon: IconButton(
          onPressed: () => submitCityName(context, _cityName.text),
          icon: Icon(Icons.search),
        )),
      ),
    );
  }

  Widget buildLoaded(Weather weather) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(weather.cityName),
            SizedBox(height: 20),
            Text(weather.tempratureC.toString()),
            SizedBox(height: 80),
            cityInputField(),
          ],
        ),
      );
}
