import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/services/logger.dart';

class BottomBar extends StatefulWidget {
  final int type;
  const BottomBar({super.key, required this.type});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 69,
      child: Column(
        children: [
          Container(
            color: AppColors.borderButtomUnSelect,
            height: 1,
          ),
          Container(
            height: 68,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                messageButton(),
                if (widget.type != 1) cartButton(),
                buyButton2(),
                favouriteButton(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messageButton() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 44,
          width: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.contentTextColor),
          child: SvgPicture.asset(
            Images.ic_messages_2,
            // ignore: deprecated_member_use
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget cartButton() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 44,
          width: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.bluePrimaryColor),
          child: SvgPicture.asset(Images.ic_cart),
        ),
      ),
    );
  }

  Widget buyButton() {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.orangePrimaryColor),
          child: Text(
            widget.type != 0 ? StringConst.libraryBook : StringConst.buyItem,
            style: AppTextStyles.text13W600OWhite,
          ),
        ),
      ),
    );
  }

  Widget buyButton2() {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            isSelect = !isSelect;
          });
        },
        child: AnimatedContainer(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isSelect ? AppColors.hint2TextColor :  AppColors.orangePrimaryColor),
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: Text(
            widget.type != 0 ? StringConst.libraryBook : StringConst.buyItem,
            style:  AppTextStyles.text13W600OWhite,
          ),
        ),
      ),
    );
  }

  Widget favouriteButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: InkWell(
        onTap: () {
          logger.log("${BlocProvider.of<BookDetailBloc>(context).bookModel!.code} : ${BlocProvider.of<BookDetailBloc>(context).bookModel!.id}");
        },
        child: Container(
          height: 44,
          width: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border:
                  Border.all(width: 1, color: AppColors.borderButtomUnSelect)),
          child: SvgPicture.asset(Images.ic_heart_symbol),
        ),
      ),
    );
  }
}
