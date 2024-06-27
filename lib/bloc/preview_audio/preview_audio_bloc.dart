
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/constants/api_path.dart';
import 'package:mocktest/main.dart';
import 'package:mocktest/models/preview_book_model.dart';
import 'package:mocktest/services/book_detail_repo.dart';
import 'package:mocktest/services/decode.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktest/services/logger.dart';
import 'package:mocktest/widgets/must_buy_dilog.dart';

part 'preview_audio_event.dart';
part 'preview_audio_state.dart';

class PreviewAudioBloc extends Bloc<PreviewAudioEvent, PreviewAudioState> {
  final BookDetailRepo _bookDetailRepo = BookDetailRepo();
  PreviewBookModel? previewBookModel;
  String linkAudio = '';
  int curentIndex = 0;
  int currentReplayStatus = 0;
  double speed = 1;
  ReplayStatus replayStatus = ReplayStatus.noReplay;
  final player = AudioPlayer();

  PreviewAudioBloc() : super(const PreviewAudioState()) {
    player.positionStream.listen((event) {
      add(UpdateEvent(position: player.position));

      if (player.position == player.duration) {
        logger.log("Bằng nhau", color: StrColor.red);
        player.play();
        }
    });

    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        logger.log("LOG playerStateStream $event", color: StrColor.red);
        switch (replayStatus) {
          case ReplayStatus.noReplay:
            add(const NextOrPrevEvent(isNext: true));
            break;
          case ReplayStatus.replayList:
            if (previewBookModel!.bookContentDto!.length > curentIndex) {
              add(const NextOrPrevEvent(isNext: true));
            } else {
              curentIndex = 0;
              add(const NextOrPrevEvent(isNext: false));
            }
            break;
          case ReplayStatus.replayOne:
            player.seek(Duration.zero);
            player.play();
            add(UpdateEvent(position: player.position));
            break;
          default:
        }
      }
    });

    on<InitListenEvent>(_onInitListen);
    on<PlayEvent>(_onPlayAudio);
    on<PauseEvent>(_onPauseAudio);
    on<SeekEvent>(_onSeekAudio);
    on<ChangeSpeedEvent>(_onChangeSpeedAudio);
    on<SelectAudioEvent>(_onSelectAudio);
    on<EndEvent>(_onEndAudio);
    on<ReplayEvent>(_onReplayAudio);
    on<NextOrPrevEvent>(_onNextOrPrevAudio);
    on<UpdateEvent>(_onUpdateAudio);
  }

  Future<void> _onInitListen(
      InitListenEvent event, Emitter<PreviewAudioState> emit) async {
    try {
      logger.log('listen');
      var checkPreview =
          await _bookDetailRepo.getListenPreviewData(id: event.bookId);
      if (checkPreview!.bookContentDto!.first.type == 0) {
        previewBookModel = checkPreview;
        linkAudio = ApiPath.getDetailImage +
            decryptAES(previewBookModel!.bookContentDto!.first.filePath!)
                .reverse();

        final duration = await player.setUrl(linkAudio);
        logger.log(duration, color: StrColor.magenta);
        player.play();

        emit(state.copyWith(
            previewBookModel: previewBookModel,
            status: AudioStatus.success,
            isPlaying: true,
            duration: duration));
      } else {
        showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) => MustBuyBook(
                price: BlocProvider.of<BookDetailBloc>(context)
                    .bookModel!
                    .audioBook!
                    .price
                    .toString(),
                type: 2));
        logger.log('first no preview');
      }
    } catch (e) {
      logger.log('Lỗi listen book : $e', color: StrColor.red);
      // emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<void> _onPlayAudio(
      PlayEvent event, Emitter<PreviewAudioState> emit) async {
    try {
      player.play();
      logger.log('Play Audio', color: StrColor.darkRed);
      emit(state.copyWith(isPlaying: true, status: AudioStatus.success));
    } catch (e) {
      logger.log('Error play : $e', color: StrColor.red);
    }
  }

  Future<void> _onPauseAudio(
      PauseEvent event, Emitter<PreviewAudioState> emit) async {
    try {
      await player.pause();
      logger.log('Pause Audio', color: StrColor.darkRed);

      emit(state.copyWith(isPlaying: false));
    } catch (e) {
      logger.log('Error pause : $e', color: StrColor.red);
    }
  }

  Future<void> _onSeekAudio(
      SeekEvent event, Emitter<PreviewAudioState> emit) async {
    try {
      await player.seek(event.seekValue);
      // emit(state.copyWith(isPlaying: true));
    } catch (e) {
      logger.log('Error pause : $e', color: StrColor.red);
    }
  }

  Future<void> _onChangeSpeedAudio(
      ChangeSpeedEvent event, Emitter<PreviewAudioState> emit) async {
    await player.setSpeed(event.speedValue);
    speed = event.speedValue;
    emit(state.copyWith(speed: speed,));
  }

  Future<void> _onEndAudio(
      EndEvent event, Emitter<PreviewAudioState> emit) async {
    try {
      await player.stop();
      emit(state.copyWith(status: AudioStatus.end));
    } catch (e) {
      logger.log('Error pause : $e', color: StrColor.red);
    }
  }

  Future<void> _onReplayAudio(
      ReplayEvent event, Emitter<PreviewAudioState> emit) async {
    try {
      currentReplayStatus++;
      replayStatus = currentReplayStatus % 3 == 0
          ? ReplayStatus.noReplay
          : currentReplayStatus % 3 == 1
              ? ReplayStatus.replayList
              : ReplayStatus.replayOne;
      emit(state.copyWith(replayStatus: replayStatus));
    } catch (e) {
      logger.log('Error replay : $e', color: StrColor.red);
    }
  }

  Future<void> _onSelectAudio(
      SelectAudioEvent event, Emitter<PreviewAudioState> emit) async {
    try {
      linkAudio = ApiPath.getDetailImage +
          decryptAES(previewBookModel!.bookContentDto!.first.filePath!)
              .reverse();

      final duration = await player.setUrl(linkAudio);
      logger.log(duration, color: StrColor.magenta);

      emit(state.copyWith(
          previewBookModel: previewBookModel,
          status: AudioStatus.success,
          duration: duration));
    } catch (e) {
      logger.log('Error pause : $e', color: StrColor.red);
    }
  }

  Future<void> _onNextOrPrevAudio(
      NextOrPrevEvent event, Emitter<PreviewAudioState> emit) async {
    try {
      int checkPreview = event.isNext
          ? curentIndex == previewBookModel!.bookContentDto!.length
              ? curentIndex
              : curentIndex + 1
          : curentIndex == 0
              ? curentIndex
              : curentIndex - 1;

      if (previewBookModel!.bookContentDto![checkPreview].type == 0) {
        curentIndex = checkPreview;
        linkAudio = ApiPath.getDetailImage +
            decryptAES(previewBookModel!.bookContentDto!.first.filePath!)
                .reverse();

        final duration = await player.setUrl(linkAudio);
        logger.log(duration, color: StrColor.magenta);

        emit(state.copyWith(
            previewBookModel: previewBookModel,
            status: AudioStatus.success,
            duration: duration));
      } else if (curentIndex == 0 && event.isNext == false) {
      } else {
        logger.log("curentIndex $curentIndex");
        await player.seek(Duration.zero);
        await player.pause();

        emit(state.copyWith(status: AudioStatus.success, isPlaying: false));
        return showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) => MustBuyBook(
                price: previewBookModel!.booksDetailsDto!.bookPrices!,
                type: 2));
      }
    } catch (e) {
      logger.log('Error pause : $e', color: StrColor.red);
    }
  }

  Future<void> _onUpdateAudio(
      UpdateEvent event, Emitter<PreviewAudioState> emit) async {
    try {
      emit(state.copyWith(
          isPlaying: event.isPlaying, position: event.position, speed: speed));
    } catch (e) {
      logger.log('Error update : $e', color: StrColor.red);
    }
  }
}
