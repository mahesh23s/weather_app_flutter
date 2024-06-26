import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';
import 'package:weatherapp_starter_project/widgets/comfort_level.dart';
import 'package:weatherapp_starter_project/widgets/current_weather_widget.dart';
import 'package:weatherapp_starter_project/widgets/daily_data_forcast.dart';
import 'package:weatherapp_starter_project/widgets/header_widget.dart';
import 'package:weatherapp_starter_project/widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //type of value
        child: Obx(
          () => globalController.checkLoading().isTrue
              ?  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/clouds.png",
                  height: 200,
                  width: 200,
                  ),
                  const CircularProgressIndicator()
                  ],
                ),
                )
              : Center(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children:  [
                      //text align widget
                      const SizedBox(
                        height: 20,
                      ),
                      const Headerwidget(),
                      //for current temp
                      CurrentWeatherWidget(
                        weatherDataCurrent: globalController.getData().getCurrentweather(),
                      ),
                      //text align widget
                      const SizedBox(
                        height: 20,
                      ),
                      HourlyDataWidget(
                        weatherDataHourly: globalController.getData().getHourlyweather()
                        ),
                        DailyDataForcast(weatherDataDaily: globalController.getData().getdDailyweather()
                        ),
                      Container(
                        height: 1,
                        color: CustomColors.dividerLine,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ComfortLevel(weatherDataCurrent: globalController.getData().getCurrentweather()),  
                    ],
                  ),
              ),
        ),
      ),
    );
  }
}
