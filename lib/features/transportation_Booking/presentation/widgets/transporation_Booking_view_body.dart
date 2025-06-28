import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TransporationBookingViewBody extends StatelessWidget {
  const TransporationBookingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: "https://toyota.com.eg/storage/21952/142280_451797_HH1202-F.JPG",
            height: 300, width: double.infinity, fit: BoxFit.cover,
            placeholder: (context, url) =>  Center(
              child: CircularProgressIndicator(),
            )
          ),
        ],
      ),
    );
  }
}