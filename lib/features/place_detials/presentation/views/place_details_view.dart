import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/place_detials/data/repos/best_sall_impl.dart';
import 'package:tourist_website/features/place_detials/domain/uses_case/best_sall_usecase.dart';
import 'package:tourist_website/features/place_detials/presentation/manager/best_saller_cubit/best_salle_cubit.dart';
import 'package:tourist_website/features/place_detials/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:tourist_website/features/place_detials/presentation/views/place_details_view_body.dart';

class PlaceDetailsView extends StatelessWidget {
  const PlaceDetailsView({super.key, required this.tourModel});
  static const String routeName = 'place_details';
  final TourModel tourModel;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => BestSalleCubit(
                BestSallUsecase(
                  bestSallRepo: BestSallRepoImpl(apiService: ApiService(Dio())),
                ),
              )..getBestSalleTours(),
        ),
        BlocProvider(create: (context) => BookingCubit(ApiService(Dio()))),
      ],
      child: PlaceDetailsViewBody(tourModel: tourModel),
    );
  }
}
