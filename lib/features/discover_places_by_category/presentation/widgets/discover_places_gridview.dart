import 'package:flutter/material.dart';

class CustomDiscoverPlacesGridView extends StatelessWidget {
  const CustomDiscoverPlacesGridView({super.key, this.child});
  final Widget? child;

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
                return child;
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
    if (width > 1200) return 0.75;
    if (width > 900) return 0.8;
    if (width > 600) return 0.75;
    return 1.4;
  }
}