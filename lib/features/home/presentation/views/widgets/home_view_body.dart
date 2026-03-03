import 'package:flutter/material.dart';
import 'package:ishara/api_video/video_grid.dart';
import 'package:ishara/core/utils/app_text_style.dart';


class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        // --- الجزء العلوي (البنرات + عنوان Videos) ---
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // البنرات
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: NetworkImage("https://via.placeholder.com/300x150"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Videos',
                  style: TextStyles.semiBold24.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),

        // --- 2. استدعاء الفيديوهات هنا ---
        // بما إن الـ VideoGridScreen بترجع GridView، هنلفها بـ SliverToBoxAdapter 
        // ونحدد لها طول ثابت (Height) عشان الـ Scroll العام يشتغل صح
        SliverToBoxAdapter(
          child: SizedBox(
            height: 250, // يمكنك تعديل الارتفاع حسب ما تراه مناسباً
            child:  VideoGridScreen(),
          ),
        ),

       // --- 3. بقية العناصر (Sign language) ---
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Sign language',
                style: TextStyles.semiBold24.copyWith(fontSize: 20)),
          ),
        ),
        
        SliverToBoxAdapter(child: const SizedBox(height: 10)),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 132,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
        ),

        SliverToBoxAdapter(child: const SizedBox(height: 10)),
      ],
    );
  }
}