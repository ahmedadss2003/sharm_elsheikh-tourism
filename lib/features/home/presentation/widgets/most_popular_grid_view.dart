import 'package:flutter/material.dart';
import 'package:tourist_website/core/widgets/similar_and_most_popular_card.dart';

class CustomMostPopularGridView extends StatelessWidget {
  const CustomMostPopularGridView({super.key});


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return LayoutBuilder(
          builder: (context , constraints) {
            return GridView.builder(
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
                return SimilarAndMostPopularCard(index: index);
              },
            );
          }
        );
      }
    );
  }
  int _getCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }

  // Helper method to determine aspect ratio based on screen width
  double _getChildAspectRatio(double width) {
    if (width > 1200) return 1;
    if (width > 900) return 0.89;
    if (width > 600) return 1.2;
    return 1.4;
  }
}