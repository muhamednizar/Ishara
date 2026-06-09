  import 'package:flutter/material.dart';
import 'package:ishara/core/utils/styles.dart';

AppBar buildAppBar(BuildContext context, {required String text, bool isBack = true}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        text,
        style: Styles.semiBold24.copyWith(color: isDark ? Colors.white : Colors.black),
      ),
      leading: isBack
          ? IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            )
          : const SizedBox.shrink(),
    );
  }

