part of 'book_detail_bloc.dart';



enum PostStatus { initial, success, failure,end,mustBuy }


final class BookDetailState extends Equatable {
  final PostStatus status;
  final BookModel? bookModel;
 final ReviewModel? reviewModel;
  final List<RelatedBook>? listRelatedBook ;
  final int? type;
  final bool hasReachedMax;

  const BookDetailState(
      { this.listRelatedBook,
       this.bookModel,
      this.status = PostStatus.initial,
      this.hasReachedMax = false,
      this.reviewModel,
      this.type =0});

  BookDetailState copyWith(
      {PostStatus? status,
      BookModel? bookModel,
      ReviewModel? reviewModel,
      List<RelatedBook>? listRelateBook,
      int? type,
      bool? hasReachedMax}) {
    return BookDetailState(
        listRelatedBook: listRelateBook ?? listRelatedBook,
        bookModel: bookModel ?? this.bookModel,
        reviewModel: reviewModel ?? this.reviewModel,
        status: status ?? this.status,
        type: type ?? this.type,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [
        status,
        bookModel??BookModel(),
        reviewModel ?? ReviewModel(),
        listRelatedBook??[],
        hasReachedMax,
        type??0
      ];
}
