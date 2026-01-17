import 'package:flutter/material.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';
import 'package:ishara/features/home/presentation/views/widgets/video_item.dart';

class FavVideos extends StatelessWidget {
  const FavVideos({super.key});
  static const String routeName = 'fav_videos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomHomeAppBar(isBack: true, context: context),
      body : GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (BuildContext context, int index) {
        return const Center(child: VideoItemWidget());
      },
    ),
    );
  }
}
