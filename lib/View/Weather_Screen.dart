import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Provider/weather/Weather_bloc.dart';
import 'package:notes_app/utils/Colors.dart';
import 'package:notes_app/utils/widgets/Custon_dropdown.dart';

class WeatherReport extends StatefulWidget {
  const WeatherReport({Key? key}) : super(key: key);

  @override
  State<WeatherReport> createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  late WeatherBloc _weatherBloc;
  late String selectedCity;
  List<String> cities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Hyderabad',
    'Ahmedabad',
    'Chennai',
    'Kolkata',
    'Surat',
    'Pune',
    'Jaipur',
    // Add more city names as needed
  ];

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _weatherBloc..add(
        LoadedEvent(cities: 'Noida'
        ));
   _selectCities();
  }
  Future<void> _selectCities() async {
    if(selectedCity.isEmpty){
      BlocProvider.of<WeatherBloc>(context).add(
          LoadedEvent(cities: 'Noida')
      );
    } else {
      BlocProvider.of<WeatherBloc>(context).add(
          LoadedEvent(cities: selectedCity)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: CustomColors.black),
        backgroundColor: CustomColors.white,
        title: const Text(
          "Today's Weather",
          style: TextStyle(color: CustomColors.black),
        ),
      ),
      body: Column(
        children: [
          CustomDropdown(
            isExpanded: true,
            options: cities,
            selectedIndex: -1, // Initially no city is selected
            onIndexSelected: _onCitySelected,
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherSuccess) {
                Map<String, dynamic> data = state.weatherData;
                return _buildWeatherUI(data);
              } else if(state  is WeatherError) {
                return const Center(
                  child: Text('Failed to load weather data'),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  void _onCitySelected(int index) {
    setState(() {
      selectedCity = cities[index];
    });
    _selectCities();
  }
  Widget _buildWeatherUI(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Location: ${data['name']}',
            style: const TextStyle(fontSize: 20, color: CustomColors.black),
          ),
          const SizedBox(height: 10),
          Text(
            'Temperature: ${data['main']['temp']}°C',
            style: const TextStyle(fontSize: 20, color: CustomColors.black),
          ),
          const SizedBox(height: 10),
          Text(
            'Description: ${data['weather'][0]['description']}',
            style: const TextStyle(fontSize: 20, color: CustomColors.black),
          ),
          const SizedBox(height: 10),
          Text(
            'Humidity: ${data['main']['humidity']}%',
            style: const TextStyle(fontSize: 20, color: CustomColors.black),
          ),
          const SizedBox(height: 10),
          Text(
            'Wind Speed: ${data['wind']['speed']} m/s',
            style: const TextStyle(fontSize: 20, color: CustomColors.black),
          ),
        ],
      ),
    );
  }
}
