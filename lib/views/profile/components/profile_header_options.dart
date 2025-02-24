import 'package:Spices_Ecommerce_app/views/profile/address/address_page.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import 'profile_squre_tile.dart';

class ProfileHeaderOptions extends StatelessWidget {
  const ProfileHeaderOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDefaults.borderRadius,
        boxShadow: AppDefaults.boxShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfileSqureTile(
            label: 'طلباتي',
            icon: AppIcons.truckIcon,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.ordersPage);
            },
          ),
          ProfileSqureTile(
            label: 'عنواني',
            icon: AppIcons.homeProfile,
            onTap: () async {
              // استخدام await للحصول على نتيجة الصفحة
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddressPage()),
              );
              if (result != null) {
                // هنا يمكنك استخدام النتيجة (العنوان)
                print('New Address: ${result.street}, ${result.city}, ${result.postalCode}, ${result.country}');
              }
            },
          ),
        ],
      ),
    );
  }
}