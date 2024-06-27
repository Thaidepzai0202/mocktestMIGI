part of 'readbook_bloc.dart';

sealed class ReadbookEvent extends Equatable {
  const ReadbookEvent();

  @override
  List<Object> get props => [];
}


final class InitReadEvent extends ReadbookEvent{
  final int bookId;
  final int bookType;
  const InitReadEvent({required this.bookId, required this.bookType});
}
final class SelectReadEvent extends ReadbookEvent{
  final String filePath;
  const SelectReadEvent({required this.filePath,});
}