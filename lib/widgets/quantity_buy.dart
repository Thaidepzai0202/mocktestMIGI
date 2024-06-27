import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktest/bloc/preview_audio/preview_audio_bloc.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/bloc/readbook/readbook_bloc.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/screens/preview_read_screen.dart';
import 'package:mocktest/services/logger.dart';
import 'package:mocktest/widgets/book_button.dart';

class QuantityBuy extends StatefulWidget {
  final String bookType;
  const QuantityBuy({super.key, required this.bookType});

  @override
  State<QuantityBuy> createState() => _QuantityBuyState();
}

class _QuantityBuyState extends State<QuantityBuy> {
  int _quanttity = 1;
  int _curentHardbookQuantity = 1;
  late bool isHardBook;
  late bool isEbook;
  late bool isAudioBook;
  late int _typeSlect;

  @override
  void initState() {
    isHardBook = widget.bookType.contains('0') ? true : false;
    isEbook = widget.bookType.contains('1') ? true : false;
    isAudioBook = widget.bookType.contains('2') ? true : false;
    isHardBook
        ? _typeSlect = 0
        : isEbook
            ? _typeSlect = 1
            : _typeSlect = 2;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [quantity(), bookType(), listenOrRead()],
    );
  }

  Widget quantity() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 80,
            child: Text(
              'Số lượng',
              style: AppTextStyles.text14Hint2,
            ),
          ),
          Container(
            height: 32,
            width: _typeSlect == 0 ? 95 : 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border:
                  Border.all(width: 1, color: AppColors.borderButtomUnSelect),
            ),
            child: Row(
              children: [
                if (_typeSlect == 0)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _quanttity > 1 ? _quanttity-- : null;
                          _curentHardbookQuantity = _quanttity;
                        });
                      },
                      child: Icon(
                        Icons.remove,
                        color: _quanttity == 1
                            ? AppColors.borderButtomUnSelect
                            : null,
                      ),
                    ),
                  ),
                Expanded(
                    child: Center(
                        child: Text(
                  '$_quanttity',
                  style: AppTextStyles.text14Primary,
                ))),
                if (_typeSlect == 0)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _quanttity++;
                          _curentHardbookQuantity = _quanttity;
                        });
                      },
                      child: const Icon(Icons.add),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bookType() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          if (isHardBook)
            HardBookButton(
                isSelect: _typeSlect == 0,
                onTap: () {
                  setState(() {
                    _typeSlect = 0;
                    _quanttity = _curentHardbookQuantity;
                  });
                  BlocProvider.of<BookDetailBloc>(context)
                      .add(SelectTypeEvent(type: _typeSlect));
                }),
          if (isEbook)
            EBookButton(
                isSelect: _typeSlect == 1,
                onTap: () {
                  setState(() {
                    _typeSlect = 1;
                    _quanttity = 1;
                  });
                  BlocProvider.of<BookDetailBloc>(context)
                      .add(SelectTypeEvent(type: _typeSlect));
                }),
          if (isAudioBook)
            AudioBookButton(
                isSelect: _typeSlect == 2,
                onTap: () {
                  setState(() {
                    _typeSlect = 2;
                    _quanttity = 1;
                  });
                  BlocProvider.of<BookDetailBloc>(context)
                      .add(SelectTypeEvent(type: _typeSlect));
                })
        ],
      ),
    );
  }

  Widget listenOrRead() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      height: isEbook || isAudioBook ? 56 : 0,
      // height: 56,
      child: Row(
        children: [
          if (_typeSlect != 2 && isEbook)
            Expanded(
              child: ReadBookButton(
                onTap: () {
                  // BlocProvider.of<BookDetailBloc>(context).add(ReadBookEvent());
                  logger.log("id${BlocProvider.of<BookDetailBloc>(context)
                                        .bookModel!
                                        .id!}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => ReadbookBloc()
                            ..add(InitReadEvent(
                                bookId:
                                    BlocProvider.of<BookDetailBloc>(context)
                                        .bookModel!
                                        .id!,
                                bookType: 1)),
                          child: const PreviewRead(),
                        ),
                      ));
                },
                path: Images.ic_read_book,
                title: StringConst.readBook,
              ),
            ),
          if (_typeSlect == 0 && isEbook && isAudioBook)
            const SizedBox(
              width: 10,
            ),
          if (_typeSlect != 1 && isAudioBook)
            Expanded(
              child: ReadBookButton(
                onTap: () {
                  BlocProvider.of<PreviewAudioBloc>(context).add(
                      InitListenEvent(
                          bookId: BlocProvider.of<BookDetailBloc>(context)
                              .bookModel!
                              .id!,
                          bookType: 2));
                },
                path: Images.ic_listen_book,
                title: StringConst.listenBook,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
