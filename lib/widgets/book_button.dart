import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/string_const.dart';

class HardBookButton extends StatelessWidget {
  final bool isSelect ;
  final Function() onTap;
  const HardBookButton({super.key, required this.isSelect, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 81,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: isSelect
                      ? AppColors.orangePrimaryColor
                      : AppColors.borderButtomUnSelect)),
          child: Text(
            StringConst.books,
            style: AppTextStyles.buttonTextStyle.copyWith(
                color: isSelect ? AppColors.orangePrimaryColor : null),
          ),
        ),
      ),
    );
  }
}

class EBookButton extends StatelessWidget {
  final bool isSelect ;
  final Function() onTap;
  const EBookButton({super.key, required this.isSelect, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 112,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: isSelect
                      ? AppColors.orangePrimaryColor
                      : AppColors.borderButtomUnSelect)),
          child: Text(
            StringConst.eBooks,
            style: AppTextStyles.buttonTextStyle.copyWith(
                color: isSelect ? AppColors.orangePrimaryColor : null),
          ),
        ),
      ),
    );
  }
}

class AudioBookButton extends StatelessWidget {
  final bool isSelect ;
  final Function() onTap;
  const AudioBookButton({super.key, required this.isSelect, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 89,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: isSelect
                    ? AppColors.orangePrimaryColor
                    : AppColors.borderButtomUnSelect)),
        child: Text(
          StringConst.audioBooks,
          style: AppTextStyles.buttonTextStyle
              .copyWith(color: isSelect ? AppColors.orangePrimaryColor : null),
        ),
      ),
    );
  }
}

class ReadBookButton extends StatelessWidget {
  final String path;
  final String title;
  final Function() onTap;
    const ReadBookButton(
      {super.key,
      required this.onTap,
      required this.path,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 1, color: AppColors.bluePrimaryColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(path),
            const SizedBox(
              width: 4,
            ),
            Text(title, style: AppTextStyles.buttonBlueTextStyle)
          ],
        ),
      ),
    );
  }
}
