import 'package:flutter/material.dart';
import 'package:cashier_project/theme/app_theme.dart';

class CartButton extends StatelessWidget {
  final int totalItems;
  final VoidCallback onPressed;

  const CartButton({
    super.key,
    required this.totalItems,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.darkBlue,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkBlue.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: AppTheme.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Total: $totalItems item${totalItems != 1 ? 's' : ''}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.goldYellow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: AppTheme.darkBlue,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
