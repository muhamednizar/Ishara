import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ishara/features/camera/presentation/views/widgets/build_bottom_section.dart';
import 'package:ishara/features/camera/presentation/views/widgets/build_toggle_buttons.dart';
import 'package:ishara/features/camera/presentation/manager/camera_cubit.dart';

class CameraViewBody extends StatefulWidget {
  const CameraViewBody({super.key});

  @override
  State<CameraViewBody> createState() => _CameraViewBodyState();
}

class _CameraViewBodyState extends State<CameraViewBody> {
  bool isLettersMode = true;
  bool isFrontCamera = true;

  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  Timer? _processTimer;
  String? _lastAvailablePath;

  // 🎯 التعديل الذهبي: حجز مرجع ثابت للـ Cubit لمنع تشتت الـ Context مع التايمر
  late CameraCubit _cameraCubit;

  @override
  void initState() {
    super.initState();
    // 🎯 تثبيت الـ Cubit الموحد فوراً عند بدء تشغيل الشاشة
    _cameraCubit = context.read<CameraCubit>();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      CameraDescription selectedCamera = cameras.firstWhere(
        (camera) =>
            camera.lensDirection ==
            (isFrontCamera
                ? CameraLensDirection.front
                : CameraLensDirection.back),
        orElse: () => cameras.first,
      );

      await _cameraController?.dispose();

      _cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
        _startFrameProcessing();
      }
    } catch (e) {
      debugPrint("Error initializing camera: $e");
    }
  }

  void _toggleCamera() {
    setState(() {
      _isCameraInitialized = false;
      isFrontCamera = !isFrontCamera;
    });
    _initCamera();
  }

  void _startFrameProcessing() {
    _processTimer?.cancel();
    _processTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (!_isCameraInitialized || _cameraController == null) return;
      if (_cameraController!.value.isTakingPicture) return;

      try {
        final XFile picture = await _cameraController!.takePicture();
        _lastAvailablePath = picture.path;

        if (mounted && _lastAvailablePath != null) {
          // 🎯 التعديل السحري: نداء الـ Cubit المحجوز مباشرة بدون الـ context المتغير
          _cameraCubit.processFrame(
            imagePath: _lastAvailablePath!,
            isLettersMode: isLettersMode,
          );
        }
      } catch (e) {
        debugPrint("Error capturing frame safely: $e");
      }
    });
  }

  @override
  void dispose() {
    _processTimer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 20),

        // أزرار التبديل بين الحروف والأرقام
        BuildToggleButtons(onToggle: (isLetters) {
          setState(() {
            isLettersMode = isLetters;
          });
          // استخدام الـ Cubit الثابت هنا برضه
          _cameraCubit.clearText();
        }),

        const SizedBox(height: 20),

        // عرض الكاميرا
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: theme.dividerColor.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isCameraInitialized && _cameraController != null)
                    Positioned.fill(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _cameraController!.value.previewSize!.height,
                          height: _cameraController!.value.previewSize!.width,
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                    )
                  else
                    Center(
                        child: CircularProgressIndicator(
                            color: theme.colorScheme.primary)),

                  // زرار تبديل الكاميرا
                  Positioned(
                    top: 15,
                    right: 15,
                    child: CircleAvatar(
                      backgroundColor: theme.cardColor.withOpacity(0.6),
                      child: IconButton(
                        icon: Icon(Icons.flip_camera_ios,
                            color: theme.colorScheme.onSurface),
                        onPressed: _toggleCamera,
                      ),
                    ),
                  ),

                  // إطار التركيز
                  Positioned(
                    top: 40,
                    bottom: 40,
                    left: 40,
                    right: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: theme.colorScheme.onSurface.withOpacity(0.4),
                            width: 1.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // المستطيل الأبيض
        const BuildBottomSection(),
      ],
    );
  }
}
