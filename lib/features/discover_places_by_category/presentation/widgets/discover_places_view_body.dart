import 'package:flutter/material.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/discover_places_gridview.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/image_section.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/place_card.dart';
import 'package:tourist_website/features/home/presentation/widgets/footer_section.dart';

class DiscoverPlacesViewBody extends StatelessWidget {
  const DiscoverPlacesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(      
              children: [
                CustomDiscoverPLaceImageSection(height: height),
                const SizedBox(height: 20),
                
                // Responsive GridView with proper padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomDiscoverPlacesGridView(
                    child:TripCard() ,
                  )
                ),
                
                const SizedBox(height: 20),
                const FooterSection(),
              ],
            ),
          );
        },
      ),
    );
  }

 
}


