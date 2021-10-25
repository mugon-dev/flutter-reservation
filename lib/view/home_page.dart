import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/view/point/point_page.dart';
import 'package:mypet_reservation/view/reservation/components/expansion_panel_item.dart';
import 'package:mypet_reservation/view/reservation/reservation_list_page.dart';
import 'package:mypet_reservation/view/reservation/reservation_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('메인'),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () {
                  Get.to(() => const ReservationPage());
                },
                child: const Text('예약페이지')),
            TextButton(
                onPressed: () {
                  Get.to(() => const ReservationListPage());
                },
                child: const Text('예약리스트페이지')),
            TextButton(
                onPressed: () {
                  Get.to(() => PointPage());
                },
                child: const Text('포인트')),
            const ExpansionPanelItem(),
          ],
        ));
  }
}
