import 'package:flutter/material.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/transporation_Booking_view_body.dart';

class TransporationBookingView extends StatelessWidget {
  const TransporationBookingView({super.key});
  static const  routeName = 'transportation-booking-view';
  @override
  Widget build(BuildContext context) {
    return TransporationBookingViewBody();
  }
}