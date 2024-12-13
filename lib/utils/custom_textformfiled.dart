import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final TextInputType ?keyboardType;
  final bool ?obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;
  final InputBorder? border;
  final bool enabled;
  final bool isRequired; // New property
  final double? width;  // Optional width for the container
  final double? height; // Optional height for the container
  final EdgeInsetsGeometry? padding; // New property for custom padding
 final TextStyle? inputTextStyle;
 final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
   final double ?borderRadius;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.inputTextStyle,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction =TextInputAction.none,
    this.border,
    this.enabled = true,
    this.isRequired = false, // Default to false
    this.width, // Default is null
    this.height, // Default is null
    this.padding, // Default is null
    this.enabledBorderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    this.borderRadius 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??  EdgeInsets.only(), // Default padding if none is provided
      child: SizedBox(
        width: width , // If width is null, takes full width
        height: height, // If height is null, the height is determined by the content
        child: TextFormField(
          style: inputTextStyle ,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText!,
          maxLength: maxLength,
          maxLines: maxLines,
          textInputAction: textInputAction,
          enabled: enabled,
          decoration: InputDecoration(
            label: labelText != null
                ? RichText(
                    text: TextSpan(
                      text: labelText,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      children: isRequired
                          ? [
                              TextSpan(
                                text: ' *',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              ),
                            ]
                          : [],
                    ),
                  )
                : null,
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(255, 123, 121, 121), // You can change the color as needed
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: border ?? OutlineInputBorder(),
             enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enabledBorderColor!),
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor!, width: 2.0),
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorBorderColor!, width: 2.0),
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorBorderColor!, width: 2.0),
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
