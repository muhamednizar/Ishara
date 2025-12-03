  import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, {required String text}) {
    return AppBar(
      centerTitle: true,
      title: Text(text),
      leading: IconButton(
        onPressed: () {
          if(Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

