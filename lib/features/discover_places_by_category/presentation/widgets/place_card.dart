import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/place_detials/presentation/views/place_details_view.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.tourModel, required this.width});
  final TourModel tourModel;
  final double width;

  @override
  Widget build(BuildContext context) {
    final double padding = width < 400 ? 8.0 : 12.0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PlaceDetailsView.routeName,
          arguments: tourModel,
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 150,
            maxHeight:
                width < 400
                    ? 200
                    : width < 600
                    ? 250
                    : 300,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: width < 400 ? 5 : 2,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      child: Image.network(
                        tourModel.images[0].image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                    // Price Badge
                    Positioned(
                      left: 2,
                      bottom: padding,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding * 0.5,
                          vertical: padding * 0.3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${tourModel.priceAdult}\$",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width < 400 ? 14 : 16,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Status Ribbon (on the left, dynamic based on status)
                    if (tourModel.status != null)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: CustomPaint(
                          painter: RibbonPainter(
                            color: _getStatusColor(tourModel.status!),
                            direction: 'left',
                          ),
                          child: Container(
                            padding: EdgeInsets.only(
                              left: padding * 0.8,
                              right: padding * 1.5,
                              top: padding * 0.6,
                              bottom: padding * 0.8,
                            ),
                            child: Text(
                              _getStatusText(tourModel.status!),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: width < 400 ? 9 : 11,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    // Offer Ribbon (on the right, only if discount > 0)
                    if (tourModel.discount > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CustomPaint(
                          painter: RibbonPainter(
                            color: Colors.green,
                            direction: 'right',
                          ),
                          child: Container(
                            padding: EdgeInsets.only(
                              right: padding * 0.8,
                              left: padding * 1.5,
                              top: padding * 0.6,
                              bottom: padding * 0.8,
                            ),
                            child: Text(
                              "${_calculateDiscountPercentage(tourModel.priceAdult, tourModel.discount)}% OFF",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: width < 400 ? 9 : 11,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Flexible(
                flex: width < 400 ? 3 : 2,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: padding),
                      AutoSizeText(
                        tourModel.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width < 400 ? 14 : 16,
                        ),
                        maxLines: 1,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: padding),
                      Expanded(
                        child: AutoSizeText(
                          tourModel.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: width < 400 ? 12 : 14,
                          ),
                          maxLines: 3,
                          minFontSize: 8,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: padding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: width < 400 ? 12 : 14,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: padding * 0.5),
                          Flexible(
                            child: AutoSizeText(
                              tourModel.availability,
                              maxLines: 1,
                              minFontSize: 8,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: width < 400 ? 10 : 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'popular':
        return Colors.orange;
      case 'new':
        return Colors.green;
      case 'bestseller':
        return Colors.purple;
      case 'limited':
        return Colors.red;
      case 'featured':
        return Colors.blue;
      case 'hot':
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'popular':
        return 'Popular';
      case 'new':
        return 'New';
      case 'bestseller':
        return 'Best Seller';
      case 'limited':
        return 'Limited';
      case 'featured':
        return 'Featured';
      case 'hot':
        return 'Hot';
      default:
        return status.toUpperCase();
    }
  }

  int _calculateDiscountedPrice(int originalPrice, int discount) {
    return originalPrice - discount;
  }

  int _calculateDiscountPercentage(int originalPrice, int discount) {
    if (originalPrice == 0 || discount < 0 || discount > originalPrice)
      return 0;
    return ((discount / originalPrice) * 100).round();
  }
}

class RibbonPainter extends CustomPainter {
  final Color color;
  final String direction;

  RibbonPainter({required this.color, this.direction = 'left'});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final Path path = Path();

    if (direction == 'left') {
      path.moveTo(0, 0);
      path.lineTo(size.width - 10, 0);
      path.quadraticBezierTo(size.width, 0, size.width, 10);
      path.lineTo(size.width, size.height - 10);
      path.quadraticBezierTo(
        size.width,
        size.height,
        size.width - 10,
        size.height,
      );
      path.lineTo(0, size.height);
      path.close();
    } else {
      path.moveTo(10, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(10, size.height);
      path.lineTo(0, size.height - 10);
      path.lineTo(0, 10);
      path.close();
    }

    canvas.drawPath(path, paint);

    final Paint shadowPaint =
        Paint()
          ..color = Colors.black.withOpacity(0.2)
          ..style = PaintingStyle.fill;

    final Path shadowPath = Path();
    if (direction == 'left') {
      shadowPath.moveTo(size.width - 10, 0);
      shadowPath.quadraticBezierTo(size.width, 0, size.width, 10);
      shadowPath.lineTo(size.width, size.height - 10);
      shadowPath.quadraticBezierTo(
        size.width,
        size.height,
        size.width - 10,
        size.height,
      );
      shadowPath.lineTo(size.width - 10, 10);
      shadowPath.close();
    } else {
      shadowPath.moveTo(10, 0);
      shadowPath.lineTo(size.width, 0);
      shadowPath.lineTo(size.width, size.height);
      shadowPath.lineTo(10, size.height);
      shadowPath.lineTo(10, 10);
      shadowPath.close();
    }

    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
