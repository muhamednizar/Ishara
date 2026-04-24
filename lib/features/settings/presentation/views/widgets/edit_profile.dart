import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';
import 'package:ishara/core/widgets/custom_text__form_field.dart';
import 'package:ishara/features/settings/presentation/views/widgets/cubit/profile_edit_cubit.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});
  static const String routeName = 'edit_profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _fullNameController = TextEditingController();
  String? _displayName;
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final session = await LocalSessionService.instance.readSession();
    if (!mounted) return;
    setState(() {
      _displayName = session?.name;
      _photoPath = session?.photoPath;
      if (_displayName != null && _displayName!.isNotEmpty) {
        _fullNameController.text = _displayName!;
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileEditCubit, ProfileEditState>(
      listener: (context, state) {
        if (state is ProfileEditNameSuccess) {
          _fullNameController.clear();
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
          _loadSession();
        }
        if (state is ProfileEditNameFailure) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
        if (state is ProfileEditPictureSuccess) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile picture updated')),
          );
          _loadSession();
        }
        if (state is ProfileEditPictureFailure) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) => Scaffold(
        appBar: buildCustomHomeAppBar(
            context: context, isBack: true, title: 'Edit Profile'),
        body: Column(
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              backgroundImage: _photoPath != null && _photoPath!.isNotEmpty
                  ? FileImage(File(_photoPath!))
                  : null,
              child: IconButton(
                onPressed: () async {
                  try {
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedFile != null) {
                      context
                          .read<ProfileEditCubit>()
                          .uploadProfilePicture(pickedFile.path);
                    }
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextFormField(
                controller: _fullNameController,
                hintText: _displayName ?? 'Full Name',
                keyboardType: TextInputType.name,
                suffixIcon: Icon(
                  Icons.edit_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _fullNameController,
              builder: (context, value, _) {
                final canSave = value.text.trim().length >= 3;
                return CustomButton(
                  enabled: canSave,
                  text: 'Save',
                  onPressed: () {
                    final newName = _fullNameController.text.trim();
                    final currentName = _displayName ?? '';
                    if (newName != currentName) {
                      context.read<ProfileEditCubit>().editProfileName(newName);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No changes to save')),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
