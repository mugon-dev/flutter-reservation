import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/controller/point_controller.dart';
import 'package:mypet_reservation/domain/point.dart';
import 'package:mypet_reservation/util/text_theme.dart';

import 'components/point_list.dart';

class PointPage extends StatelessWidget {
  PointPage({Key? key}) : super(key: key);
  final List<String> filter = ['전체내역', '적립내역', '사용내역'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/icon_close.svg',
              width: 24, height: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: 0.0,
        title: Text(
          '포인트',
          style: textStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10), child: SizedBox()),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: '마이펫',
                    style: textStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: '님의 보유 포인트', style: textStyle()),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon_star.svg',
                      color: Colors.grey,
                      width: 27,
                      height: 27,
                    ),
                    const SizedBox(width: 10),
                    RichText(
                      text: TextSpan(
                        text: '1,200',
                        style:
                            textStyle(fontWeight: FontWeight.bold, size: 32.0),
                        children: [
                          TextSpan(text: '개', style: textStyle(size: 24.0)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            height: 50,
            thickness: 10,
            color: Color(0xfff6f6f6),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Obx(() => DropdownButton<String>(
                  value: PointController.to.dropdownValue.value,
                  icon: const Icon(CupertinoIcons.chevron_down),
                  iconSize: 18,
                  style: textStyle(fontWeight: FontWeight.bold, size: 15.0),
                  onChanged: (String? newValue) {
                    PointController.to.dropdownValue.value = newValue!;
                    switch (filter.indexOf(newValue)) {
                      case 0:
                        PointController.to
                            .filterPointList(POINTFILTERTYPE.WHOLE);
                        break;
                      case 1:
                        PointController.to
                            .filterPointList(POINTFILTERTYPE.SAVE);
                        break;
                      case 2:
                        PointController.to.filterPointList(POINTFILTERTYPE.USE);
                        break;
                    }
                  },
                  underline: DropdownButtonHideUnderline(child: Container()),
                  items: filter.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ),
          const PointList()
        ],
      ),
    );
  }
}
