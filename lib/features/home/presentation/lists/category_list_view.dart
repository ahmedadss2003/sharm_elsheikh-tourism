import 'package:flutter/material.dart';
import 'package:tourist_website/features/home/presentation/widgets/category_tour_card.dart';

class CustomCategoryListView extends StatelessWidget {
  const CustomCategoryListView({super.key, required this.tours});

  final List<Map<String, dynamic>> tours;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tours.length,
      itemBuilder: (context, index) {
        final tour = tours[index];
        return CategoryTourCard(
          color: tour["color"]!,
          category: tour['category']!,
          description: tour['description']!,
          imageUrl: tour['imageUrl']!,
        );
      },
    );
  }
}
