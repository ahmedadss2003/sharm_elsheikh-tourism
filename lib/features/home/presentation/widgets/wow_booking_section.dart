import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HowBookingSection extends StatelessWidget {
  const HowBookingSection({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(color: Color(0xff1a73e8)),
      child: Column(
        children: [
          SizedBox(height: 20),
          const AutoSizeText(
            'How To Book with us ?',
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w900,
              // letterSpacing: -0.33,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width < 700 ? 25 : 60),
              child: AutoSizeText(
                maxLines: 3,

                textAlign: TextAlign.center,
                "Just fill out the order form on the tour page, and then click the “Book This tour” button. Once you do this, we will send you a confirmation email that your reservation has been confirmed in accordance with the information you sent us. Or contact us by phone. +201099969068(viber, whatsapp, telegram)",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
