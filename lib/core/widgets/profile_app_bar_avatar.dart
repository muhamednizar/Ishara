import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/core/utils/profile_avatar_storage.dart';

class ProfileAppBarAvatar extends StatefulWidget {
  const ProfileAppBarAvatar({super.key});

  @override
  State<ProfileAppBarAvatar> createState() => _ProfileAppBarAvatarState();
}

class _ProfileAppBarAvatarState extends State<ProfileAppBarAvatar> {
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    _loadPhoto();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadPhoto();
  }

  Future<void> _loadPhoto() async {
    final session = await LocalSessionService.instance.readSession();
    final path = session?.photoPath;
    final exists = await ProfileAvatarStorage.fileExists(path);
    if (!mounted) return;
    setState(() => _photoPath = exists ? path : null);
  }

  void _showEnlargedPhoto() {
    if (_photoPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No profile picture set'.tr())),
      );
      return;
    }

    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (dialogContext) => GestureDetector(
        onTap: () => Navigator.pop(dialogContext),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(_photoPath!),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(dialogContext),
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: _showEnlargedPhoto,
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade400,
            backgroundImage:
                _photoPath != null ? FileImage(File(_photoPath!)) : null,
            child: _photoPath == null
                ? const Icon(Icons.person, color: Colors.white, size: 22)
                : null,
          ),
        ),
      ),
    );
  }
}
