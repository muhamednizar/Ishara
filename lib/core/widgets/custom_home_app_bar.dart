import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_text_style.dart';

AppBar buildCustomHomeAppBar({bool isBack = true, required BuildContext context}) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 70,
      leading: isBack ? Align(
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
      ):SizedBox.shrink(),
      title: Text(
        'Introductory Videos',
        style: TextStyles.semiBold24.copyWith(color: Colors.white),
      ),
      actions: [
        Container(
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
              onPressed: () {},
              icon: Icon(Icons.star_border, color: Colors.white),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ],
      toolbarHeight: 90,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(48),
        ),
      ),
    );
  }
