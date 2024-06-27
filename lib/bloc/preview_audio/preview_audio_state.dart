part of 'preview_audio_bloc.dart';

enum AudioStatus { initial, success, failure,end,mustBuy}

enum ReplayStatus {noReplay,replayList,replayOne}

final class PreviewAudioState extends Equatable {
  final AudioStatus status;
  final PreviewBookModel? previewBookModel;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final bool hasReachedMax;
  final double speed;
  final ReplayStatus replayStatus;

  const PreviewAudioState(
      {this.previewBookModel,
      this.status = AudioStatus.initial,
      this.isPlaying = false,
      this.duration = Duration.zero,
      this.position = Duration.zero,
      this.speed = 1,
      this.replayStatus = ReplayStatus.noReplay,
      this.hasReachedMax = false});

  PreviewAudioState copyWith(
      {PreviewBookModel? previewBookModel,
      bool? isPlaying,
      Duration? duration,
      Duration? position,
      bool? hasReachedMax,
      double? speed,
      ReplayStatus? replayStatus,
      AudioStatus? status}) {
    return PreviewAudioState(
        previewBookModel: previewBookModel ?? this.previewBookModel,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isPlaying: isPlaying ?? this.isPlaying,
        position: position ?? this.position,
        duration:  duration ?? this.duration,
        speed: speed ?? this.speed,
        replayStatus: replayStatus ?? this.replayStatus
        );
  }

  @override
  List<Object?> get props => [
        previewBookModel,
        isPlaying,
        status,
        hasReachedMax,
        position,
        duration,
        replayStatus,
        speed
      ];
}
