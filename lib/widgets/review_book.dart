import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/models/revirew_model.dart';
import 'package:mocktest/widgets/client_review_item.dart';

// ignore: must_be_immutable
class ReviewBook extends StatefulWidget {
  // ReviewModel reviewModel;
  const ReviewBook({super.key});

  @override
  State<ReviewBook> createState() => _ReviewBookState();
}

class _ReviewBookState extends State<ReviewBook> {
  int _numSelectStar = 5;
  ReviewRate? listReviewRate;
  int totalReview = 0;
  List<ListReview>? listReview = [];

  @override
  void initState() {
    BlocProvider.of<BookDetailBloc>(context).add(ReviewBookEvent(rate: 5));
    //  BookDetailBloc().add(event)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailBloc, BookDetailState>(
      builder: (context, state) {
        if (state.reviewModel != null) {
          listReview = state.reviewModel!.listReview;
          listReviewRate = state.reviewModel!.listReviewRate;
          totalReview = state.reviewModel!.totalReview!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  StringConst.reviewAndVote,
                  style: AppTextStyles.text15W600OPrimary,
                ),
              ),
              starChart(),
              review()
            ],
          );
        }
        // else {
        return Container(
            height: 80,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: AppColors.orangePrimaryColor,
            ));
      },
    );
  }

  Widget starChart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [generalStar(), generalChart()],
      ),
    );
  }

  Widget generalStar() {
    double avgRate = (listReviewRate!.totalRate1! * 1 +
            listReviewRate!.totalRate2! * 2 +
            listReviewRate!.totalRate3! * 3 +
            listReviewRate!.totalRate4! * 4 +
            listReviewRate!.totalRate5! * 5) /
        totalReview;
    int star = avgRate.truncate();
    bool halfStar = (avgRate - star) > 0 ? true : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(avgRate.toStringAsFixed(1),
            style: AppTextStyles.text32W700OPrimary),
        Row(children: [
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
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text('Based on $totalReview review',
              style: AppTextStyles.text10W600Hint),
        )
      ],
    );
  }

  Widget generalChart() {
    return Column(
      children: [
        itemChart(1, listReviewRate!.totalRate1!, totalReview),
        itemChart(2, listReviewRate!.totalRate2!, totalReview),
        itemChart(3, listReviewRate!.totalRate3!, totalReview),
        itemChart(4, listReviewRate!.totalRate4!, totalReview),
        itemChart(5, listReviewRate!.totalRate5!, totalReview),
      ],
    );
  }

  Widget itemChart(int title, int quantity, int total) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Text(
            title.toString(),
            style: AppTextStyles.text10W600Hint,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 93,
            child: LinearProgressIndicator(
              value: quantity / total,
              backgroundColor: AppColors.pink,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.orangePrimaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
          )
        ],
      ),
    );
  }

  Widget review() {
    return Column(children: [tabStar(), clienttReview()]);
  }

  Widget tabStar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 50,
        child: Row(children: [
          tabStarItem(5, listReviewRate!.totalRate5!),
          tabStarItem(4, listReviewRate!.totalRate4!),
          tabStarItem(3, listReviewRate!.totalRate3!),
          tabStarItem(2, listReviewRate!.totalRate2!),
          tabStarItem(1, listReviewRate!.totalRate1!),
        ]),
      ),
    );
  }

  Widget tabStarItem(int numStar, int totalReview) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        // setState(() {
        //   _numSelectStar = numStar;
        // });
        _numSelectStar = numStar;
        BlocProvider.of<BookDetailBloc>(context)
            .add(ReviewBookEvent(rate: numStar));
      },
      child: Container(
        height: 32,
        width: 79,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
              color: _numSelectStar == numStar
                  ? AppColors.orangePrimaryColor
                  : AppColors.borderButtomUnSelect,
              width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
          color: _numSelectStar == numStar ? AppColors.pink : AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(numStar.toString(),
                style: AppTextStyles.text12W500OPrimary.copyWith(
                    color: _numSelectStar == numStar
                        ? AppColors.orangePrimaryColor
                        : AppColors.textPrimaryColor)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SvgPicture.asset(Images.ic_star),
            ),
            Text(
              '(${shortenNumber(totalReview)})',
              style: AppTextStyles.text12W500OHint.copyWith(
                  color: _numSelectStar == numStar
                      ? AppColors.textPrimaryColor
                      : AppColors.hintTextColor),
            )
          ],
        ),
      ),
    );
  }

  Widget clienttReview() {
    int indexReview = 0;
    List<Widget> child = [];
    for (var element in listReview!) {
      indexReview++;
      child.add(Column(
        children: [
          ClientReviewItem(
            listReview: element,
          ),
          indexReview!=listReview!.length ? Container(
          height: 1,
          color: AppColors.borderButtomUnSelect,
            margin: const EdgeInsets.only(top: 12,bottom: 12,left: 50),
        ) : const SizedBox()
        ],
      ));
    }

    return Column(children: child);
  }
}

String shortenNumber(int number) {
  if (number >= 1000) {
    double result = number / 1000;
    return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
  } else {
    return number.toString();
  }
}

class NoReview extends StatelessWidget {
  const NoReview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              StringConst.reviewAndVote,
              style: AppTextStyles.text15W600OPrimary,
            ),),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SvgPicture.asset(Images.ic_no_review),
                  const Padding(
                    padding:  EdgeInsets.symmetric(vertical:  21.0),
                    child: Text(StringConst.noReview,style: AppTextStyles.text14W400Content,),
                  )
                ],
              ),
            )
          
        ],
      ),
    );
  }
}
