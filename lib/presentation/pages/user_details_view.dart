import 'package:flutter/material.dart';
import 'package:sokrio_user/domain/entities/user.dart';
import 'package:sokrio_user/presentation/widgets/quick_action_button.dart';
import 'package:sokrio_user/presentation/widgets/top_profile_picture_card.dart';
import 'package:sokrio_user/presentation/widgets/user_details_info_card.dart';

class UserDetailsView extends StatelessWidget {
  final User user;

  const UserDetailsView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            TopProfilePictureCard(user: user),
            const SizedBox(height: 16),
            Text(
              user.fullName,
              style: theme.textTheme.headlineLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'User ID: #${user.id}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuickActionButton(
                  icon: Icons.phone_rounded,
                  label: 'Call User',
                  color: Colors.green.shade600,
                  snackbarMessage: 'Dialing ${user.phone}...',
                ),
                const SizedBox(width: 20),
                QuickActionButton(
                  icon: Icons.email_rounded,
                  label: 'Email User',
                  color: theme.colorScheme.primary,
                  snackbarMessage: 'Opening compose mail to ${user.email}...',
                ),
              ],
            ),
            const SizedBox(height: 32),
            UserDetailsInfoCard(user: user),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
