import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/api/fetch_weather.dart';
//import 'package:weatherapp_starter_project/model/weather/current.dart';
import 'package:weatherapp_starter_project/model/weather_data.dart';

class GlobalController extends GetxController {
  //create a values
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longtitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  //instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getlattitude() => _lattitude;
  RxDouble getlongtitude() => _longtitude;

  final weatherData = WeatherData().obs;
  
  WeatherData getData(){
    return weatherData.value;
  }
  @override
  //function to be called
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    }else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //return isServiceEnabled
    if (!isServiceEnabled) {
      return Future.error("Location service is not enabled");
    }
    //status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      //request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }
    //gettind a current location
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //update longitude and latitude
      _lattitude.value = value.latitude;
      _longtitude.value = value.longitude;

      return FetchWeatherAPI().processData(value.latitude, value.longitude)
      .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }
  //select particular position color from hourly weather data
  RxInt getIndex(){
    return _currentIndex;
  }
}
