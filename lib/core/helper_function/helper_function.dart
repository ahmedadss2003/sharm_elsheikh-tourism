import 'package:flutter/material.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/discover_places_view.dart';
import 'package:tourist_website/features/home/presentation/home_view.dart';
import 'package:tourist_website/features/home/presentation/widgets/contact_us.dart';
import 'package:tourist_website/features/place_detials/presentation/views/place_details_view.dart';
import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/transporation_Booking_view.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/transportation_booking_form.dart';
import 'package:tourist_website/splash.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case TransportBookingForm.routeName:
      final transportationModel = settings.arguments as TransportationModel;
      return MaterialPageRoute(
        builder:
            (_) =>
                TransportBookingForm(transportationModel: transportationModel),
      );
    case DiscoverPlacesView.routeName:
      return MaterialPageRoute(
        builder: (_) => const DiscoverPlacesView(categoryName: "Historical"),
      );
    case PlaceDetailsView.routeName:
      final tourModel = settings.arguments as TourModel;
      return MaterialPageRoute(
        builder: (_) => PlaceDetailsView(tourModel: tourModel),
      );
    case TransporationBookingView.routeName:
      return MaterialPageRoute(builder: (_) => TransporationBookingView());
    case ContactUsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ContactUsScreen());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
