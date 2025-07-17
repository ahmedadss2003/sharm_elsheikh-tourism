import 'package:flutter/material.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/booking_upper_container_section.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/transportation_grid_view.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/transportation_subtittle.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/trasnportation_tittle.dart';

class TransporationBookingViewBody extends StatelessWidget {
  const TransporationBookingViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomBookingContainer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth < 700 ? 20 : 60,
                  ),
                  child: Column(
                    children: [
                      TransportationTittle(),
                      SizedBox(height: 20),
                      TransportationSubTittle(),
                      SizedBox(height: 20),
                      TransportationGridView(width: constraints.maxWidth),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
