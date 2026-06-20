import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;

  const PriceTag({
    super.key,
    required this.price,
    this.fontSize = 18,
    this.color,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedPrice = price % 1 == 0
        ? price.toStringAsFixed(0)
        : price.toStringAsFixed(2);

    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: color ?? Theme.of(context).colorScheme.onSurface,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Inter',
        ),
        children: [
          TextSpan(
            text: '\$',
            style: TextStyle(
              fontSize: fontSize * 0.8,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: formattedPrice),
        ],
      ),
    );
  }
}
