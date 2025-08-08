import 'package:flutter/material.dart';
import 'dart:async';
import 'home_view.dart'; // Your main notes screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Initialize animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations with delays
    _startAnimations();

    // Navigate after delay
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
          const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              ),
            );
          },
        ),
      );
    });
  }

  void _startAnimations() {
    Timer(const Duration(milliseconds: 200), () {
      _fadeController.forward();
    });

    Timer(const Duration(milliseconds: 400), () {
      _scaleController.forward();
    });

    Timer(const Duration(milliseconds: 600), () {
      _rotationController.forward();
    });

    Timer(const Duration(milliseconds: 800), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _rotationController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Color(0xFF1A4D47),  // Dark teal
              Color(0xFF0D2926),  // Very dark teal
              Color(0xFF000000),  // Black
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background particles
            ...List.generate(20, (index) => _buildFloatingParticle(index)),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated icon with glow effect
                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: RotationTransition(
                              turns: _rotationAnimation,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff65FCD7).withOpacity(0.6),
                                      blurRadius: 30,
                                      spreadRadius: 10,
                                    ),
                                    BoxShadow(
                                      color: Color(0xff65FCD7).withOpacity(0.4),
                                      blurRadius: 60,
                                      spreadRadius: 20,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.auto_awesome,
                                  color: Color(0xff65FCD7),
                                  size: 100,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Animated text with slide effect
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFF65FCD7),  // Primary teal
                            Color(0xFF4DD0C0),  // Medium teal
                            Color(0xFF2BA598),  // Darker teal
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          'Notes',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 8,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subtitle with fade animation
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      'Capture Your Ideas',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Animated loading indicator
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xff65FCD7).withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingParticle(int index) {
    final random = index * 0.1;
    return Positioned(
      left: (index * 37.0) % MediaQuery.of(context).size.width,
      top: (index * 47.0) % MediaQuery.of(context).size.height,
      child: AnimatedBuilder(
        animation: _fadeController,
        builder: (context, child) {
          return Opacity(
            opacity: (_fadeAnimation.value * 0.3) * (0.5 + random),
            child: Container(
              width: 4 + (index % 3) * 2.0,
              height: 4 + (index % 3) * 2.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff65FCD7).withOpacity(0.6),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff65FCD7).withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}