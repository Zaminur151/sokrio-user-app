import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final String query;
  final VoidCallback? onClear;
  const EmptyCard({super.key, required this.query, this.onClear});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 72,
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              query.isNotEmpty ? 'No Results for "$query"' : 'No Users Found',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              query.isNotEmpty
                  ? 'Double-check your spelling or try typing something else.'
                  : 'Check back later or try refreshing.',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            if (query.isNotEmpty) ...[
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.clear_all_rounded),
                label: const Text('Clear Search Filter'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
