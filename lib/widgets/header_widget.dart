import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';

class Headerwidget extends StatefulWidget {
  const Headerwidget({Key? key}) : super(key: key);
  @override
  State<Headerwidget> createState() => _HeaderwidgetState();
}

class _HeaderwidgetState extends State<Headerwidget> {
//create local variable
  String city = "";

  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  //create function
  void initState() {
    getAddress(globalController.getlattitude().value,
        globalController.getlongtitude().value);
    super.initState();
  }

  //add the geocoding function
  getAddress(lat, lon) async {
    List<Placemark> Placemarks = await placemarkFromCoordinates(lat, lon);
    //print(Placemarks);
    //api call
    Placemark place = Placemarks[0];
    setState(() {
      //add locality not getting current location used country code
      city = place.country!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(fontSize: 30, height: 2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style:
                const TextStyle(fontSize: 15, color: Colors.grey, height: 1.5),
          ),
        ),
      ],
    );
  }
}
