import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishara/core/widgets/custom_home_app_bar.dart';
import 'package:ishara/core/utils/styles.dart';
import 'package:ishara/features/home/data/models/video_model.dart';
import 'package:ishara/features/home/presentation/views/widgets/video_item.dart';
import 'package:ishara/features/home/presentation/manager/home_cubit.dart';
import 'package:ishara/features/home/presentation/manager/home_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails({super.key});
  static const String routeName = 'video_details';

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  VideoModel? video;
  bool _isPlaying = false;
  YoutubePlayerController? _youtubeController;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (video == null) {
      video = ModalRoute.of(context)?.settings.arguments as VideoModel?;
    }
  }

  Future<void> _startVideo() async {
    setState(() => _isPlaying = true);
    if (video!.isYoutube) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: video!.videoUrl,
        flags: const YoutubePlayerFlags(autoPlay: true),
      );
    } else {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(video!.videoUrl));
      await _videoPlayerController!.initialize();
      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: true,
          aspectRatio: 16 / 9);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (video == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: buildCustomHomeAppBar(isBack: true, context: context, title: 'Video details'.tr()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 343, height: 220,
                decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(12)),
                child: ClipRRect(borderRadius: BorderRadius.circular(12), child: _buildVideoPlayerArea()),
              ),
            ),
            const SizedBox(height: 20),
            
            // 1. قسم معلومات الفيديو الحالي وزر المفضلة
            Center(
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) => current is GetVideosSuccess || current is AddFavoriteSuccess,
                builder: (context, state) {
                  final currentVideo = context.read<HomeCubit>().allVideosList.firstWhere(
                    (v) => v.id == video!.id, 
                    orElse: () => video!
                  );

                  final titleBackground = theme.brightness == Brightness.dark
                      ? theme.cardColor
                      : Colors.grey.shade100;

                  return Container(
                    decoration: BoxDecoration(color: titleBackground, borderRadius: BorderRadius.circular(12)),
                    width: 343, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(child: Text(currentVideo.title, style: Styles.semiBold24.copyWith(fontSize: 18, color: theme.colorScheme.onSurface), maxLines: 2, overflow: TextOverflow.ellipsis)),
                        IconButton(
                          onPressed: () => context.read<HomeCubit>().toggleFavorite(currentVideo),
                          icon: Icon(
                            currentVideo.isFav ? Icons.favorite : Icons.favorite_border,
                            size: 30, color: Colors.red[600]
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 30),
            
            // عنوان قسم الفيديوهات المقترحة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "فيديوهات مقترحة".tr(),
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onBackground),
              ),
            ),
            const SizedBox(height: 15),

            // 2. قسم الفيديوهات المقترحة
            SizedBox(
              height: 200,
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (p, c) => c is GetVideosSuccess,
                builder: (context, state) {
                  if (state is GetVideosSuccess) {
                    
                    final suggestedVideos = state.videos.where((v) => v.id != video!.id).toList();

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: suggestedVideos.length, // نستخدم اللستة الجديدة المفلترة
                      itemBuilder: (context, index) => VideoItemWidget(video: suggestedVideos[index]), // نمرر الفيديو المقترح
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayerArea() {
    if (!_isPlaying) {
      return Stack(fit: StackFit.expand, children: [
        Image.network(
          video!.thumbnailUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            final theme = Theme.of(context);
            return Container(
              color: theme.cardColor,
              child: Icon(Icons.video_camera_back_outlined, color: theme.colorScheme.onSurface, size: 50),
            );
          },
        ),
        Center(child: GestureDetector(onTap: _startVideo, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Theme.of(context).cardColor.withOpacity(0.7), shape: BoxShape.circle), child: Icon(Icons.play_arrow, size: 60, color: Theme.of(context).colorScheme.onPrimary))))
      ]);
    }
    if (video!.isYoutube && _youtubeController != null) return YoutubePlayer(controller: _youtubeController!);
    if (!video!.isYoutube && _chewieController != null) return Chewie(controller: _chewieController!);
    return const Center(child: CircularProgressIndicator());
  }
}