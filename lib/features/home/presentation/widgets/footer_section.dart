
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24,
          runSpacing: 12,
          children: [
            FooterLink(text: 'About Us', url: '#'),
            FooterLink(text: 'Contact', url: '#'),
            FooterLink(text: 'Language', url: '#'),
            
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          children: [
            SocialIcon(icon: Icons.facebook, url: 'https://www.facebook.com/SharmElSheikhTourism'),
            SocialIcon(icon: Icons.alternate_email, url: 'https://twitter.com/SharmTourism'),
            SocialIcon(icon: Icons.camera_alt, url: 'https://www.instagram.com/sharmelsheikhtourism'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '© 2025 Sharm El-Sheikh Tourism. All rights reserved.',
          style: TextStyle(
            color: const Color(0xFF5C748A),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}


class FooterLink extends StatelessWidget {
  final String text;
  final String url;

  const FooterLink({required this.text, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _launchUrl(url),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF5C748A),
          fontSize: 16,
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialIcon({required this.icon, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: const Color(0xFF5C748A), size: 24),
      onPressed: () => _launchUrl(url),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    // Handle error, e.g., show a snackbar
  }
}