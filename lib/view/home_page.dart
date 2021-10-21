import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/controller/reservation_controller.dart';
import 'package:mypet_reservation/util/text_theme.dart';

import 'components/time_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              CupertinoIcons.chevron_back,
              size: 24,
              color: Colors.black,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              '참사랑 동물병원',
              style: textStyle(),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
            child: SizedBox(), preferredSize: Size.fromHeight(10)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _datePick(
                      const Icon(
                        CupertinoIcons.calendar,
                        size: 19,
                      ),
                      context,
                    ),
                    _divider(),
                    _datePick(
                      const Icon(
                        CupertinoIcons.calendar,
                        size: 19,
                      ),
                      context,
                    ),
                    _divider(),
                    const SizedBox(height: 40),
                    TimeBox(),
                  ],
                ),
              ],
            ),
          ),
          _bottomButton(),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: () {},
      child: Text(
        '입력완료',
        style: textStyle(color: Colors.white, opacity: 1),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  Widget _datePick(Icon icon, BuildContext context) {
    ReservationController reservationController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              const SizedBox(width: 15),
              Text('9.23(목)', style: textStyle()),
            ],
          ),
          GestureDetector(
            onTap: () {
              reservationController.datePicker(context);
            },
            child: const Icon(
              CupertinoIcons.chevron_down,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }
}
