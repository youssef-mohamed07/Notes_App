// custom_search_icon.dart
import 'package:flutter/material.dart';

class CustomSearchIcon extends StatefulWidget {
  const CustomSearchIcon({super.key});

  @override
  State<CustomSearchIcon> createState() => _CustomSearchIconState();
}

class _CustomSearchIconState extends State<CustomSearchIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05);
    final iconColor = isDark ? Colors.white70 : Colors.black87;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovering ? 0.12 : 0.05),
              blurRadius: _isHovering ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // TODO: Add your search action here
              debugPrint('Search icon tapped');
            },
            child: Tooltip(
              message: 'Search',
              child: Center(
                child: Icon(
                  Icons.search,
                  size: 28,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
