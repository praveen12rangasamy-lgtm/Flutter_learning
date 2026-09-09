import 'package:flutter/material.dart';

import '../../routes/route_names.dart';
import '../constants/app_colors.dart';

class AppMenuActions extends StatelessWidget {
  const AppMenuActions({super.key});

  /// Displays the logout confirmation popup dialog.
  /// If confirmed, navigates back to the sign-in/login screen and clears the stack.
  static Future<void> showLogoutConfirmation(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.errorSurface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.error,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to log out of your account?',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.signIn,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      tooltip: 'Menu',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      color: Colors.white,
      elevation: 6,
      offset: const Offset(0, 48),
      onSelected: (value) {
        if (value == 'logout') {
          showLogoutConfirmation(context);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: 20,
              ),
              SizedBox(width: 12),
              Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
