import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mocktest/constants/api_path.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/models/preview_book_model.dart';

class ShowAudioInformation extends StatelessWidget {
  final PreviewBookModel previewBookModel;
  final String bookContentName;
  const ShowAudioInformation(
      {super.key,
      required this.previewBookModel,
      required this.bookContentName});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 350,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                  image: NetworkImage(ApiPath.getDetailImage +
                      previewBookModel.booksDetailsDto!.avatar!
                          .split(',')[0],)),
                          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                bookContentName,
                style: AppTextStyles.text16W500Primary,
              ),
              const SizedBox(height: 6,),
              Row(
                children: [
                  const Text(
                    '${StringConst.author}:  ',
                    style: AppTextStyles.text14W500Hint2,
                  ),
                  Text(
                    previewBookModel.booksDetailsDto!.author!,
                    style: AppTextStyles.text14W500Blue,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              const SizedBox(height: 6,),
          
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '${StringConst.pieceOfWork}:  ',
                    style: AppTextStyles.text14W500Hint2,
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      previewBookModel.booksDetailsDto!.name!,
                      style: AppTextStyles.text14W500Primary,
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
