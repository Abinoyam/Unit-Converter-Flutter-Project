import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const RestApiExperimentApp());

class RestApiExperimentApp extends StatelessWidget {
  const RestApiExperimentApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Experiment 09 - REST API',
        theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
        home: const ApiHomePage(),
      );
}

class WeatherData {
  final double temperature;
  final int windSpeed;
  final int weatherCode;

  const WeatherData({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        temperature: (json['current']['temperature_2m'] as num).toDouble(),
        windSpeed: (json['current']['wind_speed_10m'] as num).round(),
        weatherCode: (json['current']['weather_code'] as num).toInt(),
      );
}

class WeatherService {
  Future<WeatherData> fetchWeather() async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '17.3850',
      'longitude': '78.4867',
      'current': 'temperature_2m,wind_speed_10m,weather_code',
    });
    final response = await http.get(uri).timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw Exception('Server returned status ${response.statusCode}');
    }
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherData.fromJson(decoded);
  }
}

class ApiHomePage extends StatefulWidget {
  const ApiHomePage({super.key});

  @override
  State<ApiHomePage> createState() => _ApiHomePageState();
}

class _ApiHomePageState extends State<ApiHomePage> {
  final _service = WeatherService();
  WeatherData? _weather;
  bool _loading = false;
  String? _error;

  Future<void> _loadWeather() async {
    setState(() { _loading = true; _error = null; });
    try {
      final data = await _service.fetchWeather();
      if (!mounted) return;
      setState(() => _weather = data);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Could not load data. Check internet and try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Experiment 09: REST API')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _loading
                ? const Column(mainAxisSize: MainAxisSize.min, children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Fetching live weather from REST API...'),
                  ])
                : _error != null
                    ? Column(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.cloud_off, size: 56),
                        const SizedBox(height: 12),
                        Text(_error!, textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        FilledButton(onPressed: _loadWeather, child: const Text('Try Again')),
                      ])
                    : _weather == null
                        ? FilledButton(onPressed: _loadWeather, child: const Text('Load Weather'))
                        : Card(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(mainAxisSize: MainAxisSize.min, children: [
                                const Icon(Icons.wb_sunny_outlined, size: 64),
                                const SizedBox(height: 8),
                                const Text('Hyderabad, India', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 18),
                                Text('${_weather!.temperature.toStringAsFixed(1)} °C',
                                    style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                                Text('Wind speed: ${_weather!.windSpeed} km/h'),
                                Text('Weather code: ${_weather!.weatherCode}'),
                                const SizedBox(height: 16),
                                OutlinedButton.icon(
                                  onPressed: _loadWeather,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Refresh data'),
                                ),
                                const SizedBox(height: 8),
                                const Text('Data provided by Open-Meteo API', textAlign: TextAlign.center),
                              ]),
                            ),
                          ),
          ),
        ),
      );
}
