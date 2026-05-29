import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart'; 
import 'package:ishara/features/home/presentation/views/widgets/alph_images.dart';

class AllSignAlph extends StatelessWidget {
  const AllSignAlph({super.key});
  
  static const String routeName = 'all_sign_alph';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomHomeAppBar(isBack: true, context: context, title: 'Alphabets and Numbers'.tr()),
      // 👇 السر هنا: Directionality بتخلي كل حاجة جواها تبدأ من اليمين للشمال (RTL)
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
                Text(
                "Alphabets signs".tr(),
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              Expanded(
                child: GridView.builder(
                  itemCount: alphImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, 
                    crossAxisSpacing: 15, 
                    mainAxisSpacing: 15, 
                    childAspectRatio: 1, 
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[100], 
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(alphImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}