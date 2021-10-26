import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/domain/point.dart';
import 'package:mypet_reservation/util/text_theme.dart';

class PointList extends StatelessWidget {
  const PointList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pointController = Get.find();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(
          () => ListView.separated(
            shrinkWrap: true,
            // 날짜 기준 데이터 가져오기
            itemBuilder: (context, index) {
              return Obx(
                  () => dateListItem(pointController.pointFilterList[index]));
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 19,
                thickness: 1,
                color: Color(0xfff6f6f6),
              );
            },
            itemCount: pointController.pointFilterList.length,
          ),
        ),
      ),
    );
  }

  Widget dateListItem(Point pointFilterList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(pointFilterList.date, style: textStyle(size: 15))),
        Expanded(
          flex: 5,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // List.generate(length, (index) => null) 로 바꿔 같은 날짜의 데이터 뽑기
            children: List.generate(pointFilterList.pointUsage.length,
                (index) => detailListItem(pointFilterList.pointUsage[index])),
          ),
        ),
      ],
    );
  }

  Widget detailListItem(PointUsage pointUsage) {
    var pointTypeTr = <POINTTYPE, String>{
      POINTTYPE.RESERVATION: '예약 적립',
      POINTTYPE.BOUNS: '보너스 적립',
      POINTTYPE.PURCHASE: '구매 적립',
      POINTTYPE.USEPOINT: '결제 시 사용',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(pointTypeTr[pointUsage.pointType].toString(),
                style: textStyle(size: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                SvgPicture.asset('assets/icons/icon_star.svg',
                    width: 12,
                    height: 12,
                    color: pointUsage.pointType == POINTTYPE.USEPOINT
                        ? Colors.grey
                        : Colors.black),
                const SizedBox(width: 4),
                Text(
                  pointUsage.usePoint,
                  style: textStyle(
                      size: 15,
                      fontWeight: FontWeight.bold,
                      color: pointUsage.pointType == POINTTYPE.USEPOINT
                          ? Colors.grey
                          : Colors.black),
                ),
              ],
            )
          ],
        ),
        Text(pointUsage.address, style: textStyle(size: 13, opacity: 0.38)),
        const SizedBox(height: 15),
      ],
    );
  }
}
