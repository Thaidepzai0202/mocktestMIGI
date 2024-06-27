import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/models/book_model.dart';

class ShowTitleBook extends StatelessWidget {
  final BookModel bookModel;
  final int type;

  const ShowTitleBook({super.key, required this.bookModel, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 130,
                child: Text(
                  bookModel.name!,
                  style: AppTextStyles.titleDetailBook,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${type == 0 ? bookModel.hardBook!.price : type == 1 ? bookModel.ebook!.price : bookModel.audioBook!.price} ₭',
                    // '${bookModel.bookPrices!.split(',')[0]} ₭',
                    style: AppTextStyles.titleDetailBook
                        .copyWith(color: AppColors.orangePrimaryColor),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
          starAndReview(),
          auThor(),
          publishHouse(),
        ],
      ),
    );
  }

  Widget starAndReview() {
    int star = bookModel.avgRate!.truncate();
    bool halfStar = (bookModel.avgRate! - star) > 0 ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          for (int i = 0; i < star; i++)
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(Images.ic_star),
            ),
          halfStar
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset(Images.ic_haft_Star),
                    ),
                    for (int i = 0; i < 5 - 1 - star; i++)
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(Images.ic_star_gray),
                      ),
                  ],
                )
              : Row(
                  children: [
                    for (int i = 0; i < 5 - star; i++)
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(Images.ic_star_gray),
                      ),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              '${bookModel.avgRate}',
              style: AppTextStyles.titleDetailBook,
            ),
          ),
          Text(
            '(${bookModel.totalReview} đánh giá)',
            style: AppTextStyles.hint12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 1.5,
              height: 16,
              color: AppColors.hintTextColor,
            ),
          ),
          Text(
            'Đã bán: ${bookModel.totalSold}',
            style: AppTextStyles.hint13,
          )
        ],
      ),
    );
  }

  Widget auThor() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
              width: 96,
              child: Text(
                'Tác giả:',
                style: AppTextStyles.text14Hint2,
              )),
          Expanded(
            child: Text(
              bookModel.author!,
              style: AppTextStyles.text15Blue,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget publishHouse() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
              width: 96,
              child: Text(
                'Nhà Xuất bản:',
                style: AppTextStyles.text14Hint2,
              )),
          Expanded(
            child: Text(
              bookModel.publisher!,
              style: AppTextStyles.text14Primary,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
