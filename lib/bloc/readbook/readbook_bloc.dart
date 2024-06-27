import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/constants/api_path.dart';
import 'package:mocktest/models/preview_book_model.dart';
import 'package:mocktest/services/book_detail_repo.dart';
import 'package:mocktest/services/decode.dart';
import 'package:mocktest/services/logger.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

part 'readbook_event.dart';
part 'readbook_state.dart';

class ReadbookBloc extends Bloc<ReadbookEvent, ReadbookState> {
  final BookDetailRepo _bookDetailRepo = BookDetailRepo();
  PreviewBookModel? previewBookModel;

  ReadbookBloc() : super(const ReadbookState()) {
    on<InitReadEvent>(_onInitRead);
    on<SelectReadEvent>(_onSelect);
  }

  Future<void> _onInitRead(
      InitReadEvent event, Emitter<ReadbookState> emit) async {
    try {
      String remotePDFpath = '';
      logger.log('read');
      previewBookModel =
          await _bookDetailRepo.getReadPreviewData(id: event.bookId);
      if (previewBookModel!.bookContentDto!.first.type == 0) {
        await createFileOfPdfUrl(ApiPath.getDetailImage +
                decryptAES(previewBookModel!.bookContentDto!.first.filePath!)
                    .reverse())
            .then((f) async {
          logger.log(ApiPath.getDetailImage +
              decryptAES(previewBookModel!.bookContentDto!.first.filePath!)
                  .reverse());
          remotePDFpath = f.path;
        });

        emit(state.copyWith(
          previewBookModel: previewBookModel,
          status: PostStatus.success,
          remotePDFpath: remotePDFpath,
        ));
      } else {
        emit(state.copyWith(status: PostStatus.mustBuy));
      }
    } catch (e) {
      logger.log('Lỗi read book : $e');
    }
  }

  Future<void> _onSelect(
      SelectReadEvent event, Emitter<ReadbookState> emit) async {
    try {
      String remotePDFpath = '';
      logger.log('select');
      await createFileOfPdfUrl(
              ApiPath.getDetailImage + decryptAES(event.filePath).reverse())
          .then((f) {
        remotePDFpath = f.path;
      });
      emit(state.copyWith(
        remotePDFpath: remotePDFpath,
      ));
    } catch (e) {
      logger.log('Lỗi select book : $e');
    }
  }

  Future<File> createFileOfPdfUrl(String linkPDF) async {
    Completer<File> completer = Completer();
    // print("Start download file from internet!");
    try {
      final url = linkPDF;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      // print("Download files");
      // print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
