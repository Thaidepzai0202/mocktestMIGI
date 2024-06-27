import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/bloc/readbook/readbook_bloc.dart';
import 'package:mocktest/constants/app_colors.dart';
import 'package:mocktest/constants/app_text_style.dart';
import 'package:mocktest/constants/image.dart';
import 'package:mocktest/constants/string_const.dart';
import 'package:mocktest/models/preview_book_model.dart';
import 'package:mocktest/services/logger.dart';
import 'package:mocktest/widgets/must_buy_dilog.dart';

class PreviewRead extends StatefulWidget {
  const PreviewRead({super.key});

  @override
  State<PreviewRead> createState() => _PreviewReadState();
}

class _PreviewReadState extends State<PreviewRead> {
  PreviewBookModel? previewBookModel;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int currentPage = 0;
  int totalPage = 2;
  bool isShowItem = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context1) {
    return BlocListener<ReadbookBloc, ReadbookState>(
      listener: (context, state) {
        if (state.status == PostStatus.mustBuy) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => MustBuyBook(
                price: BlocProvider.of<BookDetailBloc>(context)
                    .bookModel!
                    .ebook!
                    .price!
                    .toString(),
                type: 1),
          );
        }
      },
      child: BlocBuilder<ReadbookBloc, ReadbookState>(
        builder: (context, state) {
          if (state.status == PostStatus.success) {
            previewBookModel = state.previewBookModel;
            return Scaffold(
                appBar: isShowItem
                    ? AppBar(
                        scrolledUnderElevation: 0.0,
                        backgroundColor: AppColors.white,
                        leading: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: SvgPicture.asset(Images.ic_arrow_left,
                                  width: 20, height: 20),
                            )),
                        title: Text(
                          state.previewBookModel!.booksDetailsDto!.name!,
                          // 'aaa',
                          style: AppTextStyles.titleDetailBook,
                        ),
                        actions: [
                          InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {
                              showMenu(context1);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                // shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(14),
                              child:
                                  SvgPicture.asset(Images.ic_table_of_contents),
                            ),
                          )
                        ],
                      )
                    : AppBar(
                        leading: const SizedBox(),
                      ),
                body: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: PDFView(
                          filePath: state.remotePDFpath,
                          fitPolicy: FitPolicy.BOTH,
                          swipeHorizontal: true,
                          pageSnap: true,
                          // ignore: prefer_collection_literals
                          gestureRecognizers: Set()
                            ..add(Factory<TapGestureRecognizer>(
                                () => TapGestureRecognizer()
                                  ..onTapDown = (tap) {
                                    isShowItem = !isShowItem;
                                    setState(() {});
                                    logger.log("Tap Down Gesture Detecccted");
                                  })),
                          onViewCreated:
                              (PDFViewController pdfViewController) async {
                            _controller.complete(pdfViewController);
                          },
                          onPageChanged: (page, total) {
                            currentPage = page!;
                            totalPage = total!;
                            logger.log('page change: $page/$total');
                            setState(() {});  
                          }),
                    ),
                    //Back lại trang 1
                    // isShowItem
                        // ?
                         Positioned(
                            bottom: 16,
                            left: (MediaQuery.of(context).size.width - 142) / 2,
                            right:
                                (MediaQuery.of(context).size.width - 142) / 2,
                            child: AnimatedOpacity(
                              opacity: isShowItem ? 1.0 : 0.0,
                              duration: const Duration(seconds: 1),
                              child: FutureBuilder<PDFViewController>(
                                future: _controller.future,
                                builder: (context,
                                    AsyncSnapshot<PDFViewController> snapshot) {
                                  if (snapshot.hasData) {
                                    return InkWell(
                                      onTap: () async {
                                        isShowItem ? await snapshot.data!.setPage(0)
                                        :setState(() {
                                          isShowItem=!isShowItem;
                                        });;
                                      },
                                      child: Container(
                                          height: 40,
                                          width: 142,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors
                                                      .borderButtomUnSelect)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SvgPicture.asset(
                                                Images.ic_arrow_left,
                                                // ignore: deprecated_member_use
                                                color: AppColors.bluePrimaryColor,
                                              ),
                                              const Text("Quay lại trang 1",
                                                  style: AppTextStyles
                                                      .text12W600OBlue),
                                            ],
                                          )),
                                    );
                                  }
                              
                                  return Container();
                                },
                              ),
                            ),
                          ),
                        // : const SizedBox(),
                    (currentPage > 0 && isShowItem)
                        ? Positioned(
                            left: 16,
                            bottom: MediaQuery.of(context).size.width / 2 - 16,
                            top: MediaQuery.of(context).size.width / 2 - 16,
                            child: FutureBuilder<PDFViewController>(
                                future: _controller.future,
                                builder: (context,
                                    AsyncSnapshot<PDFViewController> snapshot) {
                                  if (snapshot.hasData) {
                                    return InkWell(
                                      onTap: () async {
                                        if (currentPage > 0) {
                                          await snapshot.data!
                                              .setPage(--currentPage);
                                          // setState(() {});
                                        }
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color.fromRGBO(
                                                      115, 115, 115, 0.1),
                                                  blurRadius: 7,
                                                  spreadRadius: 2,
                                                  offset: Offset(0, 0.7))
                                            ],
                                            shape: BoxShape.circle,
                                            color: AppColors.white),
                                        child: SvgPicture.asset(
                                            Images.ic_arrow_left_orange),
                                      ),
                                    );
                                  }
                                  return Container();
                                }),
                          )
                        : Positioned(
                            top: 20,
                            bottom: 20,
                            left: 0,
                            child: FutureBuilder<PDFViewController>(
                              future: _controller.future,
                              builder: (context,
                                  AsyncSnapshot<PDFViewController> snapshot) {
                                return InkWell(
                                  onTap: () async {
                                    if (currentPage > 0) {
                                      await snapshot.data!
                                          .setPage(--currentPage);
                                      // setState(() {});
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                  ),
                                );
                              },
                            ),
                          ),
                    (currentPage < totalPage - 1 && isShowItem)
                        ? Positioned(
                            right: 16,
                            bottom:
                                MediaQuery.of(context).size.width / 2 - 16,
                            top: MediaQuery.of(context).size.width / 2 - 16,
                            child: FutureBuilder<PDFViewController>(
                                future: _controller.future,
                                builder: (context,
                                    AsyncSnapshot<PDFViewController>
                                        snapshot) {
                                  return InkWell(
                                    onTap: () async {
                                      if (currentPage < totalPage - 1) {
                                        await snapshot.data!
                                            .setPage(++currentPage);
                                        // setState(() {});
                                      }
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 32,
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    115, 115, 115, 0.1),
                                                blurRadius: 7,
                                                spreadRadius: 2,
                                                offset: Offset(0, 0.7))
                                          ],
                                          shape: BoxShape.circle,
                                          color: AppColors.white),
                                      child: SvgPicture.asset(
                                          Images.ic_arrow_right_orange),
                                    ),
                                  );
                                }),
                          )
                        : Positioned(
                            top: 20,
                            bottom: 20,
                            right: 0,
                            child: FutureBuilder<PDFViewController>(
                              future: _controller.future,
                              builder: (context,
                                  AsyncSnapshot<PDFViewController> snapshot) {
                                return InkWell(
                                  onTap: () async {
                                    if (currentPage < totalPage - 1) {
                                      await snapshot.data!
                                          .setPage(++currentPage);
                                      // setState(() {});
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                  ),
                                );
                              },
                            ),
                          )
                  ],
                ));
          } else if (state.status == PostStatus.initial) {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                color: AppColors.orangePrimaryColor,
              ),
            ));
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          }
        },
      ),
    );
  }

  showMenu(BuildContext context1) {
    final max = MediaQuery.of(context1).size.height / 0.6;
    final int lengthPreview = previewBookModel!.bookContentDto!.length;
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context1,
      builder: (context) {
        return Container(
          height: (100 + lengthPreview * 50) < max
              ? (100 + lengthPreview * 50)
              : max,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    StringConst.list,
                    style: AppTextStyles.text16W600Primary,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                ],
              ),
              const Text(
                StringConst.tableOfContents,
                style: AppTextStyles.text14W600Blue,
              ),
              showTableOfContents(context1)
            ],
          ),
        );
      },
    );
  }

  Widget showTableOfContents(BuildContext context1) {
    int numSelect = 0;
    List<Widget> listItem = [];
    for (var element in previewBookModel!.bookContentDto!) {
      listItem.add(Container(
        decoration: BoxDecoration(
            color: numSelect == 0 ? AppColors.backgroundRalatedBook : null,
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SizedBox(
                width: 300,
                child: Text(
                  "${numSelect != 0 ? numSelect : ' '}${numSelect != 0 ? '. ' : '  '} ${element.bookContentName == '' && numSelect == 0 ? "Nội dung đọc thử" : element.bookContentName}",
                  style: numSelect == 0
                      ? AppTextStyles.text14W500Hint2
                      : AppTextStyles.text14W500Hint,
                ),
              ),
              const Spacer(),
              previewBookModel!.bookContentDto![numSelect].filePath == null
                  ? SvgPicture.asset(Images.ic_lock)
                  : const SizedBox()
            ],
          ),
        ),
      ));
      numSelect++;
    }
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: listItem.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (previewBookModel!.bookContentDto![index].filePath != null) {
              context1.read<ReadbookBloc>().add(SelectReadEvent(
                  filePath:
                      previewBookModel!.bookContentDto![index].filePath!));
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                builder: (context) => MustBuyBook(
                  price: previewBookModel!.booksDetailsDto!.bookPrices!,
                  type: 1,
                ),
              );
            }
          },
          child: listItem[index],
        );
      },
    ));
  }
}
