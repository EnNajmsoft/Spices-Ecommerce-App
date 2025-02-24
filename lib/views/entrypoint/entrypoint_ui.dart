import 'package:Spices_Ecommerce_app/views/OrdersPage.dart';
import 'package:Spices_Ecommerce_app/views/home/home_screen.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../cart/cart_page.dart';
import '../profile/profile_page.dart';
import '../save/save_page.dart';

/// هذه الصفحة ستحتوي على جميع تبويبات التنقل السفلية
class EntryPointUI extends StatefulWidget {
  const EntryPointUI({super.key});

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  /// الصفحة الحالية
  int currentIndex = 0;

  /// عند النقر على تبويب التنقل السفلي
  void onBottomNavigationTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  /// جميع الصفحات
  List<Widget> pages = [
    HomeScreen(),
    OrdersPage(),
    CartPage(isHomePage: true),
    SavePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.scaffoldBackground,
            child: child,
          );
        },
        duration: AppDefaults.duration,
        child: pages[currentIndex],
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 12),
        child: FloatingActionButton(
          onPressed: () {
            onBottomNavigationTap(2);
          },
          backgroundColor: AppColors.primary,
          elevation: 8,
          shape: const CircleBorder(),
          child: SvgPicture.asset(
            AppIcons.cart,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 32,
            height: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return ClipRRect(
      // لتطبيق الانحناء على الحواف العلوية
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40)), // تعديل قيمة 20 لزيادة أو تقليل الانحناء
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: AppDefaults.margin,
        color: const Color.fromARGB(255, 255, 255, 255), // تغيير لون الشريط السفلي إلى الأبيض
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomAppBarItem(
              iconLocation: AppIcons.home,
              isActive: currentIndex == 0,
              onTap: () => onBottomNavigationTap(0),
              isHomeIcon: true,
            ),
            _buildBottomAppBarItem(
              iconLocation: AppIcons.menu,
              isActive: currentIndex == 1,
              onTap: () => onBottomNavigationTap(1),
            ),
            const SizedBox(width: 48),
            _buildBottomAppBarItem(
              iconLocation: AppIcons.save,
              isActive: currentIndex == 3,
              onTap: () => onBottomNavigationTap(3),
            ),
            _buildBottomAppBarItem(
              iconLocation: AppIcons.profile,
              isActive: currentIndex == 4,
              onTap: () => onBottomNavigationTap(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAppBarItem({
    required String iconLocation,
    required bool isActive,
    required VoidCallback onTap,
    bool isHomeIcon = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppDefaults.padding * 0.5),
        child: SvgPicture.asset(
          iconLocation,
          width: isHomeIcon ? 36 : 32,
          height: isHomeIcon ? 36 : 32,
          colorFilter: ColorFilter.mode(
            isActive ? AppColors.primary : Colors.grey[600]!,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
