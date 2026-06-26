import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokrio_user/presentation/providers/user_provider.dart';

class SearchField extends StatelessWidget {
  final TextEditingValue value;
  const SearchField({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<UserProvider>();
    return TextField(
      controller: provider.searchController,
      decoration: InputDecoration(
        hintText: 'Search by name...',
        prefixIcon: Icon(
          Icons.search_rounded,
          color: theme.colorScheme.primary,
        ),
        suffixIcon: value.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear_rounded),
                onPressed: () {
                  provider.searchController.clear();
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade100, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
