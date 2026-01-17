import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_text_style.dart';
import 'package:ishara/features/home/presentation/views/widgets/alphabit.dart';
import 'package:ishara/features/home/presentation/views/widgets/video_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // slivers هي القائمة التي تقبل عناصر من نوع Sliver فقط
      slivers: [
        // --- 1. الجزء العلوي (البنرات + العنوان) ---
        // نضعهم في SliverToBoxAdapter لأنهم عناصر عادية لها طول محدد
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // البنرات (Scroll أفقي داخل Scroll عمودي)
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
                          image: NetworkImage(
                              "https://via.placeholder.com/300x150"),
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
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const VideoItemWidget();
              },
            ),
          ),
        ),
        // --- 3. أي عناصر أخرى في الأسفل ---
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Sign language',
                style: TextStyles.semiBold24.copyWith(fontSize: 20)),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 132,
            width: 343,
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
      SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }
}
