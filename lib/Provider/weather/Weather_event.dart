part of 'Weather_bloc.dart';

@immutable
abstract class WeatherEvent {}
class LoadedEvent extends WeatherEvent{
  String cities;

  LoadedEvent({required this.cities});
}