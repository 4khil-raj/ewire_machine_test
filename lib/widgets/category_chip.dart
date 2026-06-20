import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final surfaceColor = theme.colorScheme.surface;
    final outlineColor = theme.colorScheme.outline;
    final onPrimaryColor = theme.colorScheme.onPrimary;
    final onSurfaceColor = theme.colorScheme.onSurface.withOpacity(0.6);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : surfaceColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? primaryColor : outlineColor,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? onPrimaryColor : onSurfaceColor,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
