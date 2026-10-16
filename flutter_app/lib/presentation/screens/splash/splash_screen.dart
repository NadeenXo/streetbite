import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;

  const SplashScreen({
    super.key,
    required this.nextScreen,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => opacity = 1);
      }
    });

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => widget.nextScreen,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox.expand(
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 900),
          child: Image.asset(
            'assets/branding/streetbite_splash.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}