import 'package:flutter/material.dart';
import 'package:cashier_project/theme/app_theme.dart';

class AnimatedCounter extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const AnimatedCounter({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCounterButton(
          icon: Icons.remove_circle_outline,
          onPressed: onDecrement,
          color: AppTheme.deepRed,
        ),
        SizedBox(
          width: 30,
          child: TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: count),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) {
              return Text(
                '$value',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        _buildCounterButton(
          icon: Icons.add_circle_outline,
          onPressed: onIncrement,
          color: AppTheme.vibrantOrange,
        ),
      ],
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
      ),
    );
  }
}
