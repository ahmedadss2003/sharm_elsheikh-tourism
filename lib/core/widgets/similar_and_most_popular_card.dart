
import 'package:flutter/material.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/place_details.dart';

class SimilarAndMostPopularCard extends StatelessWidget {
  const SimilarAndMostPopularCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    List<String> tourImages = [
      'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
    ];

    List<String> tourTitles = [
      'Ras Mohamed National Park Day Tour',
      'Blue Lagoon',
      'Snorkeling Catamarans in Blue Hole',
      'Quad bike desert safari',
      'Ras Mohamed National Park Day Tour',
      'Blue Lagoon',
      'Snorkeling Catamarans in Blue Hole',
      'Quad bike desert safari',
      'Ras Mohamed National Park Day Tour',
      'Blue Lagoon',
      'Snorkeling Catamarans in Blue Hole',
      'Quad bike desert safari',
      'Ras Mohamed National Park Day Tour',
      'Blue Lagoon',
      'Snorkeling Catamarans in Blue Hole',
      'Quad bike desert safari',
    ];

    return LayoutBuilder(
      builder: (context , constrains){
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PlaceDetailsView.routeName) ;
          },
          child: Container(
            width: constrains.maxWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(tourImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tourTitles[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: index < 4 ? Colors.amber : Colors.grey[300],
                              size: 16,
                            );
                          }
                        ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'From \$${(50 + index * 25)}',
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}