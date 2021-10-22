import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/controller/reservation_controller.dart';
import 'package:mypet_reservation/domain/time.dart';
import 'package:mypet_reservation/util/enum.dart';
import 'package:mypet_reservation/util/text_theme.dart';

class TimeBox extends StatelessWidget {
  ReservationController reservationController = Get.find();
  TimeBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('오전', style: textStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: List.generate(reservationController.sampleAm.length,
              (index) => _timeBoxItem(index, TIMETYPE.AM)),
        ),
        const SizedBox(height: 30),
        Text('오후', style: textStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: List.generate(reservationController.samplePm.length,
              (index) => _timeBoxItem(index, TIMETYPE.PM)),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  color: Colors.grey.shade100,
                ),
                const SizedBox(width: 6),
                Text('예약 가능', style: textStyle(size: 12.0)),
              ],
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Text('예약 불가능', style: textStyle(size: 12.0)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _timeBoxItem(
    int index,
    TIMETYPE type,
  ) {
    RxList<Time> sample;
    if (type == TIMETYPE.AM) {
      sample = reservationController.sampleAm;
    } else {
      sample = reservationController.samplePm;
    }
    return Obx(() => GestureDetector(
          onTap: () {
            // index를 받아 PICK의 현재 BOOL값을 역으로 바꿈
            reservationController.pickItem(index, type);
          },
          child: Container(
            alignment: Alignment.center,
            width: 85,
            height: 40,
            decoration: BoxDecoration(
              color: sample[index].possible
                  ? sample[index].pick
                      ? Colors.black
                      : Colors.grey.shade100
                  : Colors.grey.shade500,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(sample[index].time,
                style: sample[index].pick
                    ? textStyle(color: Colors.white)
                    : textStyle()),
          ),
        ));
  }
}
