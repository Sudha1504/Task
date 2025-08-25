import 'package:flutter/material.dart';

class HomeTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  const HomeTextButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child:
              isLoading
                  ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 2,
                    ),
                  )
                  : Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
        ),
      ),
    );
  }
}
