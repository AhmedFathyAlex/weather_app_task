
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_task/weather_controller.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());
  final TextEditingController cityController = TextEditingController();

  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter city name',
              ),
              onSubmitted: (value) => weatherController.fetchWeather(value),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => weatherController.fetchWeather(cityController.text),
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (weatherController.isLoading.value) {
                return const CircularProgressIndicator();
              }
              if (weatherController.errorMessage.value.isNotEmpty) {
                return Text(weatherController.errorMessage.value, style: const TextStyle(color: Colors.red));
              }
              if (weatherController.weather.value.cityName.isEmpty) {
                return Container();
              }
              return Column(
                children: [
                  Text(
                    weatherController.weather.value.cityName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${weatherController.weather.value.temperature}°C',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(weatherController.weather.value.description),
                  Image.network(
                    'http://openweathermap.org/img/w/${weatherController.weather.value.icon}.png',
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}