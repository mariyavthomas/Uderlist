import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? elevation;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? width; // Optional if not using fixedSize
  final double? height; // Optional if not using fixedSize
  final Size? fixedSize; // Corrected to use Size directly

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.elevation = 4.0,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Montserrat',
    this.width,
    this.height,
    this.fixedSize, // Fixed to take Size directly
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        elevation: elevation,
        fixedSize: fixedSize ?? (width != null && height != null ? Size(width!, height!) : null),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        padding: padding,
      ),
      child: Text(
        text,
        style: GoogleFonts.getFont(
          fontFamily ?? 'Montserrat',
          fontSize: fontSize ?? 16.0,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
