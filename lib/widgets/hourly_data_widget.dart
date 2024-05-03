import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/model/weather_data_hourly.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';
 
 // ignore: must_be_immutable
 class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
   HourlyDataWidget({Key? key, required this.weatherDataHourly}) : super(key: key);

  //card index
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
          alignment: Alignment.center,
          child: const Text("Today", style: TextStyle(fontSize: 18)), 
        ),
        hourlyList(),
      ],
    );
  }
  Widget hourlyList(){
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        //more data like oneweek are more
        itemCount: weatherDataHourly.hourly.length > 12 ? 24:weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx((() =>  GestureDetector(
            onTap: () {
              cardIndex.value = index;
            },
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(left: 20,right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0.5, 0),
                  blurRadius: 30,
                  spreadRadius: 1,
                  color: CustomColors.dividerLine.withAlpha(150))
              ],
              //click color change from obx
              gradient: cardIndex.value == index? const LinearGradient(colors: [
                CustomColors.firstGradientColor,
                CustomColors.secondGradientColor,
              ])
             : null),
             child: HourlyDetails(
              index: index,
              cardIndex: cardIndex.toInt(),
              temp: weatherDataHourly.hourly[index].temp!,
              timestamp: weatherDataHourly.hourly[index].dt!,
              weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
             ),
          ))
          ));
        },
        ),
    );
  }
}
//hourly detail class
// ignore: must_be_immutable
class HourlyDetails extends StatelessWidget{
  int temp;
  int index;//time color change function
  int cardIndex;//time color change function
  int timestamp;
  String weatherIcon;

  HourlyDetails({Key? key, 
  required this.index,
  required this.cardIndex,
  required this.timestamp, 
  required this.temp, 
  required this.weatherIcon});

String getTime(final timestamp){
    //convert milliseconds
   DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);// time duration using * 1000
    String x = DateFormat('jm').format(time);//117 line
   return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(getTime(timestamp),
          style: TextStyle(
            color: cardIndex == index ? Colors.white: CustomColors.textColorBlack,)),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset("assets/weather/$weatherIcon.png",
          height: 40,
          width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp°С",
          style: TextStyle(
            color: cardIndex == index ? Colors.white: CustomColors.textColorBlack,)),
        )
      ],
    );
  }
}