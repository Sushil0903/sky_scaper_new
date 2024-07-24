import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sky_scaper/weathermodel.dart';

class ApiService {
  Future<WeatherData?> fetchWeather(String cityName) async {
    final response = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=5664ce1fe43335490a274cdc890bd519",
      ),
    );

    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception("Weather API data not found");
      }
    } catch (e) {
      print("Weather API Error: ${e.toString()}");
      return null;
    }
  }
}