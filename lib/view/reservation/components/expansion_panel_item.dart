import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/controller/reservation_controller.dart';
import 'package:mypet_reservation/util/text_theme.dart';
import 'package:mypet_reservation/view/reservation/components/time_box.dart';

class ExpansionPanelItem extends GetView<ReservationController> {
  const ExpansionPanelItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpansionPanelList(
        expandedHeaderPadding: const EdgeInsets.all(0),
        elevation: 0.0,
        children: [
          ExpansionPanel(
            backgroundColor: Colors.white,
            headerBuilder: (context, isExpanded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_timer.svg',
                    height: 19,
                    width: 19,
                  ),
                  const SizedBox(width: 15),
                  Obx(() =>
                      Text(controller.pickTime.value, style: textStyle())),
                ],
              );
            },
            body: TimeBox(),
            isExpanded: controller.visible.value,
            canTapOnHeader: true,
          ),
        ],
        expansionCallback: (panelIndex, isExpanded) {
          controller.dropdownToggle();
        },
      ),
    );
  }
}
