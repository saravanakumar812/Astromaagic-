import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/theme.dart';

class OtpVerifiedScreen extends StatefulWidget {
  const OtpVerifiedScreen({super.key});

  @override
  State<OtpVerifiedScreen> createState() => _OtpVerifiedScreenState();
}

class _OtpVerifiedScreenState extends State<OtpVerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/backgroundImage.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                "assets/images/verified.png",
                width: width * 0.4,
                //height: height * 0.3,
                // color: Colors.white,
              ),
            ),
            Container(
              child: Text(
                "OTP Verified",
                style: GoogleFonts.lato(
                  color: AppTheme.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
