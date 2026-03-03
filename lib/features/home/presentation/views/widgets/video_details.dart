// import 'package:flutter/material.dart';
// import 'package:ishara/core/widgets/custom_home_app_bar.dart';
// import 'package:ishara/core/utils/app_text_style.dart';
// import 'package:ishara/features/home/presentation/views/widgets/video_item.dart';

// class VideoDetails extends StatefulWidget {
//   const VideoDetails({super.key});
//   static const String routeName = 'video_details';

//   @override
//   State<VideoDetails> createState() => _VideoDetailsState();
// }

// class _VideoDetailsState extends State<VideoDetails> {
//   bool isFav = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildCustomHomeAppBar(isBack: true, context: context),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             Center(
//               child: Container(
//                 width: 343,
//                 height: 220,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 //play icon
//                 child: Center(
//                   //
//                   child: Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                           color: Colors.black.withValues(alpha: 0.3),
//                           shape: BoxShape.circle),
//                       child:
//                           Icon(Icons.play_arrow, size: 60, color: Colors.white)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               width: 343,
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Video Title',
//                       style: TextStyles.semiBold24,
//                       maxLines: 4,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         shape: BoxShape.circle,
//                       ),
//                       child: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isFav = !isFav;
//                           });
//                         },
//                         icon: isFav == false
//                             ? Icon(Icons.favorite_border,
//                                 size: 30, color: Colors.red[600])
//                             : Icon(Icons.favorite,
//                                 size: 30, color: Colors.red[600]),
//                       )),
//                 ],
//               ),
//             ),
//             SizedBox(height: 40),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.22,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                     return VideoItemWidget();
//                 },
//                 separatorBuilder: (context, index) {
//                   return SizedBox(width: 10);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
