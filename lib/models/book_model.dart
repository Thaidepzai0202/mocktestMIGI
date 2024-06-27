import 'package:mocktest/models/book_genres.dart';

class BookModel {
    int? id;
    String? code;
    String? name;
    int? topicBookId;
    String? avatar;
    double? avgRate;
    int? totalSold;
    int? totalReview;
    String? author;
    String? publisher;
    String? bookDetailsCode;
    String? bookDetailsId;
    String? bookTypes;
    String? bookPrices;
    String? sellersName;
    String? issuer;
    String? translator;
    int? pageNumber;
    DateTime? publicationTime;
    int? coverType;
    String? dimension;
    String? description;
    String? sellerIsdn;
    String? sellerAvatar;
    String? sellerFullname;
    String? sellerSubject;
    String? sellerSpecializeLevel;
    String? sellerExp;
    String? sellerDepartment;
    String? sellerIntro;
    dynamic inCart;
    dynamic inPurchase;
    dynamic inWishlist;
    bool? haveHot;
    bool? haveBestSeller;
    BookGenres? hardBook;
    BookGenres? audioBook;
    BookGenres? ebook;

    BookModel({
         this.id,
         this.code,
         this.name,
         this.topicBookId,
         this.avatar,
         this.avgRate,
         this.totalSold,
         this.totalReview,
         this.author,
         this.publisher,
         this.bookDetailsCode,
         this.bookDetailsId,
         this.bookTypes,
         this.bookPrices,
         this.sellersName,
         this.issuer,
         this.translator,
         this.pageNumber,
         this.publicationTime,
         this.coverType,
         this.dimension,
         this.description,
         this.sellerIsdn,
         this.sellerAvatar,
         this.sellerFullname,
         this.sellerSubject,
         this.sellerSpecializeLevel,
         this.sellerExp,
         this.sellerDepartment,
         this.sellerIntro,
         this.inCart,
         this.inPurchase,
         this.inWishlist,
         this.haveHot,
         this.haveBestSeller,
         this.hardBook,
         this.audioBook,
         this.ebook,
    });

    factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        topicBookId: json["topicBookId"],
        avatar: json["avatar"],
        avgRate: json["avgRate"],
        totalSold: json["totalSold"],
        totalReview: json["totalReview"],
        author: json["author"],
        publisher: json["publisher"],
        bookDetailsCode: json["bookDetailsCode"],
        bookDetailsId: json["bookDetailsId"],
        bookTypes: json["bookTypes"],
        bookPrices: json["bookPrices"],
        sellersName: json["sellersName"],
        issuer: json["issuer"],
        translator: json["translator"],
        pageNumber: json["pageNumber"],
        publicationTime: DateTime.parse(json["publicationTime"]),
        coverType: json["coverType"],
        dimension: json["dimension"],
        description: json["description"],
        sellerIsdn: json["sellerIsdn"],
        sellerAvatar: json["sellerAvatar"],
        sellerFullname: json["sellerFullname"],
        sellerSubject: json["sellerSubject"],
        sellerSpecializeLevel: json["sellerSpecializeLevel"],
        sellerExp: json["sellerExp"],
        sellerDepartment: json["sellerDepartment"],
        sellerIntro: json["sellerIntro"],
        inCart: json["inCart"],
        inPurchase: json["inPurchase"],
        inWishlist: json["inWishlist"],
        haveHot: json["haveHot"],
        haveBestSeller: json["haveBestSeller"],
        hardBook: json["hardBook"] != null ? BookGenres.fromJson(json["hardBook"]) : null,
        audioBook: json["audioBook"] != null ? BookGenres.fromJson(json["audioBook"]) : null,
        ebook: json["ebook"] != null ?  BookGenres.fromJson(json["ebook"]) : null,
    );

    }

class Book {
    int? id;
    String? code;
    int? type;
    int? price;
    dynamic inCart;
    dynamic inPurchase;

    Book({
         this.id,
         this.code,
         this.type,
         this.price,
         this.inCart,
         this.inPurchase,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        price: json["price"],
        inCart: json["inCart"],
        inPurchase: json["inPurchase"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "type": type,
        "price": price,
        "inCart": inCart,
        "inPurchase": inPurchase,
    };
}
