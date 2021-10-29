import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/domain/reservation/reservation_controller.dart';
import 'package:mypet_reservation/util/text_theme.dart';
import 'package:mypet_reservation/view/reservation2/time_box_renew.dart';

class ReservationRenew extends StatelessWidget {
  const ReservationRenew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 720),
      builder: () => Scaffold(
        appBar: AppBar(
          leading: SizedBox(
            width: 24.w,
            height: 24.h,
            child: IconButton(
              icon: const Icon(
                CupertinoIcons.chevron_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          titleSpacing: 0.0,
          title: Text(
            '참사랑 동물병원',
            style: textStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _datePicker(context),
                      _divider(),
                      _timePicker(),
                      _divider(),
                      Obx(
                        () => IgnorePointer(
                          ignoring: !ReservationControllerReal.to.visible.value,
                          child: AnimatedOpacity(
                            opacity: ReservationControllerReal.to.visible.value
                                ? 1.0
                                : 0.0,
                            duration: const Duration(milliseconds: 100),
                            child: TimeBoxRenew(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _bottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        textStyle: TextStyle(fontSize: 20.sp),
        minimumSize: Size(double.infinity, 50.h),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: () {
        // Reservation reservation = ReservationController.to.confirmReservation();
      },
      child: Text(
        '입력완료',
        style: textStyle(color: Colors.white, opacity: 1),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      thickness: 1.h,
      color: Colors.grey,
    );
  }

  Widget _timePicker() {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 19.h,
                width: 19.w,
                child: SvgPicture.asset(
                  'assets/icons/icon_timer.svg',
                ),
              ),
              SizedBox(width: 15.w),
              Obx(() => Text(ReservationControllerReal.to.pickTime.value,
                  style: textStyle())),
            ],
          ),
          GestureDetector(
              onTap: () {
                ReservationControllerReal.to.dropdownToggle();
              },
              child: Obx(
                () => SizedBox(
                  width: 19.w,
                  height: 19.h,
                  child: Icon(
                    ReservationControllerReal.to.visible.value
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _datePicker(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 19.h,
                width: 19.w,
                child: SvgPicture.asset(
                  'assets/icons/icon_calendar.svg',
                ),
              ),
              SizedBox(width: 15.w),
              Obx(() => Text(ReservationControllerReal.to.calendarDate.value,
                  style: textStyle())),
            ],
          ),
          GestureDetector(
            onTap: () {
              ReservationControllerReal.to.datePicker(context);
            },
            child: SizedBox(
              width: 19.w,
              height: 19.h,
              child: const Icon(
                CupertinoIcons.chevron_down,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
