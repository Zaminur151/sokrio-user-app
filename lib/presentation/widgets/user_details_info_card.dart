import 'package:flutter/material.dart';
import 'package:sokrio_user/domain/entities/user.dart';
import 'package:sokrio_user/presentation/widgets/user_info_tile.dart';

class UserDetailsInfoCard extends StatelessWidget {
  final User user;
  const UserDetailsInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.shade100, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              UserInfoTile(
                icon: Icons.person_outline_rounded,
                title: 'First Name',
                value: user.firstName,
              ),
              _buildDivider(),
              UserInfoTile(
                icon: Icons.person_outline_rounded,
                title: 'Last Name',
                value: user.lastName,
              ),
              _buildDivider(),
              UserInfoTile(
                icon: Icons.email_outlined,
                title: 'Email Address',
                value: user.email,
              ),
              _buildDivider(),
              UserInfoTile(
                icon: Icons.phone_android_rounded,
                title: 'Phone Number',
                value: user.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 68,
      endIndent: 16,
      color: Colors.grey.shade100,
    );
  }
}
