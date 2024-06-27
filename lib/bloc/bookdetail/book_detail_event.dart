part of 'book_detail_bloc.dart';

@immutable
sealed class BookDetailEvent {}

class InitDetailEvent extends BookDetailEvent {
  final int id;

  InitDetailEvent({required this.id});
}

class SelectRelatedBook extends BookDetailEvent {
  final int id;

  SelectRelatedBook({required this.id});
}

class ReviewBookEvent extends BookDetailEvent {
  final int rate;
  // String productCode;

  ReviewBookEvent({required this.rate});
}

class SelectTypeEvent extends BookDetailEvent {
  final int type;

  SelectTypeEvent({required this.type});
}
