import 'package:flutter/material.dart';

class UpArrow extends StatefulWidget {
  const UpArrow({super.key});

  @override
  State<UpArrow> createState() => _UpArrowState();
}

class _UpArrowState extends State<UpArrow> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 20,
          bottom: 20,
          child: MouseRegion(
            onEnter: (event) {
              setState(() {
                isHover = true;
              });
            },
            onExit: (event) {
              setState(() {
                isHover = false;
              });
            },
            child: AnimatedScale(
              scale: isHover ? 1.02 : 1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                // padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[700]!, Colors.blue[300]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: isHover
                      ? [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  Icons.arrow_upward,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}