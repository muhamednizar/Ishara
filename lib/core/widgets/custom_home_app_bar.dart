import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_text_style.dart';
import 'package:ishara/features/home/presentation/views/widgets/fav_videos.dart';

AppBar buildCustomHomeAppBar(
    {bool isBack = true, bool isFav = false, required BuildContext context, String? title}) {
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
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          )
        : SizedBox.shrink(),
    title: Text(
      'Introductory Videos',
      style: MediaQuery.of(context).size.width > 600
          ? TextStyles.semiBold24.copyWith(color: Colors.white)
          : TextStyles.semiBold24.copyWith(color: Colors.white, fontSize: 20),
    ),
    actions: [
      isFav
          ? Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Color(0xff0D47A1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FavVideos.routeName);
                  },
                  icon: Icon(Icons.star_border, color: Colors.white),
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
