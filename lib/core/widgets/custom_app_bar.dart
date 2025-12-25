  import 'package:flutter/material.dart';
import 'package:ishara/core/utils/app_text_style.dart';

AppBar buildAppBar(BuildContext context, {required String text, bool isBack = true}) {
    return AppBar(
      centerTitle: true,
      title: Text(text,style: TextStyles.semiBold24,),
      leading: isBack ? IconButton(
        onPressed: () {
          if(Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ):SizedBox.shrink(),
    );
  }

