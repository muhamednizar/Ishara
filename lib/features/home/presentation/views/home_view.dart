import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';
import 'package:ishara/features/camera/presentation/views/camera_view.dart';
import 'package:ishara/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:ishara/features/settings/presentation/views/settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String routeName = 'home_view';
  String getTitle(int selectedIndex) {
    if (selectedIndex == 0) {
      return 'Home'.tr();
    } else if (selectedIndex == 1) {
      return 'Camera'.tr();
    } else if (selectedIndex == 2) {
      return 'Profile'.tr();
    } else {
      return '';
    }
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeViewBody(),
    CameraView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: buildCustomHomeAppBar(
        isBack: false,
        isFav: true,
        showProfileAvatar: _selectedIndex == 0,
        context: context,
        title: widget.getTitle(_selectedIndex),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        // إضافة هوامش لجعل البار يبدو معلقاً (اختياري)
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          // 2. الظل هو الذي سيظهر التدوير
          boxShadow: [
            BoxShadow(
              color: theme.dividerColor.withOpacity(0.15), // لون الظل
              spreadRadius: 5,
              blurRadius: 13,
              offset: const Offset(0, -2), // اتجاه الظل للأعلى قليلاً
            ),
          ],
        ),
        // 3. ClipRRect يقص العناصر التي تخرج عن الحواف الدائرية
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            key: ValueKey(context.locale.toString()),
            iconSize: 20,
            textSize: 16,
            backgroundColor: theme.cardColor,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            activeColor: theme.colorScheme.onPrimary,
            tabBackgroundColor: AppColors.primaryColor,
            gap: 8,
            padding: const EdgeInsets.all(16),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() => _selectedIndex = index);
            },
            tabs: [
              GButton(icon: Icons.home_outlined, text: 'Home'.tr()),
              GButton(icon: Icons.camera_alt_outlined, text: 'Camera'.tr()),
              GButton(icon: Icons.person_outline, text: 'Profile'.tr()),
            ],
          ),
        ),
      ),
    );
  }
}
