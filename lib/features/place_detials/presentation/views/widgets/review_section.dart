import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ReviewsSection extends StatelessWidget {
  final double width;

  const ReviewsSection({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width > 960 ? 30 : 16,
        vertical: 40,
      ),
      decoration: const BoxDecoration(color: Color(0xFFF8F9FA)),
      child: Column(
        children: [
          const AutoSizeText(
            'What Our Customers Say',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF101518),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Trusted by thousands of travelers worldwide',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8D9199),
            ),
          ),
          const SizedBox(height: 32),
          _buildResponsiveGrid(),
        ],
      ),
    );
  }

  Widget _buildResponsiveGrid() {
    // Mobile: 1 column
    if (width < 768) {
      return Column(
        children: [
          _buildReviewCard(_reviewsData[0]),
          const SizedBox(height: 16),
          _buildReviewCard(_reviewsData[1]),
          const SizedBox(height: 16),
          _buildReviewCard(_reviewsData[2]),
          const SizedBox(height: 16),
          _buildReviewCard(_reviewsData[3]),
        ],
      );
    }

    // Tablet: 2 columns, 2 rows
    if (width < 1024) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildReviewCard(_reviewsData[0])),
              const SizedBox(width: 16),
              Expanded(child: _buildReviewCard(_reviewsData[1])),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildReviewCard(_reviewsData[2])),
              const SizedBox(width: 16),
              Expanded(child: _buildReviewCard(_reviewsData[3])),
            ],
          ),
        ],
      );
    }

    // Desktop: 4 columns, 1 row
    return Row(
      children: [
        Expanded(child: _buildReviewCard(_reviewsData[0])),
        const SizedBox(width: 16),
        Expanded(child: _buildReviewCard(_reviewsData[1])),
        const SizedBox(width: 16),
        Expanded(child: _buildReviewCard(_reviewsData[2])),
        const SizedBox(width: 16),
        Expanded(child: _buildReviewCard(_reviewsData[3])),
      ],
    );
  }

  Widget _buildReviewCard(ReviewCardData data) {
    return ReviewCard(
      icon: data.icon,
      title: data.title,
      subtitle: data.subtitle,
      description: data.description,
      backgroundColor: data.backgroundColor,
      iconColor: data.iconColor,
      showStars: data.showStars,
      rating: data.rating,
    );
  }

  // Static data for the four review cards
  static final List<ReviewCardData> _reviewsData = [
    ReviewCardData(
      icon: Icons.star_rounded,
      title: 'Trustpilot',
      subtitle: 'TrustScore 4.3 | 76,536 reviews',
      description: "We're trusted by our customers",
      backgroundColor: Color(0xFF1a73e8),
      iconColor: Colors.white,
      showStars: true,
      rating: 4.5,
    ),
    ReviewCardData(
      icon: Icons.security_rounded,
      title: 'SECURE YOUR ACCOUNT',
      subtitle: 'Your money is protected',
      description: 'Safe and secure payment processing',
      backgroundColor: Color(0xFF1a73e8),
      iconColor: Colors.white,
      showStars: false,
      rating: 0.0,
    ),
    ReviewCardData(
      icon: Icons.savings_rounded,
      title: 'Deposits from £30pp',
      subtitle: 'Payment plans with no fees',
      description: 'Flexible payment options available',
      backgroundColor: Color(0xFF1a73e8),
      iconColor: Colors.white,
      showStars: false,
      rating: 0.0,
    ),
    ReviewCardData(
      icon: Icons.home_rounded,
      title: 'The home of holiday perks',
      subtitle: 'Exclusive benefits for members',
      description: 'Special offers and rewards',
      backgroundColor: Color(0xFF1a73e8),
      iconColor: Colors.white,
      showStars: false,
      rating: 0.0,
    ),
  ];
}

class ReviewCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Color backgroundColor;
  final Color iconColor;
  final bool showStars;
  final double rating;

  const ReviewCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.backgroundColor,
    required this.iconColor,
    this.showStars = false,
    this.rating = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: iconColor),
                if (showStars) ...[
                  const SizedBox(width: 8),
                  _buildStarRating(),
                ],
              ],
            ),
            const SizedBox(height: 12),
            AutoSizeText(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            AutoSizeText(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            AutoSizeText(
              description,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.8),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          // Full star
          return Icon(Icons.star, size: 16, color: Colors.white);
        } else if (index < rating) {
          // Half star
          return Icon(Icons.star_half, size: 16, color: Colors.white);
        } else {
          // Empty star
          return Icon(
            Icons.star_border,
            size: 16,
            color: Colors.white.withOpacity(0.5),
          );
        }
      }),
    );
  }
}

class ReviewCardData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Color backgroundColor;
  final Color iconColor;
  final bool showStars;
  final double rating;

  ReviewCardData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.backgroundColor,
    required this.iconColor,
    this.showStars = false,
    this.rating = 0.0,
  });
}
