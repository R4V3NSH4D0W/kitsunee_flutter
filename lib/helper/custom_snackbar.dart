import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 1),
    Color backgroundColor = Colors.pink,
    Color textColor = Colors.white,
    IconData? icon,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        margin: const EdgeInsets.all(0),
        action: onActionPressed != null
            ? SnackBarAction(
                label: actionLabel ?? 'Undo',
                onPressed: onActionPressed,
                textColor: Colors.white,
              )
            : null,
      ),
    );
  }
}
