import 'package:flutter/material.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';
import 'package:ishara/features/home/presentation/views/widgets/fav_videos_view_body.dart';

class FavVideosView extends StatelessWidget {
  const FavVideosView({super.key});
  static const String routeName = 'fav_videos_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomHomeAppBar(isBack: true, context: context),
      body: const FavVideosViewBody(),
    );
  }
}