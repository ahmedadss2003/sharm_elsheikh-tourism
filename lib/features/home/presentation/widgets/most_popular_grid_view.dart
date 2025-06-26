
import 'package:flutter/material.dart';
import 'package:tourist_website/core/widgets/similar_and_most_popular_card.dart';

class MostPopularGridView extends StatelessWidget {
  const MostPopularGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
     shrinkWrap: true,
     physics: NeverScrollableScrollPhysics(),
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
       crossAxisSpacing: 15,
       mainAxisSpacing: 15,
       childAspectRatio: 0.8,
     ),
     itemCount: 10,
     itemBuilder: (context, index) {
       return SimilarAndMostPopularCard(index: index);
     },
    );
  }
}
