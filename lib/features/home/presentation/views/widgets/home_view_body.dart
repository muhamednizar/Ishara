import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/utils/assets.dart';
import 'package:ishara/core/utils/styles.dart';
// تأكد من مسار الـ AppColors بتاعك
import 'package:ishara/features/home/presentation/manager/home_cubit.dart';
import 'package:ishara/features/home/presentation/manager/home_state.dart';
import 'package:ishara/features/home/presentation/views/widgets/alph_images.dart';
import 'package:ishara/features/home/presentation/views/widgets/all_sign_alph.dart';
import 'package:ishara/features/home/presentation/views/widgets/sentence_sign.dart';
import 'package:ishara/features/home/presentation/views/widgets/video_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // --- 1. الجزء العلوي (البنرات + العنوان) ---
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              SizedBox(
                height: 150,
                child: SentenceSign(
                  phrases: [
                    SignPhrase(
                        title: 'كيف تقول مرحبا بلغة الإشارة؟'.tr(),
                        imagePath: AssetsData.sayHello,
                        gifUrl: 'https://i.makeagif.com/media/5-22-2026/9uCEz8.gif'),
                    SignPhrase(
                        title: 'كيف تقول كيف حالك بلغة الإشارة؟'.tr(),  
                        imagePath: AssetsData.howAreu,
                        gifUrl: 'https://raw.githubusercontent.com/muhamednizar/ishara-gifs/refs/heads/main/howare_u.gif'),

                    
                  ],
                ),
              ),

              const SizedBox(height: 24),
              // قسم الفيديوهات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Videos'.tr(),
                  style: Styles.semiBold24.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),

        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current is GetVideosLoading ||
                  current is GetVideosSuccess ||
                  current is GetVideosError,
              builder: (context, state) {
                if (state is GetVideosLoading || state is HomeInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetVideosSuccess) {
                  if (state.videos.isEmpty) {
                    return Center(
                        child: Text('No videos available right now'.tr()));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.videos.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return VideoItemWidget(video: state.videos[index]);
                    },
                  );
                } else if (state is GetVideosError) {
                  return Center(
                    child: Text(
                      state.errMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 55),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10), // شيلت الـ top:20 عشان الـ SizedBox هيقوم بالواجب
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sign language'.tr(),
                  style: Styles.semiBold24.copyWith(fontSize: 20),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    minimumSize: const Size(100, 20),
                    backgroundColor:
                        AppColors.primaryColor.withValues(alpha: 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(
                        color: AppColors.primaryColor.withValues(alpha: 0.2)),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllSignAlph()));
                  },
                  child: Text(
                    'See All'.tr(),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 132,
            width: 343,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        alphImages[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }
}
