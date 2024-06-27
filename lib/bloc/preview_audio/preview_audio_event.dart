part of 'preview_audio_bloc.dart';

sealed class PreviewAudioEvent extends Equatable {
  const PreviewAudioEvent();

  @override
  List<Object> get props => [];
}

final class InitListenEvent extends PreviewAudioEvent {
  final int bookId;
  final int bookType;
  const InitListenEvent({required this.bookId, required this.bookType});
}

final class PlayEvent extends PreviewAudioEvent {}

final class PauseEvent extends PreviewAudioEvent {}


final class SeekEvent extends PreviewAudioEvent {
  final Duration seekValue;

  const SeekEvent({required  this.seekValue});
}

final class ChangeSpeedEvent extends PreviewAudioEvent {
  final double speedValue;

  const ChangeSpeedEvent({required this.speedValue});
}

final class EndEvent extends PreviewAudioEvent {}

final class SelectAudioEvent extends PreviewAudioEvent {
  final String pathFile;

  const SelectAudioEvent({required this.pathFile});
}

final class NextOrPrevEvent extends PreviewAudioEvent{
  final bool isNext;

  const NextOrPrevEvent({required this.isNext});
}

final class ReplayEvent extends PreviewAudioEvent {}

final class UpdateEvent extends PreviewAudioEvent {
  final bool? isPlaying;
  final Duration? position;

  const UpdateEvent({this.isPlaying,this.position});
}
