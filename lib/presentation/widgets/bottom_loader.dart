import 'package:flutter/material.dart';
import 'package:sokrio_user/presentation/providers/user_provider.dart';

class BottomLoader extends StatelessWidget {
  final UserProvider userProvider;
  const BottomLoader({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (userProvider.isLoadingMore) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      );
    }

    if (userProvider.errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              userProvider.errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
            const SizedBox(height: 6),
            ElevatedButton(
              onPressed: () {
                userProvider.clearError();
                userProvider.fetchUsers();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                visualDensity: VisualDensity.compact,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (userProvider.hasReachedMax && userProvider.searchQuery.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            'No more user available to load',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
