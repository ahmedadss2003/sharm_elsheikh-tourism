import 'package:flutter/material.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/discover_places_view.dart';
import 'package:tourist_website/features/home/presentation/widgets/category_tour_card.dart';

class CustomViewDetailsButton extends StatefulWidget {
  const CustomViewDetailsButton({
    super.key,
    required this.context,
    required this.widget,
    required this.categoryName,
    required this.imageUrl,
  });

  final BuildContext context;
  final CategoryTourCard widget;
  final String categoryName;
  final String imageUrl;

  @override
  State<CustomViewDetailsButton> createState() =>
      _CustomViewDetailsButtonState();
}

class _CustomViewDetailsButtonState extends State<CustomViewDetailsButton> {
  bool isHover = false;
  Color backgroundColor = Color(0xff1a73e8);
  Color foregroundColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
          backgroundColor = Colors.white;
          foregroundColor = Colors.blueAccent;
        });
      },
      onExit: (event) {
        setState(() {
          backgroundColor = Color(0xff1a73e8);
          foregroundColor = Colors.white;
          isHover = false;
        });
      },
      child: AnimatedScale(
        scale: isHover ? 1.04 : 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder:
                    (context, animation, duration) => DiscoverPlacesView(
                      imageUrl: widget.imageUrl,
                      categoryName: widget.categoryName,
                      color: widget.widget.color,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: Duration(milliseconds: 500),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            'View Details',
            style: TextStyle(color: foregroundColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
