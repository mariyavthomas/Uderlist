import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final List<TextSpan>? textSpans; 
  final String? text; 
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final String fontFamily;

  const CustomText({super.key, 
    this.textSpans, 
    this.text, 
    this.fontSize = 14.0,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.padding = const EdgeInsets.all(8.0), 
    this.fontFamily = 'Montserrat', 
  }) : assert(text == null || textSpans == null, 'text or textSpans should be provided, not both.');

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: padding, 
      child: textSpans != null
          ? RichText(
              text: TextSpan(
                style: GoogleFonts.getFont( 
                  fontFamily,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                ),
                children: textSpans!,
              ),
            )
          : Text(
              text ?? '', 
              style: GoogleFonts.getFont( 
                fontFamily,
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
              ),
            ),
    );
  }
}
