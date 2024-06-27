
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mocktest/constants/api_path.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/models/revirew_model.dart';
import 'package:mocktest/widgets/image_video_review.dart';

class ClientReviewItem extends StatefulWidget {
  final ListReview listReview;
  const ClientReviewItem({super.key, required this.listReview});

  @override
  State<ClientReviewItem> createState() => _ClientReviewItemState();
}

class _ClientReviewItemState extends State<ClientReviewItem> {
  @override
  void initState() {
    // getImageMP4();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        reviewOnlyText(),
        reviewFileBuyer(widget.listReview.listFileBuyer! ),
        widget.listReview.contentSeller != '' ? repReview() : const SizedBox(),
        
      ],
    );
  }

  Widget repReview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 60,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(Images.ic_rep_review),
        ),
        SizedBox(
          height: 32,
          width: 32,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: widget.listReview.avatarSeller != null
                ? Image.network(
                    '${ApiPath.getDetailImage}${widget.listReview.avatarSeller}',
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(Images.ic_no_avatar),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              StringConst.sellerFeedback,
              style: AppTextStyles.text14W500Hint2,
            ),
            Text(
              widget.listReview.contentSeller!,
              style: AppTextStyles.text14W400Primary,
            ),
            widget.listReview.listFileSeller!.isNotEmpty
                ? reviewFileSeller(widget.listReview.listFileSeller! )
                : const SizedBox()
          ],
        )
      ],
    );
  }

  Widget reviewOnlyText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: widget.listReview.avatarBuyer != null
                ? Image.network(
                    '${ApiPath.getDetailImage}${widget.listReview.avatarBuyer}',
                    fit: BoxFit.cover)
                : SvgPicture.asset(Images.ic_no_avatar),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Text(
                widget.listReview.fullNameBuyer!,
                style: AppTextStyles.text14W600OPrimary,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(Images.ic_star),
                ),
                Text(
                  widget.listReview.rate.toString(),
                  style: AppTextStyles.text12W600OPrimary,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  DateFormat('MM/dd/yyyy')
                      .format(widget.listReview.createTime!),
                  style: AppTextStyles.text12W600OHint,
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Text(
                widget.listReview.contentBuyer!,
                style: AppTextStyles.text14W400Primary,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget reviewFileBuyer(List<ListFile> listFile) {
    if(listFile.isNotEmpty) {return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           ImageVideoReview(listFile: listFile[0]),
          listFile.length >1 ? ImageVideoReview(listFile: listFile[1]) : const SizedBox(height: 100,width: 100,),
          listFile.length >2  ? ImageVideoReview(listFile: listFile[2],totalAdd: listFile.length,) : const SizedBox(height: 100,width: 100,),
        ],
      ),
    );}else{
      return const SizedBox();
    }
  }

  Widget reviewFileSeller(List<ListFile> listFile) {
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width-160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageVideoReview(listFile: listFile[0]),
          // listFile.length >1 ? ImageVideoReview(listFile: listFile[1]) : const SizedBox(height: 100,width: 100,),
          listFile.length >1  ? ImageVideoReview(listFile: listFile[2],totalAdd: listFile.length-2,) : const SizedBox(height: 100,width: 100,),
        ],
      ),
    );
  }

}
