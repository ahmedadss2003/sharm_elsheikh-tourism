import 'package:flutter/material.dart';

class HoverableShowImagesButton extends StatefulWidget {
  final VoidCallback? onTap;

  const HoverableShowImagesButton({super.key, this.onTap});

  @override
  State<HoverableShowImagesButton> createState() =>
      _HoverableShowImagesButtonState();
}

class _HoverableShowImagesButtonState extends State<HoverableShowImagesButton> {
  bool isHover = false;
  final Color defaultColor = const Color(0xff1a73e8);
  final Color hoverTextColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },
      child: AnimatedScale(
        scale: isHover ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isHover ? Colors.white : defaultColor,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: defaultColor, width: 1.5),
            ),
            child: Text(
              'Show Images',
              style: TextStyle(
                fontSize: 18,
                color: isHover ? hoverTextColor : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
