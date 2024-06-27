import 'package:flutter/material.dart';
import 'package:mocktest/constants/api_path.dart';
import 'package:mocktest/constants/app_colors.dart';

// class ShowImagesBook extends StatefulWidget {
//   final List<String> listPath;
//   const ShowImagesBook({super.key, required this.listPath});

//   @override
//   State<ShowImagesBook> createState() => _ShowImagesBookState();
// }

// class _ShowImagesBookState extends State<ShowImagesBook> {
//   int _numSelect = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 276,
//       child: Column(
//         children: [
//           GestureDetector(
//             onHorizontalDragEnd: (details) {
//               setState(() {
//                 if (details.primaryVelocity! < 0) {
//                   _numSelect < widget.listPath.length - 1 ? _numSelect++ : null;
//                 } else {
//                   _numSelect > 0 ? _numSelect-- : null;
//                 }
//               });
//             },
//             child: SizedBox(
//               height: 200,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(6),
//                 child: Image.network(
//                     'https://cdn-migi-2.laosedu.la/f${widget.listPath[_numSelect]}',
//                     fit: BoxFit.fill),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             height: 60,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.listPath.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () => setState(() {
//                     _numSelect = index;
//                   }),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 6),
//                     child: Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               width: _numSelect == index ? 2 : 0,
//                               color: _numSelect == index
//                                   ? AppColors.orangePrimaryColor
//                                   : AppColors.white),
//                           borderRadius: BorderRadius.circular(6)),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(4),
//                         child: Image.network(
//                           'https://cdn-migi-2.laosedu.la/f${widget.listPath[index]}',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class ShowImagesBook2 extends StatefulWidget {
  final List<String> listPath;
  const ShowImagesBook2({super.key, required this.listPath});

  @override
  State<ShowImagesBook2> createState() => _ShowImagesBook2State();
}

class _ShowImagesBook2State extends State<ShowImagesBook2> {
  int _numSelect = 0;
  final PageController _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 276,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) => setState(() {
                _numSelect = value;
              }),
              itemCount: widget.listPath.length,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                    '${ApiPath.getDetailImage}${widget.listPath[index]}',
                    fit: BoxFit.fitHeight),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.listPath.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => setState(() {
                    _numSelect = index;
                    _pageController.jumpToPage(index);  
                  }),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: _numSelect == index ? 2 : 0,
                              color: _numSelect == index
                                  ? AppColors.orangePrimaryColor
                                  : AppColors.white),
                          borderRadius: BorderRadius.circular(6)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          'https://cdn-migi-2.laosedu.la/f${widget.listPath[index]}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
