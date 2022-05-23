import 'package:flutter/material.dart';

class FunctionIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const FunctionIconButton(
      {required this.icon,
      required this.label,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon),
              Text(
                label,
              )
            ],
          ),
        ),
      ),
    );
  }
}
