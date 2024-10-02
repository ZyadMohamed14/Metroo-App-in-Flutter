import 'package:flutter/material.dart';

class MetrooAppButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isLarge;

  const MetrooAppButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isLarge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent, // Button color
        padding: isLarge
            ? const EdgeInsets.symmetric(vertical: 16, horizontal: 32)
            : const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4, // Button shadow
      ),
    );
  }
}