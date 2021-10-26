import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypet_reservation/util/enum.dart';
import 'package:mypet_reservation/util/text_theme.dart';

class ReservationListCard extends StatelessWidget {
  final CARDTYPE cardtype;
  final bool visitToggle;
  final String hospital;
  final String date;
  final String time;
  const ReservationListCard({
    Key? key,
    required this.cardtype,
    required this.visitToggle,
    required this.hospital,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var visit = visitToggle ? '방문완료' : '방문예정';
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 16),
      child: Container(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 10),
        alignment: Alignment.centerLeft,
        width: 328,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hospital,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle(
                        color: Colors.black,
                        size: 16.0,
                        fontWeight: FontWeight.bold)),
                Text(visit,
                    style: textStyle(
                        color: visitToggle ? Colors.black : Colors.grey,
                        size: 13.0,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                Text('예약날짜',
                    style: textStyle(size: 13.0, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Text(date,
                    style: textStyle(fontWeight: FontWeight.w400, size: 14.0))
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('예약시간',
                    style: textStyle(size: 13.0, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Text(time,
                    style: textStyle(fontWeight: FontWeight.w400, size: 14.0))
              ],
            ),
            cardType(cardtype),
          ],
        ),
      ),
    );
  }

  Widget cardType(CARDTYPE type) {
    switch (type) {
      case CARDTYPE.NONE:
        {
          return Container();
        }
      case CARDTYPE.BUTTON:
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: 1, color: Colors.grey),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: Colors.grey.shade100,
                  textStyle: textStyle(size: 12, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('리뷰작성'),
              ),
            ],
          );
        }
      case CARDTYPE.STAR:
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: 1, color: Colors.grey),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_star.svg',
                    width: 10,
                    height: 10,
                  ),
                  SvgPicture.asset(
                    'assets/icons/icon_star.svg',
                    width: 10,
                    height: 10,
                  ),
                  SvgPicture.asset(
                    'assets/icons/icon_star.svg',
                    width: 10,
                    height: 10,
                  ),
                  SvgPicture.asset(
                    'assets/icons/icon_star.svg',
                    width: 10,
                    height: 10,
                  ),
                  SvgPicture.asset(
                    'assets/icons/icon_star.svg',
                    width: 10,
                    height: 10,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          );
        }
    }
  }
}
