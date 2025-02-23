import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/constants.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin,
      color: AppColors.scaffoldBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomAppBarItem(
            iconLocation: AppIcons.home,
            isActive: currentIndex == 0,
            onTap: () => onNavTap(0),
          ),
          _buildBottomAppBarItem(
            iconLocation: AppIcons.menu,
            isActive: currentIndex == 1,
            onTap: () => onNavTap(1),
          ),
          const Padding(
            padding: EdgeInsets.all(AppDefaults.padding * 2),
            child: SizedBox(width: AppDefaults.margin),
          ),
          _buildBottomAppBarItem(
            iconLocation: AppIcons.save,
            isActive: currentIndex == 3,
            onTap: () => onNavTap(3),
          ),
          _buildBottomAppBarItem(
            iconLocation: AppIcons.profile,
            isActive: currentIndex == 4,
            onTap: () => onNavTap(4),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAppBarItem({
    required String iconLocation,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding),
        child: SvgPicture.asset(
          iconLocation,
          width: 28, // زيادة حجم الأيقونة
          height: 28,
          colorFilter: ColorFilter.mode(
            isActive ? AppColors.primary : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
