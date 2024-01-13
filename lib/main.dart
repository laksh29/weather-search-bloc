import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/cubit/weather_cubit.dart';
import 'package:weather/infrastructure/weather_repo_impl.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather BLoC',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: BlocProvider(
          create: (context) => WeatherCubit(WeatherRepositoryImpl()),
          child: const HomePage()),
    );
  }
}
