import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/controller/point_controller.dart';
import 'package:mypet_reservation/controller/reservation_controller.dart';
import 'package:mypet_reservation/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(ReservationController());
        Get.put(PointController());
      }),
      home: const HomePage(),
    );
  }
}
