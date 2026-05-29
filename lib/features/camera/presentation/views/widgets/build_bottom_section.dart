import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/features/camera/presentation/manager/camera_cubit.dart';
import 'package:ishara/features/camera/presentation/manager/camera_state.dart';

class BuildBottomSection extends StatelessWidget {
  const BuildBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CameraCubit, CameraState>(
      // 🎯 أول تعديل محوري: إجبار الـ BlocBuilder إنه يستمع ويعيد بناء الشاشة مع كل الـ emits بدون كاش
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        final cubit = context.read<CameraCubit>();

        // قراءة النص الآمنة
        String text = cubit.fullText;
        if (state is TranslationSuccess) {
          text = state.fullText;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, -5),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                  border:
                      Border.all(color: theme.dividerColor.withOpacity(0.4)),
                ),
                child: Builder(builder: (ctx) {
                  final isAr = Localizations.localeOf(ctx).languageCode == 'ar';
                  return Text(
                    text.isEmpty ? 'translate_hint'.tr() : text,
                    key:
                        ValueKey(text + Localizations.localeOf(ctx).toString()),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: text.isEmpty
                          ? theme.disabledColor
                          : theme.colorScheme.onSurface,
                    ),
                    textAlign: isAr ? TextAlign.right : TextAlign.left,
                  );
                }),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زرار مسح النص كله
                  IconButton(
                    onPressed: () => cubit.clearText(),
                    icon: const Icon(Icons.delete_outline, color: Colors.grey),
                    iconSize: 30,
                    tooltip: 'Clear All'.tr(),
                  ),

                  // زرار مسح آخر حرف (Backspace)
                  IconButton(
                    onPressed: () => cubit.removeLastCharacter(),
                    icon: const Icon(Icons.backspace_outlined,
                        color: Colors.redAccent),
                    iconSize: 30,
                    tooltip: 'Clear Char'.tr(),
                  ),

                  // زرار المسافة (Space)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          theme.colorScheme.primary.withOpacity(0.18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    onPressed: () => cubit.addSpace(),
                    child: Text(
                      'Space'.tr(),
                      style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
