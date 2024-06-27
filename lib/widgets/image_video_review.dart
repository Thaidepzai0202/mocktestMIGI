import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/constants/api_path.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/models/revirew_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageVideoReview extends StatefulWidget {
  final ListFile listFile;
  final int? totalAdd ;
  const  ImageVideoReview({super.key, required this.listFile, this.totalAdd});

  @override
  State<ImageVideoReview> createState() => _ImageVideoReviewState();
}

class _ImageVideoReviewState extends State<ImageVideoReview> {
  // ignore: prefer_typing_uninitialized_variables
  var fileName;

  @override
  void initState() {
    getImageMP4();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listFile.type == 0) {
      return SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "${ApiPath.getDetailImage}${widget.listFile.path}",
                fit: BoxFit.cover,
              ),
            ),
            widget.totalAdd != null 
                ? Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text('+${widget.totalAdd!}',style: AppTextStyles.text18W700OWhite,))
                : const SizedBox()
          ],
        ),
      );
    } else {
      // if (widget.listFile.type == 1) getImageMP4();

      return Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.hint2TextColor,
                // image: Image.file(file)
                image: fileName != null
                    ? DecorationImage(
                        image: FileImage(File(fileName)), fit: BoxFit.fitWidth)
                    : null),
            child: SvgPicture.asset(
              fit: BoxFit.contain,
              Images.ic_play,
            ),
          ),
          widget.totalAdd != null 
                ? Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text('+${widget.totalAdd!}',style: AppTextStyles.text18W700OWhite,)) : const SizedBox()
        ],
      );
    }
  }

  getImageMP4() async {
    fileName = await VideoThumbnail.thumbnailFile(
      video: ApiPath.getDetailImage + widget.listFile.path!,
      // video:
      //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64,
    );
    setState(() {});
  }
}
