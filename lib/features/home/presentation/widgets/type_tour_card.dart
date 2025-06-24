import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/discover_places_view.dart';

class TourCard extends StatefulWidget {
  final String category;
  final String title;
  final String description;
  final String imageUrl;

  const TourCard({
    required this.category,
    required this.title,
    required this.description,
    required this.imageUrl,
    super.key,
  });

  @override
  State<TourCard> createState() => _TourCardState();
}

class _TourCardState extends State<TourCard> {
  bool isHover = false ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 900;
          return MouseRegion(
            onEnter: (event) => setState(() {
              isHover = true;
            }),
            onExit: (event) => setState(() {
              isHover = false;
            }) ,
            child: AnimatedScale(
              scale: isHover ? 1.02 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Card(
            
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: isMobile ? _buildMobileLayout() : _buildWebTabletLayout(isTablet),
          ),
            )
          ) ;
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    // Vertical layout for mobile
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.cover,
            height: 180,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.category,
                style: const TextStyle(
                  color: Color(0xFF5C748A),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Color(0xFF101518),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: const TextStyle(
                  color: Color(0xFF5C748A),
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:(context , animation , duration) =>DiscoverPlacesView() ,
                      transitionsBuilder: (context , animation , secondaryAnimation , child) => FadeTransition(opacity: animation , child: child,),
                      transitionDuration: Duration(milliseconds: 500),
                    )
                  );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEAEDF1),
                    foregroundColor: const Color.fromARGB(255, 48, 56, 62),
                    overlayColor: const Color.fromARGB(255, 9, 83, 175),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text('View Details'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWebTabletLayout(bool isTablet) {
    // Horizontal layout for web and tablet
    return SizedBox(
      height: 300,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.category,
                    style: const TextStyle(
                      color: Color(0xFF5C748A),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Color(0xFF101518),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: Color(0xFF5C748A),
                      fontSize: 16,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:(context , animation , duration) =>DiscoverPlacesView() ,
                      transitionsBuilder: (context , animation , secondaryAnimation , child) => FadeTransition(opacity: animation , child: child,),
                      transitionDuration: Duration(milliseconds: 500),
                    )
                  );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEAEDF1),
                      foregroundColor: const Color(0xFF101518),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('View Details'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}