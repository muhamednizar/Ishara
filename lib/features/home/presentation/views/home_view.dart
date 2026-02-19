import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ishara/core/utils/app_color.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';
import 'package:ishara/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:ishara/features/settings/presentation/views/settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String routeName = 'home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeViewBody(),
    Center(child: Text('Camera Page')),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomHomeAppBar(isBack: false, isFav: true, context: context),
      body: _pages[_selectedIndex],
      
      bottomNavigationBar: Container(
      
        // إضافة هوامش لجعل البار يبدو معلقاً (اختياري)
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          // 2. الظل هو الذي سيظهر التدوير
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2), // لون الظل
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, -3), // اتجاه الظل للأعلى قليلاً
            ),
          ],
        ),
        // 3. ClipRRect يقص العناصر التي تخرج عن الحواف الدائرية
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            iconSize: 20,
            textSize: 16,
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Colors.white,
            tabBackgroundColor: AppColors.primaryColor,
            gap: 8,
            padding: const EdgeInsets.all(16),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              GButton(icon: Icons.home_outlined, text: 'Home'),
              GButton(icon: Icons.camera_alt_outlined, text: 'Camera'),
              GButton(icon: Icons.person_outline, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}