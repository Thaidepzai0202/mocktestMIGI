import 'package:flutter/material.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/string_const.dart';

class SpeedPopup extends StatelessWidget {
  const SpeedPopup({super.key, required this.onTap, required this.presentSpeed});
  final Function(double) onTap;
  final double presentSpeed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(StringConst.speedPlay,style: AppTextStyles.text16W600Primary ,),
                IconButton(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.close,size: 20,))
              ],
            ),
          ),
          const SizedBox(height: 10,),
          _item(speed: 0.5,context: context),
          _item(speed: 1,context: context),
          _item(speed: 1.5,context: context),
          _item(speed: 2,context: context),
        ],
      ),
    );
  }

  Widget _item({required double speed,required BuildContext context}) {
    return InkWell(
        onTap: () => onTap(speed), child: Container(
          height: 36,
          width: MediaQuery.of(context).size.width-32,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            // color: speed==presentSpeed ? AppColors.hint2TextColor  : null
            color: speed==presentSpeed ? AppColors.selectSpeed : null
          ),
          child: Text('  ${speed}x',style: AppTextStyles.text14W500Primary  ,)));
  }
}
