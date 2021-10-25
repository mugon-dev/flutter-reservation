import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mypet_reservation/controller/reservation_controller.dart';
import 'package:mypet_reservation/util/text_theme.dart';
import 'package:mypet_reservation/view/reservation/reservation_list_page.dart';

import 'components/time_box.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.chevron_back,
            size: 24,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: 0.0,
        title: Text(
          '참사랑 동물병원',
          style: textStyle(fontWeight: FontWeight.bold),
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
                        const Icon(CupertinoIcons.calendar, size: 19), context),
                    _divider(),
                    _timePick(const Icon(CupertinoIcons.calendar, size: 19)),
                    _divider(),
                    const SizedBox(height: 40),
                    Obx(
                      () => IgnorePointer(
                        ignoring: !ReservationController.to.visible.value,
                        child: AnimatedOpacity(
                          opacity: ReservationController.to.visible.value
                              ? 1.0
                              : 0.0,
                          duration: const Duration(milliseconds: 100),
                          child: TimeBox(),
                        ),
                      ),
                    ),
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
      onPressed: () {
        // Reservation reservation = ReservationController.to.confirmReservation();
        Get.to(const ReservationListPage());
      },
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

  Widget _timePick(Icon icon) {
    ReservationController reservationController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icons/icon_timer.svg',
                height: 19,
                width: 19,
              ),
              const SizedBox(width: 15),
              Obx(() => Text(reservationController.pickTime.value,
                  style: textStyle())),
            ],
          ),
          GestureDetector(
              onTap: () {
                reservationController.dropdownToggle();
              },
              child: Obx(
                () => Icon(
                  reservationController.visible.value
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  size: 19,
                ),
              )),
        ],
      ),
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
              SvgPicture.asset(
                'assets/icons/icon_calendar.svg',
                height: 19,
                width: 19,
              ),
              const SizedBox(width: 15),
              Obx(() =>
                  Text(reservationController.date.value, style: textStyle())),
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
