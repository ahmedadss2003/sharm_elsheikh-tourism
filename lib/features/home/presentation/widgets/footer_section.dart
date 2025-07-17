import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1A1A1A), // dark footer background
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 32,
            runSpacing: 12,
            children: [
              FooterLink(
                text: 'About Us',
                url:
                    'https://www.instagram.com/sharmdesertsafari?igsh=MWIwYXF3MnIzeDdwcg%3D%3D&utm_source=qr',
              ),
              FooterLink(
                text: 'Contact',
                url:
                    'https://www.facebook.com/profile.php?id=61575163371185&mibextid=wwXIfr&mibextid=wwXIfr',
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Social Media Icons
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            children: [
              SocialIcon(
                icon: Icons.facebook,
                url:
                    'https://www.facebook.com/profile.php?id=61575163371185&mibextid=wwXIfr&mibextid=wwXIfr',
              ),
              SocialIcon(
                icon: Icons.camera_alt,
                url:
                    'https://www.instagram.com/sharmdesertsafari?igsh=MWIwYXF3MnIzeDdwcg%3D%3D&utm_source=qr',
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Bottom Text
          Text(
            '© 2025 Sharm El-Sheikh Tourism. All rights reserved.',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class FooterLink extends StatelessWidget {
  final String text;
  final String url;

  const FooterLink({required this.text, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 28),
        onPressed: () => _launchUrl(url),
        tooltip: url,
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}
