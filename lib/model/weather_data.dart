import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'package:weatherapp_starter_project/model/weather_data_daily.dart';
import 'package:weatherapp_starter_project/model/weather_data_hourly.dart';

class WeatherData{

  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily?daily;
 //not null value use required value
  WeatherData([this.current, this.hourly, this.daily]);

 //functio fetch these values
 WeatherDataCurrent getCurrentweather() => current!;
 WeatherDataHourly getHourlyweather() => hourly!;
 WeatherDataDaily getdDailyweather() => daily!;
   }
