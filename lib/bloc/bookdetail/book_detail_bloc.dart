import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mocktest/models/book_model.dart';
import 'package:mocktest/models/preview_book_model.dart';
import 'package:mocktest/models/relate_book.dart';
import 'package:mocktest/models/revirew_model.dart';
import 'package:mocktest/services/book_detail_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:mocktest/services/logger.dart';
part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final BookDetailRepo _bookDetailRepo = BookDetailRepo();
  BookModel? bookModel;
  ReviewModel? reviewModel = ReviewModel();
  List<RelatedBook> listRelateBook = [];
  PreviewBookModel? previewBookModel;

  BookDetailBloc() : super(const BookDetailState()) {
    on<InitDetailEvent>(_onInitDetail);
    on<ReviewBookEvent>(_onInitReview);
    on<SelectTypeEvent>(_onSelectType);
  }

  Future<void> _onInitDetail(
      InitDetailEvent event, Emitter<BookDetailState> emit) async {
    try {
      emit(state.copyWith(status: PostStatus.initial));

      bookModel = await _bookDetailRepo.getDetailBokData(id: event.id);
      listRelateBook = await _bookDetailRepo.getRelateBookData(
          isdnSeller: bookModel!.sellerIsdn!);

      emit(state.copyWith(
        status: PostStatus.success,
        listRelateBook: listRelateBook,
        type: _firstSelectType(bookModel!.bookTypes!),
        bookModel: bookModel!,
      ));
    } catch (e) {
      logger.log('Lowww');
    }
  }

  Future<void> _onInitReview(
      ReviewBookEvent event, Emitter<BookDetailState> emit) async {
    try {
      reviewModel = await _bookDetailRepo.getReviewData(
          productCode: bookModel!.code!, rate: event.rate);
      // print("reviewModel $reviewModel");
      emit(
          state.copyWith(reviewModel: reviewModel, status: PostStatus.success));
      logger.log('Init Review ${bookModel!.code}');
    } catch (e) {
      logger.log('Lỗi review $e');
    }
  }

  Future<void> _onSelectType(
      SelectTypeEvent event, Emitter<BookDetailState> emit) async {
    try {
      emit(state.copyWith(type: event.type));
      logger.log('Type Select');
    } catch (e) {
      logger.log('Lỗi review $e');
    }
  }

  int _firstSelectType(String bookType) {
    final isHardBook = bookType.contains('0') ? true : false;
    final isEbook = bookType.contains('1') ? true : false;
    return isHardBook
        ? 0
        : isEbook
            ? 1
            : 2;
  }
}
