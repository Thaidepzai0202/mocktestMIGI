class BookGenres {
  int id;
  String? code;
  int? type;
  int? price;
  dynamic inCart;
  dynamic inPurchase;

  BookGenres({
    required this.id,
     this.code,
     this.type,
     this.price,
     this.inCart,
     this.inPurchase,
  });

  factory BookGenres.fromJson(Map<String, dynamic> json) => BookGenres(
        id: json["id"],
        code: json["code"] ?? "",
        type: json["type"] ?? 0,
        price: json["price"] ?? 0,
        inCart: json["inCart"] ?? "",
        inPurchase: json["inPurchase"] ?? "",
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
