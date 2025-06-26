import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppFloatingButton extends StatelessWidget {
  const WhatsAppFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      child: GestureDetector(
        onTap: () => _launchWhatsApp(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF25D366), 
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:  [
              Icon(Icons.whatshot, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Contact us on WhatsApp',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchWhatsApp() async {
    final Uri whatsapp = Uri.parse("https://wa.me/201099969068");
    if (await canLaunchUrl(whatsapp)) {
      await launchUrl(whatsapp);
    } else {
      debugPrint("Could not launch WhatsApp");
    }
  }
}
