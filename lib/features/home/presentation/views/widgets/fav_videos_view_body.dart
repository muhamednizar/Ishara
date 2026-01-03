import 'package:flutter/material.dart';
import 'package:ishara/features/home/presentation/views/widgets/video_item.dart';

class FavVideosViewBody extends StatelessWidget {
  const FavVideosViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }
}
