import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktest/constants/api_path.dart';
import 'package:mocktest/models/book_model.dart';
import 'package:mocktest/models/preview_book_model.dart';
import 'package:mocktest/models/relate_book.dart';
import 'package:mocktest/models/revirew_model.dart';
import 'package:mocktest/services/decode.dart';
import 'package:mocktest/services/logger.dart';

class BookDetailRepo {
  // Future<List<RelatedBook>> getData(String url) async {
  Future<List<RelatedBook>> getRelateBookData(
      {required String isdnSeller}) async {
    List<RelatedBook> listRelateBook = [];

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      "topicBookId": null,
      "seller": null,
      "isdnSeller": isdnSeller,
      "type": [],
      "rate": [],
      "priceFrom": null,
      "priceTo": null,
      "page": 0,
      "pageSize": 8,
      "order": 1
    };

    final check = jsonEncode(body);

    var res = await http.post(Uri.parse(ApiPath.getRalateBookData),
        headers: headers, body: check);
    if (res.statusCode == 200) {
      List<dynamic> result =
          json.decode(utf8.decode(res.bodyBytes))['data']['content'];
      listRelateBook = result.map((e) => RelatedBook.fromJson(e)).toList();

      // logger.log(listRelateBook);
    }
    return listRelateBook;
  }

  Future<BookModel> getDetailBokData({required int id}) async {
    BookModel? bookModel;

    var res = await http.get(Uri.parse('${ApiPath.getDetailBookData}$id'));
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes))['data'];
      bookModel = BookModel.fromJson(result);
    } else {
      logger.log(res.statusCode);
    }
    return bookModel!;
  }

  Future<ReviewModel?> getReviewData(
      {required String productCode, required int rate}) async {
    ReviewModel? reviewModel;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "productCode": productCode,
      "productType": "3",
      "rate": rate
    };
    final check = jsonEncode(body);
    var res = await http.post(Uri.parse(ApiPath.getReviewData),
        headers: headers, body: check);
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes))['data'];
      reviewModel = ReviewModel.fromJson(result);

      logger.log(result);
    } else {
      logger.log('Looi getReviewData ${res.statusCode}');
    }

    return reviewModel ?? ReviewModel();
  }

  Future<PreviewBookModel?> getReadPreviewData({required int id}) async {
    var res = await http.get(Uri.parse(ApiPath.getReadPreview + id.toString()));
    PreviewBookModel? previewBookModel;

    if (res.statusCode == 200) {
      logger.log('callAPi',color: StrColor.green);
      logger.log(id,color: StrColor.green);
      var result = json.decode(utf8.decode(res.bodyBytes))['data'];
      logger.log(result.toString(),color: StrColor.green);
      previewBookModel = PreviewBookModel.fromJson(result);
      // logger.log(previewBookModel.bookContentDto!.first.filePath);
      logger.log(ApiPath.getDetailImage +
          decryptAES(previewBookModel.bookContentDto!.first.filePath)
              .reverse(),color: StrColor.green);
    } else {
      logger.log('Looi roiii ${res.statusCode}');
    }

    return previewBookModel;
  }

  Future<PreviewBookModel?> getListenPreviewData({required int id}) async {
    var res =
        await http.get(Uri.parse(ApiPath.getListenPreview + id.toString()));
    PreviewBookModel? previewBookModel;

    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes))['data'];
      // logger.log(result);
      previewBookModel = PreviewBookModel.fromJson(result);
    } else {
      logger.log('Looi roiii ${res.statusCode}');
    }

    return previewBookModel;
  }
}
