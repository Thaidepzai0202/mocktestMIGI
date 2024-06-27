part of 'readbook_bloc.dart';

final class ReadbookState extends Equatable {
  final PostStatus status;
  final PreviewBookModel? previewBookModel;
  final String? remotePDFpath;
  final bool hasReachedMax;

  const ReadbookState(
      {this.previewBookModel,
      this.remotePDFpath,
      this.status = PostStatus.initial,
      this.hasReachedMax = false});

  ReadbookState copyWith(
      {PreviewBookModel? previewBookModel,
      String? remotePDFpath,
      bool? hasReachedMax,
      PostStatus? status}) {
    return ReadbookState(
        previewBookModel: previewBookModel ?? this.previewBookModel,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        remotePDFpath: remotePDFpath ?? this.remotePDFpath);
  }

  @override
  List<Object> get props => [
        previewBookModel ?? PreviewBookModel(),
        remotePDFpath ?? '',
        status,
        hasReachedMax
      ];
}

final class ReadbookInitial extends ReadbookState {}
