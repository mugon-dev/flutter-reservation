import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypet_reservation/domain/reservation.dart';
import 'package:mypet_reservation/util/text_theme.dart';

import 'components/reservation_list_card.dart';

class ReservationListPage extends StatelessWidget {
  const ReservationListPage({Key? key}) : super(key: key);

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
            '예약내역',
            style: textStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(10), child: SizedBox()),
        ),
        body: ListView(
          children: List.generate(
              sampleReservation.length,
              (index) => ReservationListCard(
                    cardtype: sampleReservation[index].cardtype,
                    visitToggle: sampleReservation[index].visitToggle,
                    hospital: sampleReservation[index].hospital,
                    date: sampleReservation[index].date,
                    time: sampleReservation[index].time,
                  )),
        ));
  }
}
