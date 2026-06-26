import 'package:flutter/material.dart';
import 'package:sokrio_user/domain/entities/user.dart';

class TopProfilePictureCard extends StatelessWidget {
  final User user;
  const TopProfilePictureCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 260,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          child: Hero(
            tag: 'avatar_${user.id}',
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 58,
                backgroundImage: NetworkImage(user.avatar),
                backgroundColor: Colors.grey.shade200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
