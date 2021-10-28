import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/domain/reservation/reservation_controller.dart';
import 'package:mypet_reservation/view/point/point_page.dart';
import 'package:mypet_reservation/view/reservation/reservation_list_page.dart';
import 'package:mypet_reservation/view/reservation/reservation_page.dart';
import 'package:mypet_reservation/view/reservation2/reservation_renew.dart';

import 'calendar/basics_example.dart';
import 'calendar/complex_example.dart';
import 'calendar/events_example.dart';
import 'calendar/multi_example.dart';
import 'calendar/range_example.dart';

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
                  Get.to(() => const ReservationRenew());
                },
                child: const Text('예약리뉴페이지')),
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
            // const ExpansionPanelItem(),
            TextButton(
                onPressed: () {
                  ReservationControllerReal.to.getMonthData();
                },
                child: const Text('데이터 테스트')),
            TextButton(
                onPressed: () {
                  Get.to(() => TableRangeExample());
                },
                child: const Text('TableRangeExample')),
            TextButton(
                onPressed: () {
                  Get.to(() => TableMultiExample());
                },
                child: const Text('TableMultiExample')),
            TextButton(
                onPressed: () {
                  Get.to(() => TableEventsExample());
                },
                child: const Text('TableEventsExample')),
            TextButton(
                onPressed: () {
                  Get.to(() => TableComplexExample());
                },
                child: const Text('TableComplexExample')),
            TextButton(
                onPressed: () {
                  Get.to(() => TableBasicsExample());
                },
                child: const Text('TableBasicsExample')),
          ],
        ));
  }
}
