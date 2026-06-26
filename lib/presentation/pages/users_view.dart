import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokrio_user/presentation/pages/user_details_view.dart';
import 'package:sokrio_user/presentation/providers/user_provider.dart';
import 'package:sokrio_user/presentation/widgets/bottom_loader.dart';
import 'package:sokrio_user/presentation/widgets/empty_card.dart';
import 'package:sokrio_user/presentation/widgets/error_card.dart';
import 'package:sokrio_user/presentation/widgets/list_skeleton.dart';
import 'package:sokrio_user/presentation/widgets/search_field.dart';
import 'package:sokrio_user/presentation/widgets/user_list_card.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    final provider = context.read<UserProvider>();
    provider.searchController.clear();
    await provider.fetchUsers(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<UserProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Sokrio Users')),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: provider.searchController,
                builder: (context, value, child) {
                  return SearchField(value: value);
                },
              ),
            ),

            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.isLoading && userProvider.users.isEmpty) {
                    return ListSkeleton();
                  }
                  if (userProvider.errorMessage != null &&
                      userProvider.users.isEmpty) {
                    return ErrorCard(
                      message: userProvider.errorMessage!,
                      onRetry: () => userProvider.fetchUsers(isRefresh: true),
                    );
                  }
                  if (userProvider.users.isEmpty) {
                    return EmptyCard(
                      query: userProvider.searchQuery,
                      onClear: () {
                        userProvider.searchController.clear();
                      },
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    color: theme.colorScheme.primary,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels >=
                            scrollInfo.metrics.maxScrollExtent - 200) {
                          userProvider.fetchUsers();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        itemCount: userProvider.users.length + 1,
                        itemBuilder: (context, index) {
                          if (index < userProvider.users.length) {
                            final user = userProvider.users[index];
                            return UserListCard(
                              user: user,
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserDetailsView(user: user),
                                  ),
                                );
                              },
                            );
                          }
                          return BottomLoader(userProvider: userProvider);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
