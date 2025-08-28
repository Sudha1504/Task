import 'package:flutter/material.dart';

class HomeFloatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color bgClr;

  const HomeFloatButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.bgClr,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed,
        child: child,
        backgroundColor: bgClr,
    );
  }
}
