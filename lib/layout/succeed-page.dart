import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class Succeed extends StatefulWidget {
  const Succeed({super.key});

  @override
  State<Succeed> createState() => _SucceedState();
}

class _SucceedState extends State<Succeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const MyApp(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Center(
          child: Text(
            "Successful",
            style: GoogleFonts.prompt(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
