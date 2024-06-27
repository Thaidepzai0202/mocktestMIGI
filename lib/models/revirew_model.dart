

class ReviewModel {
  ReviewRate? listReviewRate;
  List<ListReview>? listReview;
  int? totalReview;

  ReviewModel({
     this.listReviewRate,
     this.listReview,
    this.totalReview,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        listReviewRate: ReviewRate.fromJson(json['listReviewRate']),
        listReview: List<ListReview>.from(
            json["listReview"].map((x) => ListReview.fromJson(x))),
        totalReview: json["totalReview"] ?? 0,
      );

}

class ListReview {
  int? id;
  int? rate;
  String? contentBuyer;
  dynamic parentId;
  DateTime? createTime;
  String? createName;
  int? productType;
  String? productCode;
  dynamic purchaseDetailsId;
  String? filePathBuyer;
  String? fileIdBuyer;
  String? fileNameBuyer;
  List<ListFile>? listFileBuyer;
  String? avatarBuyer;
  String? fullNameBuyer;
  String? contentSeller;
  String? filePathSeller;
  String? fileIdSeller;
  String? fileNameSeller;
  List<ListFile>? listFileSeller;
  String? avatarSeller;
  String? fullNameSeller;

  ListReview({
    this.id,
    this.rate,
     this.contentBuyer,
     this.parentId,
     this.createTime,
     this.createName,
    this.productType,
     this.productCode,
     this.purchaseDetailsId,
     this.filePathBuyer,
     this.fileIdBuyer,
     this.fileNameBuyer,
      this.listFileBuyer,
     this.avatarBuyer,
     this.fullNameBuyer,
     this.contentSeller,
     this.filePathSeller,
     this.fileIdSeller,
     this.fileNameSeller,
      this.listFileSeller,
     this.avatarSeller,
     this.fullNameSeller,
  });

  factory ListReview.fromJson(Map<String, dynamic> json) => ListReview(
        id: json["id"] ?? 0,
        rate: json["rate"] ?? 0,
        contentBuyer: json["contentBuyer"],
        parentId: json["parentId"],
        createTime: DateTime.parse(json["createTime"]),
        createName: json["createName"],
        productType: json["productType"] ?? 0,
        productCode: json["productCode"],
        purchaseDetailsId: json["purchaseDetailsId"],
        filePathBuyer: json["filePathBuyer"],
        fileIdBuyer: json["fileIdBuyer"],
        fileNameBuyer: json["fileNameBuyer"],
        listFileBuyer: json['listFileBuyer']!=null ? List<ListFile>.from(
            json["listFileBuyer"].map((x) => ListFile.fromJson(x))) : null,
        avatarBuyer: json["avatarBuyer"],
        fullNameBuyer: json["fullNameBuyer"],
        contentSeller: json["contentSeller"],
        filePathSeller: json["filePathSeller"],
        fileIdSeller: json["fileIdSeller"],
        fileNameSeller: json["fileNameSeller"],
        listFileSeller: json["listFileSeller"]!=null ? List<ListFile>.from( 
            json["listFileSeller"].map((x) => ListFile.fromJson(x))) : null,
        avatarSeller: json["avatarSeller"],
        fullNameSeller: json["fullNameSeller"],
      );

 }

class ListFile {
  String? fileId;
  String? fileName;
  String? path;
  int? type;

  ListFile({
     this.fileId,
     this.fileName,
     this.path,
      this.type,
  });

  factory ListFile.fromJson(Map<String, dynamic> json) => ListFile(
        fileId: json["fileId"],
        fileName: json["fileName"],
        path: json["path"],
        type: json["type"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "fileName": fileName,
        "path": path,
        "type": type ?? 0,
      };
}

class ReviewRate {
    int? totalRate4;
    int? totalRate5;
    int? totalRate1;
    int? totalRate2;
    int? totalRate3;

    ReviewRate({
          this.totalRate4,
          this.totalRate5,
          this.totalRate1,
          this.totalRate2,
          this.totalRate3,
    });

    factory ReviewRate.fromJson(Map<String, dynamic> json) => ReviewRate(
        totalRate4: json["totalRate4"] ?? 0,
        totalRate5: json["totalRate5"] ?? 0,
        totalRate1: json["totalRate1"] ?? 0,
        totalRate2: json["totalRate2"] ?? 0,
        totalRate3: json["totalRate3"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "totalRate4": totalRate4,
        "totalRate5": totalRate5,
        "totalRate1": totalRate1,
        "totalRate2": totalRate2,
        "totalRate3": totalRate3,
    };
}

