

import 'package:flutter/material.dart';

class HowBookingSection extends StatelessWidget {
  const HowBookingSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 51, 184, 196),
      ),
      child: Column(
        children: [
          const Text(
            'How To Book with us ?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              // letterSpacing: -0.33,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                textAlign: TextAlign.center,
                "Just fill out the order form on the tour page, and then click the “Book This tour” button. Once you do this, we will send you a confirmation email that your reservation has been confirmed in accordance with the information you sent us. Or contact us by phone. +201099969068(viber, whatsapp, telegram)",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15 ,
                  fontWeight: FontWeight.w500,
                )
                ),
            ),
            ),
        ],
      ),
    );
  }
}





