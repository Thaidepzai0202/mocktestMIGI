import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocktest/bloc/preview_audio/preview_audio_bloc.dart';
import 'package:mocktest/constants/api_path.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/screens/preview_audio_screen.dart';

class MiniAudioBook extends StatefulWidget {
  const MiniAudioBook({super.key});

  @override
  State<MiniAudioBook> createState() => _MiniAudioBookState();
}

class _MiniAudioBookState extends State<MiniAudioBook> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewAudioBloc, PreviewAudioState>(
      builder: (context, state) {
        return Container(
          height: 100,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: AppColors.blurBottomBar,
                blurRadius: 16.0,
                spreadRadius: 0.0,
                offset: Offset(0, -4))
          ], color: AppColors.white),
          child: Stack(
            children: [
              Positioned(
                  child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (context) {
                            return const PreViewAudioBook();
                          },
                        );
                      },
                      child: Container())),
              Positioned(
                  top: 12,
                  right: 12,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<PreviewAudioBloc>(context)
                          .add(EndEvent());
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        context: context,
                        builder: (context) {
                          return const PreViewAudioBook();
                        },
                      ),
                      child: SizedBox(
                        height: 52,
                        width: 52,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            ApiPath.getDetailImage +
                                BlocProvider.of<PreviewAudioBloc>(context)
                                    .previewBookModel!
                                    .booksDetailsDto!
                                    .avatar!
                                    .split(',')[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        context: context,
                        builder: (context) {
                          return const PreViewAudioBook();
                        },
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "   Nội dung nghe thử",
                            style: AppTextStyles.text12W600OPrimary,
                          ),
                          processAudio(
                              duration: state.duration,
                              position: state.position)
                        ],
                      ),
                    ),
                    _quickBottom()
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget processAudio(
      {required Duration duration, required Duration position}) {
    return Container(
      height: 24,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.backgroundProcessBottomBar),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            formatDuration(position),
            style: AppTextStyles.text10W500Primary,
          ),
          Container(
            height: 4,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(5),
              value: position.inMilliseconds.toDouble() /
                  duration.inMilliseconds.toDouble(),
              color: AppColors.orangePrimaryColor,
              backgroundColor: AppColors.backgroundProcess,
            ),
          ),
          Text(
            formatDuration(duration),
            style: AppTextStyles.text10W500Primary,
          )
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget _quickBottom() {
    return BlocBuilder<PreviewAudioBloc, PreviewAudioState>(
      builder: (context, state) {
        return Row(
          children: [
            _bottomQuick(
                path: Images.ic_prev_audio,
                onTap: () {
                  if (BlocProvider.of<PreviewAudioBloc>(context).curentIndex !=
                      0) {
                    BlocProvider.of<PreviewAudioBloc>(context)
                        .add(const NextOrPrevEvent(isNext: false));
                  }
                },
                size: 24),
            _bottomQuick(
                path: state.isPlaying
                    ? Images.ic_pause_audio_book
                    : Images.ic_play_audio_book,
                onTap: () {
                  return BlocProvider.of<PreviewAudioBloc>(context)
                      .add(state.isPlaying ? PauseEvent() : PlayEvent());
                },
                size: 32),
            _bottomQuick(
                path: Images.ic_next_audio,
                onTap: () {
                  BlocProvider.of<PreviewAudioBloc>(context)
                      .add(const NextOrPrevEvent(isNext: true));
                },
                size: 24),
          ],
        );
      },
    );
  }

  Widget _bottomQuick(
      {required String path, required Function() onTap, required double size}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          path,
          height: size,
          width: size,
        ),
      ),
    );
  }
}
