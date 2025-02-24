import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';
import 'profile_header_options.dart';

class ProfileHeader extends StatefulWidget {
  // Make it StatefulWidget
  const ProfileHeader({
    super.key,
  });

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String _userName = 'زائر كريم'; // Default values
  String _userId = 'N/A000000456';
  String _profileImageUrl =
      'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? _userName;
      _userId = prefs.getString('userId') ?? _userId;
      _profileImageUrl = prefs.getString('profileImageUrl') ?? _profileImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background
        Image.asset('assets/images/profile_page_background.png'),

        /// Content
        Column(
          children: [
            AppBar(
              title: const Text('بروفايلي'),
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            _UserData(
              userName: _userName,
              userId: _userId,
              profileImageUrl: _profileImageUrl,
            ),
            const ProfileHeaderOptions()
          ],
        ),
      ],
    );
  }
}

class _UserData extends StatelessWidget {
  const _UserData({
    required this.userName,
    required this.userId,
    required this.profileImageUrl,
  });

  final String userName;
  final String userId;
  final String profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        children: [
          const SizedBox(width: AppDefaults.padding),
          SizedBox(
            width: 100,
            height: 100,
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: NetworkImageWithLoader(profileImageUrl),
              ),
            ),
          ),
          const SizedBox(width: AppDefaults.padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'ID: $userId',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
