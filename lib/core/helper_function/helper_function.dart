import 'package:flutter/material.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/discover_places_view.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/place_details.dart';
import 'package:tourist_website/features/home/presentation/home_view.dart';


Route<dynamic> onGenerateRoute(RouteSettings settings) {

  switch (settings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case DiscoverPlacesView.routeName:
      return MaterialPageRoute(builder: (_) => const DiscoverPlacesView());
    case PLaceDetailsView.routeName:
      return MaterialPageRoute(builder: (_) => const PLaceDetailsView());
    
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}