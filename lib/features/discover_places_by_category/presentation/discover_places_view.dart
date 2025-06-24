import 'package:flutter/material.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/discover_places_view_body.dart';

class DiscoverPlacesView extends StatelessWidget {
  const DiscoverPlacesView({super.key});
  static const routeName = "discover_places" ;
  @override
  Widget build(BuildContext context) {
    return DiscoverPlacesViewBody();
  }
}