import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlobalLoading extends StatelessWidget {
  final double size;
  final bool isWhite;

  const GlobalLoading({
    super.key,
    this.size = 150.0,
    this.isWhite = false,
  });

  /// A centered loading animation, useful for empty states or list loading.
  static Widget centered({double size = 150.0, bool isWhite = false}) {
    return Center(
      child: GlobalLoading(size: size, isWhite: isWhite),
    );
  }

  /// A full-screen overlay with a semi-transparent background.
  static Widget overlay(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      width: double.infinity,
      height: double.infinity,
      child: const Center(
        child: GlobalLoading(size: 200.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      isWhite ? 'assets/animation/loadingwhite.json' : 'assets/animation/loadingblack.json',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
