

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoSection extends StatelessWidget {
  const VideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAX2k45okUy728ezWeVAtVCwgiS6UxO7an65JMvauYChxgCplMbMNK33f6-zIOp0haROz64Vo31HuX6EXWn9N3DHkmt5c50PX91wF0Q_PS5ikPposgxDVS3IFQ_6qG8UIc8xltSyJV0fPQvRUp0Ih5b5qtHUpKhP87Rk7Z6zl8a8BrCgOnUnOxh9Kbnj9bMSaUcIUONzQSDKcFuU8U3fewhFJg7X5PP6aabdbpAPqU1Pomf34VZpyGGRv8GhBYgfizEe1Qtin5nDgk',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: IconButton(
            icon: Icon(
              Icons.play_circle_filled,
              size: 64,
              color: Colors.white.withOpacity(0.8),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Video playback not implemented')),
              );
            },
          ),
        ),
      ),
    );
  }
}