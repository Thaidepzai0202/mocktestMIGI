
import 'package:mocktest/models/book_model.dart';
import 'package:mocktest/models/book_genres.dart';
import 'package:mocktest/models/revirew_model.dart';

List<String> imageBeautiful = [
  'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  'https://static.vecteezy.com/system/resources/thumbnails/025/067/762/small_2x/4k-beautiful-colorful-abstract-wallpaper-photo.jpg',
  'https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg?size=626&ext=jpg&ga=GA1.1.1700460183.1712707200&semt=ais',
  'https://scontent.fhan17-1.fna.fbcdn.net/v/t39.30808-6/337699790_598361892326349_4216474606102441905_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=5f2048&_nc_ohc=hkmAuuUI9gQAb6GFjJW&_nc_ht=scontent.fhan17-1.fna&oh=00_AfBL6w_rPeHV9huUDyDTPod0nzkCZv6E_60jSprUD7foUw&oe=661D3C26'
];

BookModel ex2 = BookModel(
    id: 203,
    code: 'BK202453670',
    name: 'Milk And Honey',
    topicBookId: 298,
    avatar:
        "/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/985c0f00b6aec4b7a38b4001e5555d80c85443f0c6ab7895a1a3e4e32521f2aa/z5106116872942_1a8d0351607b931483bac0a3306b5a07.jpg",
    avgRate: 3.5,
    totalSold: 100,
    totalReview: 150,
    author: 'Nguyễn Thế Thái',
    publisher:
        'Nhà xuất bải Thái Bình hiệp chung quốc hoa kì cùng hãng đường sắt hải dương xin được tài trọ chương trình này',
    bookDetailsCode: "BK2024536701,BK2024536702",
    bookDetailsId: "959,960",
    bookTypes: '0.1.2',
    bookPrices: '2222',
    sellersName: "My Pham はな🌸 My Pham はな🌸 My Pham はな🌸 My Pham はな🌸",
    issuer: 'THAIDEPZAI',
    translator: 'Dịch giả Thế Thái',
    pageNumber: 333,
    publicationTime: DateTime(2024, 1, 29),
    coverType: 0,
    dimension: '13 x 20 x 10.5 cm',
    description:
        'Có bao giờ bạn chợt ngồi lại nghĩ về thời gian mà bạn đã trải qua như thế nào? Có bao giờ bạn nghĩ đến giá trị của quãng thời gian ấy, cái gọi là tuổi trẻ? “ Nếu tôi còn ở tuổi đôi mươi, hẳn là tôi sẽ đọc Tuổi trẻ đáng giá bao nhiêu? Nhiều hơn một lần” đó là lời nói của tác giả - nhà báo Đặng Nguyễn Đông Vy nhận định về cuốn sách “Tuổi trẻ đáng giá bao nhiêu”. Chỉ với 285 trang sách tác giả Rosie Nguyễn sẽ giúp ích rất nhiều cho những bạn trẻ chuẩn bị bước vào những tháng năm đẹp nhất của cuộc đời – cái mà người ta gọi là thanh xuân.',
    sellerIsdn: '1682311065907',
    sellerAvatar:
        'https://e1.pxfuel.com/desktop-wallpaper/360/449/desktop-wallpaper-angela-yeung-wing-asian-girls-chinese-models-beauty-brunette-angelababy-with-resolution-1920x1200-high-quality-chinese-models.jpg',
    sellerFullname: 'Thế Thái Seller',
    sellerSubject: 'Lập trình hướng đối tượng, Ngôn ngữ lập trình 2',
    sellerSpecializeLevel: '0',
    sellerExp: '2',
    sellerDepartment: 'Không có gì',
    sellerIntro:
        "- Là một người yêu tiếng Anh, cô My Pham rất mong muốn truyền tải những nét đẹp, nét hay của thứ ngôn ngữ toàn cầu này cho các thế hệ học trò. Điều này được thể hiện rõ thông qua quá trình tương tác với các em học sinh. Cô My luôn sẵn sàng trả lời mọi câu hỏi của các em học sinh bất kể cô đang bận hay cơ thể đang mệt mỏi.\n\n- Với kinh nghiệm nhiều năm giảng dạy và ôn thi đại học môn tiếng anh, cô đưa ra những kiến thức trọng tâm, phù hợp với xu hướng ra đề thi.\n\n- Cô có cách truyền đạt rõ ràng, nhẹ nhàng, luôn giữ được sự hoạt bát, năng động, tươi trẻ trong suốt bài giảng giúp duy trì sự hứng thú của học sinh khiến học sinh không còn cảm giác sợ môn Tiếng Anh, ngược lại còn giúp các em hứng thú và yêu thích môn học này hơn.",
    inCart: null,
    inPurchase: null,
    inWishlist: null,
    haveHot: false,
    haveBestSeller: false,
    hardBook: null,
    audioBook: BookGenres(
        id: 960,
        code: "BK2024536702",
        type: 2,
        price: 1500,
        inCart: null,
        inPurchase: null),
    ebook: BookGenres(
        id: 959,
        code: "BK2024536701",
        type: 1,
        price: 1300,
        inCart: null,
        inPurchase: null));

ListReview listReview1 = ListReview(
    id: 534,
    rate: 4,
    contentBuyer: "Chửa hoa mà giữa trái.",
    parentId: null,
    createTime: DateTime.parse("2024-02-23T11:00:55Z"),
    createName: '1682311065907',
    productType: 3,
    productCode: "NN001",
    purchaseDetailsId: null,
    filePathBuyer:
        "/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/b806efaa9648402bcc657dff58733d4225041e35f2b402a0e3f43ace4da2c21c/7ad6361ca5258a422b4fc99ead23f6f7.jpg",
    fileIdBuyer: '65d87ae6cd02561635ef6133',
    fileNameBuyer: '7ad6361ca5258a422b4fc99ead23f6f7.jpg',
    listFileBuyer: [listFile1, listFile2],
    avatarBuyer:
        '/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/47d9dca7a37ce7bc282666c1b75ed241e4b46a5641da874bd32d1802bf918b20/Ảnh%20chụp%20Màn%20hình%202024-04-16%20lúc%2013.40.24.png',
    fullNameBuyer: 'Thế Thái reviewer',
    contentSeller: null,
    filePathSeller: null,
    fileIdSeller: null,
    fileNameSeller: null,
    listFileSeller: [],
    avatarSeller: null,
    fullNameSeller: null);
ListReview listReview2 = ListReview(
    id: 535,
    rate: 4,
    contentBuyer: "hahahahaha",
    parentId: null,
    createTime: DateTime.parse("2024-02-23T11:00:55Z"),
    createName: '1682311065907',
    productType: 3,
    productCode: "NN001",
    purchaseDetailsId: null,
    filePathBuyer:
        "/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/b806efaa9648402bcc657dff58733d4225041e35f2b402a0e3f43ace4da2c21c/7ad6361ca5258a422b4fc99ead23f6f7.jpg",
    fileIdBuyer: '65d87ae6cd02561635ef6133',
    fileNameBuyer: '7ad6361ca5258a422b4fc99ead23f6f7.jpg',
    listFileBuyer: [listFile1, listFile2],
    avatarBuyer:
        '/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/47d9dca7a37ce7bc282666c1b75ed241e4b46a5641da874bd32d1802bf918b20/Ảnh%20chụp%20Màn%20hình%202024-04-16%20lúc%2013.40.24.png',
    fullNameBuyer: 'Lương',
    contentSeller: null,
    filePathSeller: null,
    fileIdSeller: null,
    fileNameSeller: null,
    listFileSeller: [],
    avatarSeller: null,
    fullNameSeller: null);
ListReview listReview3 = ListReview(
    id: 536,
    rate: 5,
    contentBuyer: "Great",
    parentId: null,
    createTime: DateTime.parse("2024-02-23T11:00:55Z"),
    createName: '1682311065907',
    productType: 3,
    productCode: "NN001",
    purchaseDetailsId: null,
    filePathBuyer:
        "/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/b806efaa9648402bcc657dff58733d4225041e35f2b402a0e3f43ace4da2c21c/7ad6361ca5258a422b4fc99ead23f6f7.jpg",
    fileIdBuyer: '65d87ae6cd02561635ef6133',
    fileNameBuyer: '7ad6361ca5258a422b4fc99ead23f6f7.jpg',
    listFileBuyer: [listFile1, listFile2],
    avatarBuyer:
        '/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/47d9dca7a37ce7bc282666c1b75ed241e4b46a5641da874bd32d1802bf918b20/Ảnh%20chụp%20Màn%20hình%202024-04-16%20lúc%2013.40.24.png',
    fullNameBuyer: 'Thế Thái reviewer',
    contentSeller: null,
    filePathSeller: null,
    fileIdSeller: null,
    fileNameSeller: null,
    listFileSeller: [],
    avatarSeller: null,
    fullNameSeller: null);
ListReview listReview4 = ListReview(
    id: 537,
    rate: 3,
    contentBuyer:
        "Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá Hay quá xá ",
    parentId: null,
    createTime: DateTime.parse("2024-02-23T11:00:55Z"),
    createName: '1682311065907',
    productType: 3,
    productCode: "NN001",
    purchaseDetailsId: null,
    filePathBuyer:
        "/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/b806efaa9648402bcc657dff58733d4225041e35f2b402a0e3f43ace4da2c21c/7ad6361ca5258a422b4fc99ead23f6f7.jpg",
    fileIdBuyer: '65d87ae6cd02561635ef6133',
    fileNameBuyer: '7ad6361ca5258a422b4fc99ead23f6f7.jpg',
    listFileBuyer: [listFile2, listFile2],
    avatarBuyer:
        '/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/47d9dca7a37ce7bc282666c1b75ed241e4b46a5641da874bd32d1802bf918b20/Ảnh%20chụp%20Màn%20hình%202024-04-16%20lúc%2013.40.24.png',
    fullNameBuyer: 'Thế Thái beat',
    contentSeller: null,
    filePathSeller: null,
    fileIdSeller: null,
    fileNameSeller: null,
    listFileSeller: [],
    avatarSeller: null,
    fullNameSeller: null);

ListFile listFile1 = ListFile(
    fileId: '65d87ae6cd02561635ef6133',
    fileName: '7ad6361ca5258a422b4fc99ead23f6f7.jpg',
    path:
        '/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/b806efaa9648402bcc657dff58733d4225041e35f2b402a0e3f43ace4da2c21c/7ad6361ca5258a422b4fc99ead23f6f7.jpg',
    type: 0);
ListFile listFile2 = ListFile(
    fileId: '65d87ae6cd02561635ef6133',
    fileName: '7ad6361ca5258a422b4fc99ead23f6f7.jpg',
    path:
        '/laosedu/4fc25ce6eb8c97f4cb1deb10be041ce3/47d9dca7a37ce7bc282666c1b75ed241e4b46a5641da874bd32d1802bf918b20/Ảnh%20chụp%20Màn%20hình%202024-04-16%20lúc%2013.40.24.png',
    type: 0);

// ReviewModel reviewModel1 = ReviewModel(
//     total4: 4,
//     total5: 5,
//     total1: 1,
//     total2: 2,
//     total3: 3,
//     listReview: [listReview1, listReview2, listReview3, listReview4],
//     totalReview: 15);
