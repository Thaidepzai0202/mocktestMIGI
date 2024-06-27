import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/preview_audio/preview_audio_bloc.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/widgets/bottom_bar_audio.dart';
import 'package:mocktest/widgets/show_audio_infromation.dart';

class PreViewAudioBook extends StatefulWidget {
  const PreViewAudioBook({super.key});

  @override
  State<PreViewAudioBook> createState() => _PreViewAudioBookState();
}

class _PreViewAudioBookState extends State<PreViewAudioBook> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewAudioBloc, PreviewAudioState>(
      builder: (context, state) {
        if (state.status == AudioStatus.success) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: Column(
                children: [
                  const Spacer(),
                  AppBar(
                    // toolbarHeight: 100,
                    leading: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: SvgPicture.asset(Images.ic_arrow_down,
                              // ignore: deprecated_member_use
                              color: AppColors.textPrimaryColor,
                              width: 20,
                              height: 20),
                        )),
                    scrolledUnderElevation: 0.0,
                    backgroundColor: AppColors.white,
                    title: Row(
                      children: [
                        Container(
                          width: 250,
                          alignment: Alignment.center,
                          child: Text(
                            state.previewBookModel!.booksDetailsDto!.name!,
                            style: AppTextStyles.titleDetailBook,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<PreviewAudioBloc>(context)
                                .add(EndEvent());
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ],
              ),
            ),
            body: ShowAudioInformation(
              bookContentName: state
                          .previewBookModel!
                          .bookContentDto![
                              BlocProvider.of<PreviewAudioBloc>(context)
                                  .curentIndex]
                          .bookContentName ==
                      ""
                  ? "Nội dung nghe thử"
                  : state
                      .previewBookModel!
                      .bookContentDto![
                          BlocProvider.of<PreviewAudioBloc>(context)
                              .curentIndex]
                      .bookContentName!,
              previewBookModel: state.previewBookModel!,
            ),
            bottomNavigationBar: const BottomBarAudio(),
          );
          // ignore: unrelated_type_equality_checks
        } else if (state.status == PostStatus.initial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.orangePrimaryColor,
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }
      },
    );
  }
}
