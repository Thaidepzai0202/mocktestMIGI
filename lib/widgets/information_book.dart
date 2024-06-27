import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/models/book_model.dart';
import 'package:mocktest/widgets/review_book.dart';

class InformationBook extends StatefulWidget {
  final BookModel bookModel;
  // ReviewModel reviewModel;
  const InformationBook({
    super.key,
    required this.bookModel,
    // required this.reviewModel
  });

  @override
  State<InformationBook> createState() => InformationBookState();
}

class InformationBookState extends State<InformationBook> {
  int _numSelect = 0;
  bool _isReadAll = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              titleDeatailSelect(
                  onTap: () {
                    setState(() {
                      _numSelect = 0;
                      _isReadAll = false;
                    });
                  },
                  title: StringConst.introBook,
                  num: 0),
              titleDeatailSelect(
                  onTap: () {
                    setState(() {
                      _numSelect = 1;
                    });
                  },
                  title: StringConst.detailInformation,
                  num: 1),
              titleDeatailSelect(
                  onTap: () {
                    setState(() {
                      _numSelect = 2;
                    });
                  },
                  title: StringConst.seller,
                  num: 2),
              titleDeatailSelect(
                  onTap: () {
                    setState(() {
                      _numSelect = 3;
                    });
                  },
                  title: StringConst.review,
                  num: 3),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColors.borderButtomUnSelect,
          margin: const EdgeInsets.only(bottom: 10),
        ),
        detail(),
        Container(
          height: 1,
          color: AppColors.borderButtomUnSelect,
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget titleDeatailSelect(
      {required Function() onTap, required String title, required int num}) {
    return InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          padding: const EdgeInsets.all(8.0),
          curve: Curves.fastEaseInToSlowEaseOut,
          decoration: BoxDecoration(
              border: Border(
                  bottom: _numSelect == num
                      ? const BorderSide(
                          width: 2, color: AppColors.orangePrimaryColor)
                      : BorderSide.none)),
          child: Text(
            title,
            style: AppTextStyles.text14W500Content.copyWith(
                color: _numSelect == num ? AppColors.orangePrimaryColor : null),
          ),
        ));
  }

  Widget detail() {
    switch (_numSelect) {
      case 0:
        return introBook();
      case 1:
        return informationDetail();
      case 2:
        return inforSeller();
      case 3:
        if (widget.bookModel.avgRate != 0) {
          return const ReviewBook();
        } else {
          return const NoReview();
        }
      default:
        return introBook();
    }
  }

  Widget introBook() {
    bool isLong = widget.bookModel.description!.length > 300;
    // _isReadAll = !_isLong;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: const [Colors.transparent, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [!_isReadAll ? 0 : 1, 1],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Text(
              '     ${widget.bookModel.description}',
              style: AppTextStyles.text14W400Content,
              maxLines: _isReadAll || !isLong ? null : 5,
              overflow: TextOverflow.fade,
              // key: ValueKey(_isReadAll),
            ),
          ),
          isLong
              ? SizedBox(
                  width: 100,
                  child: InkWell(
                    onTap: () => setState(() {
                      _isReadAll = !_isReadAll;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _isReadAll ? StringConst.shrink : StringConst.seeMore,
                          style: AppTextStyles.text14W400Orangre,
                        ),
                        // SizedBox(width: 6),
                        SvgPicture.asset(_isReadAll
                            ? Images.ic_arrow_top
                            : Images.ic_arrow_down)
                      ],
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget informationDetail() {
    return Column(
      children: [
        informationItem(
            key: StringConst.issuingCompany, value: widget.bookModel.issuer!),
        informationItem(
            key: StringConst.dateManufacture,
            value: DateFormat('dd-MM-yyyy')
                .format(widget.bookModel.publicationTime!)),
        informationItem(
            key: StringConst.size, value: widget.bookModel.dimension!),
        informationItem(
            key: StringConst.translator, value: widget.bookModel.translator!),
        informationItem(
            key: StringConst.totalPage,
            value: widget.bookModel.pageNumber.toString()),
        informationItem(
            key: StringConst.covertype,
            value: widget.bookModel.coverType == 0 ? "Bìa mềm" : "Bìa cứng"),
      ],
    );
  }

  Widget informationItem({required String key, required String value}) {
    if (value == "null" || value == "") {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
                flex: 42,
                child: Text(
                  key,
                  style: AppTextStyles.text15Hint2,
                )),
            Expanded(
                flex: 60,
                child: Text(
                  value,
                  style: AppTextStyles.text15Primary,
                )),
          ],
        ),
      );
    }
  }

  Widget inforSeller() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          StringConst.informationSeller,
          style: AppTextStyles.text16W600Primary,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              height: 64,
              width: 64,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                      'https://cdn-migi-2.laosedu.la/f${widget.bookModel.sellerAvatar}',
                      fit: BoxFit.cover)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                widget.bookModel.sellerFullname!,
                style: AppTextStyles.text14W600Blue,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              onTap: () => {},
              child: Container(
                height: 28,
                width: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.orangePrimaryColor, width: 1),
                    borderRadius: BorderRadius.circular(4)),
                child: const Text(StringConst.seeDetail,
                    style: AppTextStyles.text13W500Orange),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            widget.bookModel.sellerIntro!,
            style: AppTextStyles.text14W400Primary,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
