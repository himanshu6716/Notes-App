import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/View/splash_screen.dart';

import 'Provider/notes/Notes_bloc.dart';
import 'Provider/weather/Weather_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesBloc>(create: (_) => NotesBloc()),
        BlocProvider<WeatherBloc>(create: (_) => WeatherBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
          ),
          home: SplashScreen()
      ),
    );
  }
}