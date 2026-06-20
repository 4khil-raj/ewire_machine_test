import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterPressed;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Search products, brands...',
    this.onChanged,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.transparent : Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              onChanged: onChanged,
              style: TextStyle(color: theme.colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.5)),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: isDark ? BorderSide(color: theme.colorScheme.outline) : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: isDark ? BorderSide(color: theme.colorScheme.outline) : BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: theme.colorScheme.secondary, width: 1.5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
            border: isDark ? Border.all(color: theme.colorScheme.outline) : null,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.tune_rounded,
              color: theme.colorScheme.onPrimary,
              size: 20,
            ),
            onPressed: onFilterPressed,
          ),
        ),
      ],
    );
  }
}
