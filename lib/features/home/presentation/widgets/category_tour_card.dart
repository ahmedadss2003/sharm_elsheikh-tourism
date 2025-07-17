import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/discover_places_view.dart';
import 'package:tourist_website/features/home/presentation/widgets/custom_view_details_button.dart';

class CategoryTourCard extends StatefulWidget {
  final String category;
  final String description;
  final String imageUrl;
  final Color color;
  const CategoryTourCard({
    required this.category,
    required this.description,
    required this.imageUrl,
    super.key,
    required this.color,
  });

  @override
  State<CategoryTourCard> createState() => _CategoryTourCardState();
}

class _CategoryTourCardState extends State<CategoryTourCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 900;
          return MouseRegion(
            onEnter:
                (event) => setState(() {
                  isHover = true;
                }),
            onExit:
                (event) => setState(() {
                  isHover = false;
                }),
            child: AnimatedScale(
              scale: isHover ? 1.02 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, duration) =>
                                DiscoverPlacesView(
                                  imageUrl: widget.imageUrl,
                                  categoryName: widget.category,
                                ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child:
                      isMobile
                          ? _buildMobileLayout(widget.category)
                          : _buildWebTabletLayout(isTablet, widget.category),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(String categoryName) {
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
                style: const TextStyle(color: Color(0xFF5C748A), fontSize: 14),
              ),
              const SizedBox(height: 4),

              const SizedBox(height: 8),
              Text(
                widget.description,
                style: const TextStyle(color: Color(0xFF5C748A), fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: CustomViewDetailsButton(
                  imageUrl: widget.imageUrl,
                  context: context,
                  widget: widget,
                  categoryName: categoryName,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWebTabletLayout(bool isTablet, String categoryName) {
    // Horizontal layout for web and tablet
    return SizedBox(
      height: 300,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
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
                      color: Color.fromARGB(255, 5, 12, 19),
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),

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
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomViewDetailsButton(
                      imageUrl: widget.imageUrl,
                      context: context,
                      widget: widget,
                      categoryName: categoryName,
                    ),
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
