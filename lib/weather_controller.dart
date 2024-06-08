import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'weather_model.dart';

class WeatherController extends GetxController {
  var weather = Weather(cityName: '', temperature: 0, description: '', icon: '').obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final String apiKey = 'ba1ee3497e7329985e7153b6a47b8be4'; 
  
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Dio dio = Dio();

  Future<void> fetchWeather(String cityName) async {
    isLoading(true);
    errorMessage('');
    try {
      final response = await dio.get(apiUrl, queryParameters: {
        'q': cityName,
        'units': 'metric',
        'appid': apiKey,
      });
      if (response.statusCode == 200) {
        weather.value = Weather.fromJson(response.data);
      } else {
        errorMessage('City not found');
      }
    } catch (e) {
      errorMessage('Failed to fetch weather data');
    } finally {
      isLoading(false);
    }
  }
}
