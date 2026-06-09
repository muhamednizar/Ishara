import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';
import 'package:ishara/features/home/presentation/manager/home_cubit.dart';
import 'package:ishara/features/home/presentation/manager/home_state.dart';
import 'package:ishara/features/home/presentation/views/widgets/video_item.dart';

class FavVideos extends StatelessWidget {
  const FavVideos({super.key});
  static const String routeName = 'fav_videos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استخدمنا الـ App Bar بتاعك
      appBar: buildCustomHomeAppBar(isBack: true, context: context, title: 'Favorite videos'.tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  // بنجيب الفيديوهات اللي معمول لها Favorite فقط من الـ Cubit
                  final favVideos = context.read<HomeCubit>().allVideosList
                      .where((v) => v.isFav)
                      .toList();

                  // لو مفيش فيديوهات مفضلة، بنعرض رسالة شيك
                  if (favVideos.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                          const SizedBox(height: 10),
                          Text("No favorite videos yet".tr(), 
                              style: const TextStyle(color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                    );
                  }

                  // لو فيه فيديوهات، بنعرضهم في Grid أو List
                  return GridView.builder(
                    itemCount: favVideos.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // فيديوهين في كل سطر
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.8, // تظبيط أبعاد الكارت
                    ),
                    itemBuilder: (context, index) {
                      return VideoItemWidget(video: favVideos[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}