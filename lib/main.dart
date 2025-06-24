import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourist_website/core/helper_function/helper_function.dart';
import 'package:tourist_website/features/home/presentation/home_view.dart';
void main() {
  runApp(const SharmElSheikhApp());
}

class SharmElSheikhApp extends StatelessWidget {
  const SharmElSheikhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sharm El-Sheikh Tourism',
      theme: ThemeData(
        primaryColor: const Color(0xFF101518),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
          bodyLarge: GoogleFonts.notoSans(),
          bodyMedium: GoogleFonts.notoSans(),
          bodySmall: GoogleFonts.notoSans(),
        ),
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: HomePage.routeName,
    );    
  }
}






