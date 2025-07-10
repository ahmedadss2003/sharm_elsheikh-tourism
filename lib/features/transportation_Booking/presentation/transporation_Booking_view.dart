import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/manager/get_transportation_cubit/get_transportation_cubit.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/transporation_Booking_view_body.dart';

class TransporationBookingView extends StatelessWidget {
  const TransporationBookingView({super.key});
  static const routeName = 'transportation-booking-view';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  GetTransportationCubit(ApiService(Dio()))
                    ..getTransportation(),
        ),
      ],

      child: const TransporationBookingViewBody(),
    );
  }
}
