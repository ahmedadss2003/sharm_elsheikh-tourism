import 'package:flutter/material.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/image_section.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/place_card.dart';

class DiscoverPlacesViewBody extends StatelessWidget {
  const DiscoverPlacesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
     final double height = MediaQuery.of(context).size.height;
    return Scaffold(
     
      body: LayoutBuilder(
        builder: (context , constrains) {
          return SingleChildScrollView(
            child: Column(
            
              children: [
                CustomDiscoverPLaceImageSection(height: height),
                SizedBox(height: 20,),
                TripCard()
              ],
            ),
          );
        }
      )
      
    );
  }
}
