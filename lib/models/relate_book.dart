import 'package:mocktest/models/book_genres.dart';

class RelatedBook {
    int id;
    String code;
    String name;
    String topicBookName;
    String avatar;
    String bookTypes;
    String bookDetailsCode;
    String bookDetailsId;
    String bookPrices;
    int minPrice;
    int view;
    String sellersName;
    String author;
    double avgRate;
    int totalSold;
    int totalReview;
    double hot;
    dynamic inWishlist;
    dynamic inCart;
    dynamic inPurchase;
    bool haveHot;
    bool haveBestSeller;
    BookGenres? hardBook;
    BookGenres? audioBook;
    BookGenres? ebook;

    RelatedBook({
        required this.id,
        required this.code,
        required this.name,
        required this.topicBookName,
        required this.avatar,
        required this.bookTypes,
        required this.bookDetailsCode,
        required this.bookDetailsId,
        required this.bookPrices,
        required this.minPrice,
        required this.view,
        required this.sellersName,
        required this.author,
        required this.avgRate,
        required this.totalSold,
        required this.totalReview,
        required this.hot,
        required this.inWishlist,
        required this.inCart,
        required this.inPurchase,
        required this.haveHot,
        required this.haveBestSeller,
         this.hardBook,
         this.audioBook,
         this.ebook,
    });

    factory RelatedBook.fromJson(Map<String, dynamic> json) => RelatedBook(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        topicBookName: json["topicBookName"],
        avatar: json["avatar"],
        bookTypes: json["bookTypes"],
        bookDetailsCode: json["bookDetailsCode"],
        bookDetailsId: json["bookDetailsId"],
        bookPrices: json["bookPrices"],
        minPrice: json["minPrice"],
        view: json["view"],
        sellersName: json["sellersName"],
        author: json["author"],
        avgRate: json["avgRate"],
        totalSold: json["totalSold"],
        totalReview: json["totalReview"],
        hot: json["hot"],
        inWishlist: json["inWishlist"],
        inCart: json["inCart"],
        inPurchase: json["inPurchase"],
        haveHot: json["haveHot"],
        haveBestSeller: json["haveBestSeller"],
        hardBook: json["hardBook"] != null ? BookGenres.fromJson(json["hardBook"]) : null,
        audioBook: json["audioBook"] != null ? BookGenres.fromJson(json["audioBook"]) : null,
        ebook: json["ebook"] != null ?  BookGenres.fromJson(json["ebook"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "topicBookName": topicBookName,
        "avatar": avatar,
        "bookTypes": bookTypes,
        "bookDetailsCode": bookDetailsCode,
        "bookDetailsId": bookDetailsId,
        "bookPrices": bookPrices,
        "minPrice": minPrice,
        "view": view,
        "sellersName": sellersName,
        "author": author,
        "avgRate": avgRate,
        "totalSold": totalSold,
        "totalReview": totalReview,
        "hot": hot,
        "inWishlist": inWishlist,
        "inCart": inCart,
        "inPurchase": inPurchase,
        "haveHot": haveHot,
        "haveBestSeller": haveBestSeller,
        "hardBook": hardBook?.toJson(),
        "audioBook": audioBook?.toJson(),
        "ebook": ebook?.toJson(),
    };
}