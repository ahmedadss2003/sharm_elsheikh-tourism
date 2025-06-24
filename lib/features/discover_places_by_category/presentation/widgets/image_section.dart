
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomDiscoverPLaceImageSection extends StatelessWidget {
  const CustomDiscoverPLaceImageSection({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context , constrains) {
        return ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          child: Stack(
            children: [
              CachedNetworkImage(
              imageUrl: "https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80  ",
              height: constrains.maxWidth<600? height*0.4: height*0.6,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>  Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.purple,
                size: 100,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text("Discover Places",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              )
            )
            ],
          ),
        );
      }
    );
  }
}