import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scaper/api_helper.dart';
import 'package:sky_scaper/home_controller.dart';
import 'package:sky_scaper/theme_provider.dart';
import 'package:sky_scaper/weathermodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();
  WeatherData? _weatherData;
  bool _isConnected = true;
  bool isvisible = true;

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).checkingConnection();
    _searchWeather('Rajkot');
  }


  void _searchWeather(String cityName) async {
    if (_isConnected) {
      var data = await _apiService.fetchWeather(cityName);
      setState(() {
        _weatherData = data;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No internet connection')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<ThemeProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                child:  value.isDarkMode ?Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMce22gCzSXOW7qivDrsfrW-Cd6DnusGaxmQ&s",fit: BoxFit.cover,):Image.network("https://i.pinimg.com/originals/04/6f/51/046f5145ae962d44679c45198909043a.gif",fit: BoxFit.cover,));
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50,),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    _weatherData != null
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            _weatherData!.name ?? '',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Clouds',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_weatherData!.temperature.current.toStringAsFixed(2)}°',
                              style: TextStyle(fontSize: 80),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildWeatherInfo(
                              Icons.wind_power,
                              '${_weatherData!.wind.speed.toStringAsFixed(2)} km/h',
                            ),
                            _buildWeatherInfo(
                              Icons.water_drop,
                              '${_weatherData!.humidity.toString()} %',
                            ),
                            _buildWeatherInfo(
                              Icons.sunny_snowing,
                              '${_weatherData!.minTemperature.toStringAsFixed(2)} °C',
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildWeatherInfo(
                              Icons.sunny,
                              '${_weatherData!.maxTemperature.toStringAsFixed(2)} °C',
                            ),
                            _buildWeatherInfo(
                              Icons.air,
                              '${_weatherData!.pressure} hPa',
                            ),
                            _buildWeatherInfo(
                              Icons.leaderboard,
                              '${_weatherData!.seaLevel}m',
                            ),
                          ],
                        ),
                      ],
                    )
                        : Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Enter city name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          _searchWeather(value);
                          _controller.clear();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a city name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return IconButton(
                          icon: Icon(
                            themeProvider.isDarkMode
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                          ),
                          onPressed: () {
                            themeProvider.toggleTheme();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
        ),
        SizedBox(height: 5),
        Text(text),
      ],
    );
  }

}