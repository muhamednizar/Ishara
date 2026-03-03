import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ishara/api_video/custom_appbar.dart';
import 'package:ishara/api_video/favorite_screen.dart';
import 'package:ishara/core/utils/app_color.dart';
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

  // 1. المفتاح السحري اللي هيخلي صفحة الهوم تتحدث
  Key homeKey = UniqueKey();

  // 2. دالة الـ Refresh اللي بتشتغل لما تشد الشاشة
  Future<void> _handleRefresh() async {
    setState(() {
      // تغيير الـ Key بيجبر فلاتر يمسح صفحة الهوم القديمة ويبنيها من جديد بالداتا الجديدة
      homeKey = UniqueKey();
    });
    // بنستنى ثانية عشان المستخدم يشوف علامة الرفريش وهي بتلف
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    // 3. القائمة حطيناها جوه الـ build عشان تستقبل الـ homeKey المتغير
    final List<Widget> _pages = <Widget>[
      HomeViewBody(key: homeKey), // هنا ربطنا المفتاح بالبودي
      const Center(child: Text('Camera Page')),
      const SettingsView(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Introductory Videos',
        showBackButton: false,
        trailing: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoriteScreen()),
            ).then((_) => setState(() {}));
          },
          child: const CircleAvatar(
            backgroundColor: Color(0xFF1976D2),
            radius: 18,
            child: Icon(Icons.star, color: Colors.white, size: 18),
          ),
        ),
      ),
      
      // 4. تغليف البادي بالرفريش (هيظهر بس لو احنا في صفحة الهوم)
      body: _selectedIndex == 0 
          ? RefreshIndicator(
              onRefresh: _handleRefresh,
              color: AppColors.primaryColor, // لون العلامة اللي بتلف
              backgroundColor: Colors.white,
              child: _pages[_selectedIndex],
            )
          : _pages[_selectedIndex],
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
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