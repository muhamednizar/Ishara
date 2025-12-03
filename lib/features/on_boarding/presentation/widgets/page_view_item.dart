import 'package:flutter/material.dart';
import 'package:ishara/core/widgets/custom_button.dart';
import 'package:ishara/features/home/home_view.dart';

class PageViewItem extends StatelessWidget {
  PageViewItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    this.onPressed,
    this.isVisible = true,
  });
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                  visible: isVisible,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: GestureDetector(onTap: () {
                    Navigator.pushReplacementNamed(context, HomeView.routeName);
                  }, child: Text('Skip', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))),
            ],
          ),
          SizedBox(height: 25),
          Image.asset(
            image,
            width: 350,
            height: 350,
          ),
          SizedBox(height: 37),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          CustomButton(
            text: buttonText,
            onPressed: onPressed ?? () {},
            width: 343,
            height: 48,
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
