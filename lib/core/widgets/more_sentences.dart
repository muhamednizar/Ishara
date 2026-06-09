import 'package:flutter/material.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';

class MoreSentences extends StatelessWidget {
  const MoreSentences({super.key});
  static const String routeName = 'more-sentences';
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: buildCustomHomeAppBar(
        title: 'More Sentences',
        context: context,
        isBack: true,
        ),
      body: const Center(
        child: Text('Here you can find more sentences!'),
      ),  
    );
  }
}