import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/domain/reservation/reservation_controller.dart';
import 'package:mypet_reservation/domain/reservation/time.dart';
import 'package:mypet_reservation/util/enum.dart';
import 'package:mypet_reservation/util/text_theme.dart';

class TimeBoxRenew extends StatelessWidget {
  const TimeBoxRenew({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('오전', style: textStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: ReservationControllerReal.to.visible.value
                    ? List.generate(ReservationControllerReal.to.amList.length,
                        (index) => _timeBoxItem(index, TIMETYPE.AM))
                    : List.generate(1, (index) => Container()),
              ),
              SizedBox(height: 30.h),
              Text('오후', style: textStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 14.h),
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: ReservationControllerReal.to.visible.value
                    ? List.generate(ReservationControllerReal.to.pmList.length,
                        (index) => _timeBoxItem(index, TIMETYPE.PM))
                    : List.generate(1, (index) => Container()),
              ),
              SizedBox(height: 15.h),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    color: Colors.grey.shade100,
                  ),
                  SizedBox(width: 6.w),
                  Text('예약 가능', style: textStyle(size: 12.sp)),
                ],
              ),
              SizedBox(width: 16.w),
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    color: Colors.grey.shade500,
                  ),
                  SizedBox(width: 6.w),
                  Text('예약 불가능', style: textStyle(size: 12.sp)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _timeBoxItem(
    int index,
    TIMETYPE type,
  ) {
    RxList<Time> sample;
    if (type == TIMETYPE.AM) {
      sample = ReservationControllerReal.to.amList;
    } else {
      sample = ReservationControllerReal.to.pmList;
    }
    return Obx(() => GestureDetector(
          onTap: () {
            if (sample[index].possible == false) {
              Get.defaultDialog(title: '예약불가능', middleText: '예약 불가능한 시간입니다.');
            } else {
              // index를 받아 PICK의 현재 BOOL값을 역으로 바꿈
              ReservationControllerReal.to.pickItem(index, type);
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: 80.w,
            height: 40.h,
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
