import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/home_product_controller.dart';
import 'package:whitematrix_groupa_shopping_app/models/home_dummy_db.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/font_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/image_constants.dart';
import 'package:whitematrix_groupa_shopping_app/views/category/category_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/product_details/product_detail_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/testing_parameterPassing/parameter_test.dart';

///
///
///-----------------------Icon Tab
///
///
class NestedButtonTabs extends StatelessWidget {
  final IconData icon;
  final String label;
  const NestedButtonTabs({
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16), // Replace with your preferred icon
            SizedBox(width: 6),
            Text(label),
          ],
        ),
      ),
    );
  }
}

///
///
///---------------------------Extracted PhotoFrame Type Row
///
///
class PhotoTypeRow extends StatelessWidget {
  final List bslist;
  const PhotoTypeRow({
    required this.bslist,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollingRowV2(
      itemCount: bslist.length,
      backgroundColor: Colors.white,
      itemBuilder: (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center align texts
          children: [
            Text(
              bslist[index]["type"] ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: FontConstants.ititle,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 210,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Image.network(
                  bslist[index]["image"] ?? ImageConstants.fallbackImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      ImageConstants.fallbackImage,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Best Seller",
              style: const TextStyle(
                  color: Colors.red,
                  //fontWeight: FontWeight.bold,
                  fontSize: FontConstants.isubtitle),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
      onTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage2(
              productId: bslist[index]["id"],
            ),
          ),
        );
      },
    );
  }
}

///
///
///
///
///

///
///
///-----------------------Row With border Container
///
///

class RowWithBorderContainerType1 extends StatelessWidget {
  final List dBList;

  const RowWithBorderContainerType1({
    required this.dBList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollingRow(
      itemCount: dBList.length,
      itemBuilder: (index) {
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 200,
                width: 180,
                color: Colors.grey.shade200, // Optional: placeholder background
                child: Stack(
                  children: [
                    Image.network(
                      dBList[index]["image"] ?? ImageConstants.fallbackImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          ImageConstants.fallbackImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      },
                    ),

                    /// Overlay
                    Positioned(
                      bottom: 1,
                      left: 1,
                      right: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              dBList[index]["title"] ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontConstants.ititle,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              dBList[index]["subt"] ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: FontConstants.isubtitle,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 6),

            /// Brand name below image
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                dBList[index]["brand"] ?? "Custom",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
      onTap: (index) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsPage2(
                      productId: dBList[index]["id"],
                    )));
      },
    );
  }
}

// class RowWithBorderContainerType1 extends StatelessWidget {
//   final List dBList;
//   const RowWithBorderContainerType1({
//     required this.dBList,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ScrollingRow(
//       itemCount: dBList.length,
//       itemBuilder: (index) {
//         return Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               height: 200,
//               width: 180,
//               clipBehavior: Clip.antiAlias,
//               child: Stack(
//                 children: [
//                   Image(
//                     image: NetworkImage(
//                       dBList[index]["image"]!,
//                     ),
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                   Positioned(
//                       bottom: 2,
//                       left: 0,
//                       right: 0,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             dBList[index]["title"]!,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             dBList[index]["subt"]!,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 10,
//                               color: Colors.white,
//                             ),
//                           )
//                         ],
//                       ))
//                 ],
//               ),
//             ),
//             Text(
//               dBList[index]["brand"]!,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 30,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         );
//       },
//       // onTap: (index) {
//       //   Navigator.push(context,
//       //       MaterialPageRoute(builder: (context) => ProductDetailsPage2()));
//       // },
//     );
//   }
// }

///
///
///----------------------Carousel Sliders
///
///
class CarouselSliders extends StatefulWidget {
  final List<String> imageUrls;
  final List<String?>? productIds; // Optional list of product IDs
  const CarouselSliders({
    super.key,
    required this.imageUrls,
    this.productIds,
  });

  @override
  State<CarouselSliders> createState() => _CarouselSlidersState();
}

class _CarouselSlidersState extends State<CarouselSliders> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final id = widget.productIds != null &&
                _currentIndex < widget.productIds!.length
            ? widget.productIds![_currentIndex]
            : null;

        if (id != null && id.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage2(productId: id),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryScreen(),
            ),
          );
        }
      },
      child: Column(
        children: [
          SizedBox(height: 10),
          CarouselSlider(
            items: widget.imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(url,
                        fit: BoxFit.cover, width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        ImageConstants.bannerImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    }),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              autoPlayAnimationDuration: Duration(seconds: 3),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: 20),

          /// Carousel Progress Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.black : Colors.grey,
                ),
              );
            }),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

///
///
///------------------------Row for continuing Category
///
///
// your existing ScrollingRow widget

class ContinuingRow extends StatelessWidget {
  const ContinuingRow({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = context.watch<HomeProductController>().featuredBrandsList;

    if (featured.isEmpty) return const SizedBox();

    return ScrollingRow(
      itemCount: featured.length,
      itemBuilder: (index) {
        final item = featured[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.45,
                color: Colors.grey.shade200, // optional placeholder color
                child: Image.network(
                  item["image"] ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      ImageConstants.fallbackImage,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Text(
              item["title"] ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: FontConstants.ititle,
                color: Colors.black,
              ),
            ),
            Text(
              item["subt"] ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: FontConstants.isubtitle,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
      // onTap: (index) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ProductDetailsPage2(
      //               productId:
      //                   featured[index]["id"] ?? "685cf800728c88a1bc918219",
      //             )),
      //   );
      // },
      onTap: (index) {
        final productId = featured[index]["id"] ?? "685cf800728c88a1bc918219";

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsPage2(productId: productId)),
        );
      },
    );
  }
}

///
///
///----------Extracted Scrolling rows
///
///

class ScrollingRow extends StatelessWidget {
  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final void Function(int index)? onTap;

  const ScrollingRow({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(itemCount, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: onTap != null
                  ? () => onTap!(index)
                  : null, //ontap seperation if necessary
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: itemBuilder(index),
              ),
            ),
          );
        }),
      ),
    );
  }
}

///
///
///----------Extracted Scrolling rows without border
///
///

class ScrollingRowV2 extends StatelessWidget {
  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final void Function(int index)? onTap;
  final Color? backgroundColor;

  const ScrollingRowV2({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(itemCount, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: onTap != null ? () => onTap!(index) : null,
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: itemBuilder(index),
              ),
            ),
          );
        }),
      ),
    );
  }
}

///
///
///---------- Title Row Widget---------
///
///
class TitleRow extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color? color;
  final MainAxisAlignment mainAxisAlignment;
  const TitleRow({
    required this.title,
    required this.fontSize,
    required this.mainAxisAlignment,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Expanded(
          child: Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: color ?? Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
