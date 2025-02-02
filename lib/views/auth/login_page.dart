import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import 'components/dont_have_account_row.dart';
import 'components/login_header.dart';
import 'components/login_page_form.dart';
import 'components/social_logins.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoginPageHeader(),
                LoginPageForm(),
                const SizedBox(height: AppDefaults.padding),
                // const SocialLogins(),
                const DontHaveAccountRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
