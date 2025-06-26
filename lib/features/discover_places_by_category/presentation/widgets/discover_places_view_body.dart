import 'package:flutter/material.dart';
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
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: _getChildAspectRatio(constraints.maxWidth),
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const TripCard();
                    },
                  ),
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

  // Helper method to determine cross axis count based on screen width
  int _getCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }

  // Helper method to determine aspect ratio based on screen width
  double _getChildAspectRatio(double width) {
    if (width > 1200) return 0.75;
    if (width > 900) return 0.8;
    if (width > 600) return 0.75;
    return 1.4;
  }
}