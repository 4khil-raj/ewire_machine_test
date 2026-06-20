import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutline;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.isOutline = false,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeBgColor = backgroundColor ?? theme.colorScheme.primary;
    final themeTextColor = textColor ?? (isOutline ? theme.colorScheme.primary : theme.colorScheme.onPrimary);

    Widget buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: themeTextColor),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: themeTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );

    Widget button = SizedBox(
      height: height,
      width: isFullWidth ? double.infinity : null,
      child: isOutline
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: themeBgColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              onPressed: onPressed,
              child: buttonChild,
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeBgColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              onPressed: onPressed,
              child: buttonChild,
            ),
    );

    return button;
  }
}
