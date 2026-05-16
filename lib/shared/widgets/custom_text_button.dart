import 'package:flutter/material.dart';

/// A custom text button with a simple opacity animation on press.
class CustomTextButton extends StatefulWidget {
  final String text;
  final String? route;
  final VoidCallback? onPressed;
  final TextStyle textStyle;

  const CustomTextButton({
    super.key,
    required this.text,
    this.route,
    this.onPressed,
    required this.textStyle,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  double _opacity = 1.0;

  void _handlePress() {
    setState(() {
      _opacity = 0.5;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    if (widget.onPressed != null) {
      widget.onPressed!();
    } else if (widget.route != null) {
      Navigator.pushNamed(context, widget.route!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColorWithOpacity = widget.textStyle.color?.withOpacity(_opacity) ?? Colors.black;

    return GestureDetector(
      onTapDown: (_) => setState(() => _opacity = 0.5),
      onTapUp: (_) => setState(() => _opacity = 1.0),
      onTapCancel: () => setState(() => _opacity = 1.0),
      child: TextButton(
        onPressed: _handlePress,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          splashFactory: NoSplash.splashFactory,
          foregroundColor: Colors.transparent,
          overlayColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          widget.text,
          style: widget.textStyle.copyWith(color: textColorWithOpacity),
        ),
      ),
    );
  }
}
