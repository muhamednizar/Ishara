import 'package:flutter/material.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/core/widgets/profile_app_bar_avatar.dart';
import 'package:ishara/features/home/presentation/views/widgets/fav_videos.dart';

AppBar buildCustomHomeAppBar({
  bool isBack = true,
  bool isFav = false,
  bool showProfileAvatar = false,
  required BuildContext context,
  String? title,
}) {
  final theme = Theme.of(context);

  return AppBar(
    automaticallyImplyLeading: false,
    leadingWidth: 70,
    leading: isBack
        ? Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 39,
                height: 35,
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          )
        : showProfileAvatar
            ? const ProfileAppBarAvatar()
            : const SizedBox.shrink(),
    title: Text(
      title ?? 'Introductory Videos',
      style: theme.appBarTheme.titleTextStyle ??
          Styles.semiBold24.copyWith(color: Colors.white, fontSize: 20),
    ),
    actions: [
      isFav
          ? Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
                border:
                    Border.all(color: theme.colorScheme.onPrimary, width: 1.5),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FavVideos.routeName);
                  },
                  icon: Icon(Icons.star_border,
                      color: theme.colorScheme.onPrimary),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ),
            )
          : SizedBox.shrink(),
    ],
    toolbarHeight: 90,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(48),
      ),
    ),
  );
}
