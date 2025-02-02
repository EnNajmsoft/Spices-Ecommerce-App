import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';
import '../../core/routes/app_routes.dart';
import 'components/popular_packs.dart'; // تأكد من استيراد المكون

class PopularPackPage extends StatelessWidget {
  const PopularPackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Packs'),
        leading: const AppBackButton(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: PopularPacks(), // استخدام مكون PopularPacks
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(AppDefaults.padding * 2),
                decoration: const BoxDecoration(
                  color: Colors.white60,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.createMyPack);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.shoppingBag),
                      const SizedBox(width: AppDefaults.padding),
                      const Text('Create Own Pack'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
