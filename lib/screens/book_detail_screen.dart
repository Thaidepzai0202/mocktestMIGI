import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/bloc/preview_audio/preview_audio_bloc.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/models/book_model.dart';
import 'package:mocktest/models/relate_book.dart';
import 'package:mocktest/widgets/bottom_bar.dart';
import 'package:mocktest/widgets/mini_audio_bok.dart';
import 'package:mocktest/widgets/information_book.dart';
import 'package:mocktest/widgets/quantity_buy.dart';
import 'package:mocktest/widgets/relate_book_widget.dart';
import 'package:mocktest/widgets/show_image_book.dart';
import 'package:mocktest/widgets/show_title_book.dart';

class BookDetailScreen extends StatefulWidget {
  final int id;
  const BookDetailScreen({super.key, required this.id});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _isListening = false;
  BookModel? bookModel;
  int? type;
  List<RelatedBook> listRelatedBook = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookDetailBloc>(context)
        .add(InitDetailEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: AppColors.white,
      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          if (state.status == PostStatus.success) {
            bookModel = state.bookModel;
            listRelatedBook = state.listRelatedBook!;
            type = state.type;
            return Column(
              children: [
                _appBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              ShowImagesBook2(
                                listPath:
                                    bookModel!.avatar!.split(',').toList(),
                              ),
                              ShowTitleBook(
                                bookModel: bookModel!,
                                type: type ?? 0,
                              ),
                              QuantityBuy(
                                bookType: bookModel!.bookTypes!,
                              ),
                              InformationBook(
                                bookModel: bookModel!,
                                // reviewModel: _reviewModel!,
                              ),
                            ],
                          ),
                        ),
                        RelatedBookWidget(
                          listRelateBook: listRelatedBook,
                          author: bookModel!.sellerFullname!,
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<PreviewAudioBloc, PreviewAudioState>(
                  builder: (context1, state1) {
                    if (state1.status == AudioStatus.success) {
                      _isListening = true;
                    } else if (state1.status == AudioStatus.end) {
                      _isListening = false;
                    }
                    return _isListening
                        ? const MiniAudioBook()
                        : const BottomBar(
                            type: 0,
                          );
                  },
                ),
              ],
            );
          } else if (state.status == PostStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.orangePrimaryColor,
              ),
            );
          } else {
            return const Expanded(
              child: Center(
                child: Text('Error'),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _appBar() {
    return Container(
      height: 96,
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          InkWell(
              onTap: () => Navigator.maybePop(context),
              // onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(Images.ic_arrow_left,
                    width: 20, height: 20),
              )),
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                StringConst.booksDetail,
                style: AppTextStyles.titleDetailBook,
              )
            ],
          ),
        ],
      ),
    );
  }
}
