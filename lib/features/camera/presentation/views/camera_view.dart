import 'package:flutter/material.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';
import 'package:ishara/features/camera/presentation/views/widgets/camera_view_body.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});
  static const String routeName = 'camera_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CameraViewBody(),
    );
  }
}