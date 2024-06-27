import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/bloc/preview_audio/preview_audio_bloc.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/models/preview_book_model.dart';
import 'package:mocktest/services/logger.dart';
import 'package:mocktest/widgets/must_buy_dilog.dart';
import 'package:mocktest/widgets/speed_popup.dart';

class BottomBarAudio extends StatefulWidget {
  const BottomBarAudio({super.key});

  @override
  State<BottomBarAudio> createState() => _BottomBarAudioState();
}

class _BottomBarAudioState extends State<BottomBarAudio> {
  bool isPlaying = false;
  double speed = 1;
  PreviewBookModel? previewBookModel;
  int numSelect = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewAudioBloc, PreviewAudioState>(
      builder: (context, state) {
        previewBookModel = state.previewBookModel;
        speed = state.speed;
        // ignore: unrelated_type_equality_checks
        if (state.status == PostStatus.failure) {
          return const Scaffold(
              body: Center(
            child: Text("Error"),
          ));
        }
        return SizedBox(
          height: 180,
          // padding: const EdgeInsets.symmetric(horizontal:  16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Divider(
                height: 0.5,
                endIndent: 5,
                color: AppColors.borderButtomUnSelect,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: ProgressBar(
                  timeLabelLocation: TimeLabelLocation.sides,
                  thumbColor: AppColors.orangePrimaryColor,
                  progressBarColor: AppColors.orangePrimaryColor,
                  progress: state.position,
                  total: state.duration,
                  barHeight: 6,
                  onSeek: (value) => BlocProvider.of<PreviewAudioBloc>(context)
                      .add(SeekEvent(seekValue: value)),
                ),
              ),
              const Divider(
                height: 0.5,
                color: AppColors.borderButtomUnSelect,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _itemPlay(Images.ic_backward_10s, () {
                      BlocProvider.of<PreviewAudioBloc>(context).add(SeekEvent(
                          seekValue: state.position <=
                                  const Duration(seconds: 10)
                              ? Duration.zero
                              : state.position - const Duration(seconds: 10)));
                    }, null),
                    _itemPlay(Images.ic_prev_audio, () {
                      if (BlocProvider.of<PreviewAudioBloc>(context)
                              .curentIndex !=
                          0) {
                        BlocProvider.of<PreviewAudioBloc>(context)
                            .add(const NextOrPrevEvent(isNext: false));
                      }
                    }, null),
                    _itemPlay(
                        state.isPlaying
                            ? Images.ic_pause_audio_book
                            : Images.ic_play_audio_book, () {
                      logger.log(state.isPlaying, color: StrColor.onSocket);
                      return BlocProvider.of<PreviewAudioBloc>(context)
                          .add(state.isPlaying ? PauseEvent() : PlayEvent());
                    }, 64),
                    _itemPlay(
                        Images.ic_next_audio,
                        () => BlocProvider.of<PreviewAudioBloc>(context)
                            .add(const NextOrPrevEvent(isNext: true)),
                        null),
                    _itemPlay(Images.ic_forward_10s, () {
                      BlocProvider.of<PreviewAudioBloc>(context).add(SeekEvent(
                          seekValue: state.duration - state.position <=
                                  const Duration(seconds: 10)
                              ? state.duration
                              : state.position + const Duration(seconds: 10)));
                    }, null),
                  ],
                ),
              ),
              const Divider(
                height: 0.5,
                color: AppColors.borderButtomUnSelect,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _itemSpeed(state.speed, () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SpeedPopup(
                          presentSpeed: speed,
                          onTap: (value) {
                            speed = value;
                            logger.log(speed);
                            BlocProvider.of<PreviewAudioBloc>(context)
                                .add(ChangeSpeedEvent(speedValue: value));
                            Navigator.pop(context);
                          },
                        ),
                      );
                    }, null),
                    _itemPlay(
                        state.replayStatus == ReplayStatus.noReplay
                            ? Images.ic_replay
                            : state.replayStatus == ReplayStatus.replayList
                                ? Images.ic_replay_orange
                                : Images.ic_replay_orange_one, () {
                      BlocProvider.of<PreviewAudioBloc>(context)
                          .add(ReplayEvent());
                    }, null),
                    const Expanded(child: SizedBox()),
                    const Expanded(child: SizedBox()),
                    _itemPlay(Images.ic_table_of_contents,
                        () => showMenu(context), null),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _itemPlay(String path, Function() onTap, double? height) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: SvgPicture.asset(
          path,
          height: height,
          width: height,
        ),
      ),
    );
  }

  Widget _itemSpeed(double speed, Function() onTap, double? height) {
    return Expanded(
      child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Center(
              child: Text(
            "${speed}x",
            style: AppTextStyles.text14W500Primary,
          ))),
    );
  }

  showMenu(BuildContext context1) {
    final max = MediaQuery.of(context1).size.height / 0.6;
    final lengthPreview = previewBookModel!.bookContentDto!.length;
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height:
              (80 + lengthPreview * 40) > max ? max : (80 + lengthPreview * 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${StringConst.list} ($lengthPreview)",
                      style: AppTextStyles.text16W600Primary,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                  ],
                ),
                Expanded(
                  child: showTableOfContents2(
                      context, previewBookModel!.bookContentDto!),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget showTableOfContents2(BuildContext context, List<BookContentDto> list) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return tableItem(list[index], index);
      },
    );
  }

  Widget tableItem(BookContentDto bookContentDto, int index) {
    return InkWell(
      onTap: () {
        if (bookContentDto.type == 0) {
          if (numSelect != index) {
            BlocProvider.of<PreviewAudioBloc>(context)
                .add(SelectAudioEvent(pathFile: bookContentDto.filePath!));
          }
          Navigator.pop(context);
          numSelect = index;
        } else {
          showDialog(
            context: context,
            builder: (context) => MustBuyBook(
              price: BlocProvider.of<PreviewAudioBloc>(context)
                  .previewBookModel!
                  .booksDetailsDto!
                  .bookPrices!,
              type: 2,
            ),
          );
        }
      },
      child: Container(
        color: numSelect == index ? AppColors.backgroundRalatedBook : null,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SizedBox(
                width: 230,
                child: Text(
                  "${index != 0 ? index : ' '}${index != 0 ? '. ' : '  '} ${bookContentDto.type == 0 ? "Nội dung nghe thử" : bookContentDto.bookContentName}  ",
                  style: numSelect == index
                      ? AppTextStyles.text14W500Hint2
                      : AppTextStyles.text14W500Hint,
                ),
              ),
              // const Spacer(),
              Text(
                "  (${changeTime(BlocProvider.of<PreviewAudioBloc>(context).previewBookModel!.bookContentDto![index].value!)})  ",
                style: numSelect == index
                    ? AppTextStyles.text14W500Hint2
                    : AppTextStyles.text14W500Hint,
              ),
              BlocBuilder<PreviewAudioBloc, PreviewAudioState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      bookContentDto.type == 1
                          ? SvgPicture.asset(Images.ic_lock)
                          : const SizedBox(
                              width: 14,
                            ),
                      const SizedBox(width: 10),
                      numSelect == index && state.isPlaying
                          ? SvgPicture.asset(Images.ic_song_wave)
                          : SvgPicture.asset(Images.ic_play_1)
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

String changeTime(int value) {
  int minute = (value / 60).truncate();
  int second = value - minute * 60;
  return "$minute:$second";
}
