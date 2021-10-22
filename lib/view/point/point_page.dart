import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/controller/point_controller.dart';
import 'package:mypet_reservation/util/text_theme.dart';

class PointPage extends StatelessWidget {
  PointPage({Key? key}) : super(key: key);
  PointController pointController = Get.find();

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
            child: SizedBox(), preferredSize: Size.fromHeight(10)),
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
                  value: pointController.dropdownValue.value,
                  icon: const Icon(CupertinoIcons.chevron_down),
                  iconSize: 18,
                  style: textStyle(fontWeight: FontWeight.bold, size: 15.0),
                  onChanged: (String? newValue) {
                    pointController.dropdownValue.value = newValue!;
                  },
                  underline: DropdownButtonHideUnderline(child: Container()),
                  items: <String>['전체내역', '적립내역', '사용내역']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('9.15', style: textStyle(size: 15)),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('예약적립',
                                        style: textStyle(
                                            size: 16,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/icon_star.svg',
                                            width: 12,
                                            height: 12),
                                        Text(
                                          '1',
                                          style: textStyle(
                                              size: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text('더건강한펫케어',
                                    style: textStyle(size: 13, opacity: 0.38)),
                                const SizedBox(height: 15),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('예약적립',
                                    style: textStyle(
                                        size: 16, fontWeight: FontWeight.bold)),
                                Text('더건강한펫케어',
                                    style: textStyle(size: 13, opacity: 0.38)),
                                const SizedBox(height: 15),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 19,
                    thickness: 1,
                    color: Color(0xfff6f6f6),
                  );
                },
                itemCount: 5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
