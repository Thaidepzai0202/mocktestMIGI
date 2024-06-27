import 'package:flutter/material.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/string_const.dart';

class MustBuyBook extends StatelessWidget {
  final String price;
  final int type;
  const MustBuyBook({super.key, required this.price, required this.type});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(16)),
        width: 350,
        height: 260,
        child: Column(
          children: [
            Container(
              height: 72,
              alignment: Alignment.center,
              child: const Text(
                StringConst.notification,
                style: AppTextStyles.text16W600Primary,
              ),
            ),
            const Divider(
              color: AppColors.borderButtomUnSelect,
              height: 0.5,
            ),
            const Expanded(
                child: Center(
              child: SizedBox(
                  width: 220,
                  child: Text(
                    StringConst.notificationMustBuyContent,
                    style: AppTextStyles.text14W400Primary,
                    textAlign: TextAlign.center,
                  )),
            )),
            const Divider(
              color: AppColors.borderButtomUnSelect,
              height: 0.5,
            ),
            SizedBox(
              height: 96,
              child: Row(
                children: [cancelButton(context), buyButton()],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cancelButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 22),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 45,
          width: 105,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.borderButtomUnSelect,
              borderRadius: BorderRadius.circular(4)),
          child: const Text(
            StringConst.cancel,
            style: AppTextStyles.text12W600OHint,
          ),
        ),
      ),
    );
  }

  Widget buyButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 22),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.orangePrimaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              '${type == 1 ? StringConst.buyEBook : StringConst.buyAudioBook}\n$price ₭',
              style: AppTextStyles.text12W600White,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
