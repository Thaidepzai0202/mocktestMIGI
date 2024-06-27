import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/constants/api_path.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/models/relate_book.dart';
import 'package:intl/intl.dart';
import 'package:mocktest/screens/book_detail_screen.dart';

class RelatedBookWidget extends StatefulWidget {
  final List<RelatedBook> listRelateBook;
  final String author;

  const RelatedBookWidget(
      {super.key, required this.listRelateBook, required this.author});

  @override
  State<RelatedBookWidget> createState() => _RelatedBookWidgetState();
}

class _RelatedBookWidgetState extends State<RelatedBookWidget> {
  int _page = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailBloc, BookDetailState>(
      builder: (context, state) {
        return SizedBox(
          height: 410,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              titleRalateBookAndAuthor(),
              relateBookDetail(),
            ],
          ),
        );
      },
    );
  }

  Widget dot({required bool isLight}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isLight ? AppColors.orangePrimaryColor : AppColors.hintTextColor),
      width: 8,
      height: 8,
    );
  }

  Widget titleRalateBookAndAuthor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                StringConst.otherListingsOF,
                style: AppTextStyles.text16W600Primary,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  widget.author,
                  style: AppTextStyles.text16W600Blue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              if (_page < 3) {
                _pageController.animateToPage(_page + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }
            },
            child: Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.borderButtomUnSelect),
              child: SvgPicture.asset(Images.ic_arrow_right_1),
            ),
          )
        ],
      ),
    );
  }

  Widget relateBookDetail() {
    int numpage = widget.listRelateBook.length ~/ 2;
    if (widget.listRelateBook.length % 2 != 0) numpage++;
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(top: 12,left: 10,right: 10),
            height: 345,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _page = value;
                });
              },
              itemCount: numpage,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        relateBookItem(widget.listRelateBook[index * 2]),
                        relateBookItem(widget.listRelateBook[index * 2 + 1]),
                      ],
                    ),
                  ],
                );
              },
            )),
        SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              dot(isLight: _page == 0),
              dot(isLight: _page == 1),
              dot(isLight: _page == 2),
              dot(isLight: _page == 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget relateBookItem(RelatedBook relatedBook) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left  : 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookDetailScreen(
                      id: relatedBook.id,
                    )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              avatarBook(relatedBook.avatar, relatedBook.haveHot,
                  relatedBook.haveBestSeller),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right:12),
                child: Text(
                  relatedBook.topicBookName,
                  style: AppTextStyles.text14W500Hint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              evaluate(
                  avgRate: relatedBook.avgRate, totalSold: relatedBook.totalSold),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text(
                  relatedBook.name,
                  style: AppTextStyles.text14W600Primary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              author(author: relatedBook.author, bookType: relatedBook.bookTypes),
              Text(
                '${NumberFormat.decimalPattern().format(relatedBook.minPrice)} ₭',
                style: AppTextStyles.text14W600Primary,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget avatarBook(String avatar, bool hot, bool bestSeller) {
    return Stack(children: [
      Container(
        height: 175,
        width: 164,
        color: AppColors.backgroundRalatedBook,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        child: Container(
          height: 175 - 16,
          width: 164 - 28,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  '${ApiPath.getDetailImage}/${avatar.split(',')[0].substring(1)}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
        left: 8,
        bottom: 8,
        child: Row(
          children: [
            hot ? hotButton() : const SizedBox(),
            bestSeller ? bestSellerButton() : const SizedBox()
          ],
        ),
      )
    ]);
  }

  Widget hotButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2), color: AppColors.hotButton),
        child: const Text(
          'Hot',
          style: AppTextStyles.text10W600OWhite,
        ),
      ),
    );
  }

  Widget bestSellerButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: AppColors.bestSellerButton),
      child: const Text(
        'Best Seller',
        style: AppTextStyles.text10W600OWhite,
      ),
    );
  }

  Widget evaluate({required double avgRate, required int totalSold}) {
    return avgRate==0 && totalSold==0 ? const SizedBox(height: 24,):Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
          child: SvgPicture.asset(Images.ic_star),
        ),
        Text(
          avgRate.toString(),
          style: AppTextStyles.text14W500Primary,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          'Đã bán: $totalSold',
          style: AppTextStyles.text14W500Hint,
        ),
      ],
    );
  }

  Widget author({required String author, required String bookType}) {
    String category = '';
    if (bookType.contains('0')) category = '$category, Sách in';
    if (bookType.contains('1')) category = '$category, Sách điện tử';
    if (bookType.contains('2')) category = '$category, Sách nói';
    category = category.substring(2);
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0, top: 4.0, bottom: 4.0),
              child: SvgPicture.asset(
                Images.ic_teacher_1,
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                author,
                style: AppTextStyles.text14W500Hint2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0, top: 4.0, bottom: 4.0),
              child: SvgPicture.asset(
                Images.ic_book_1,
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                category,
                style: AppTextStyles.text14W500Hint2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )
      ],
    );
  }
}
