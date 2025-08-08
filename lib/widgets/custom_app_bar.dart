import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      if (_isSearching) {
        _searchController.clear();
      }
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return FadeTransition(
      opacity: _fadeIn,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Ensure asset path is correct
              height: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),

            // Show either title text or search field:
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isSearching
                    ? TextField(
                  key: const ValueKey('searchField'),
                  controller: _searchController,
                  autofocus: true,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search notes...',
                    hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onChanged: (query) {
                    // Handle live search query here
                    debugPrint('Searching: $query');
                  },
                )
                    : Text(
                  'Notes',
                  key: const ValueKey('titleText'),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3,
                    color: textColor,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Search icon or clear icon depending on _isSearching:
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: _toggleSearch,
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    _isSearching ? Icons.clear : Icons.search,
                    size: 28,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
