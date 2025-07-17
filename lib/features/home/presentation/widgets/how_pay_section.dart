import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HowPaySection extends StatelessWidget {
  const HowPaySection({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "How to Pay ?",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: Color(0xff1a73e8),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width < 700 ? 25 : 60),
          child: AutoSizeText(
            maxLines: 3,

            textAlign: TextAlign.center,
            "You don’t have to pay until you are here in Sharm El Sheikh already, we will send you our representative to your hotel to give you the receipts and collect the money before your excursions Cash or by Credit Card with add 3% on Total Payment.Or you can visit us at our office",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xff1a73e8),
            ),
          ),
        ),
      ],
    );
  }
}
