import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
    isDark ? AppColors.strokeDarkColor : AppColors.strokeWhiteColor;
    final hintColor = isDark ? AppColors.whiteDarkColor : AppColors.greyColor;

    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && _hidden,
      style: TextStyle(
        fontSize: 13,
        color: isDark ? AppColors.whiteColor : AppColors.blackColor,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(fontSize: 12, color: hintColor),
        filled: true,
        fillColor: isDark ? AppColors.darkInputColor : AppColors.whiteColor,
        prefixIcon: Icon(widget.icon, size: 20, color: hintColor),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _hidden
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20,
            color: hintColor,
          ),
          onPressed: () => setState(() => _hidden = !_hidden),
        )
            : null,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.mainDarkColor : AppColors.mainLightColor,
          ),
        ),
      ),
    );
  }
}