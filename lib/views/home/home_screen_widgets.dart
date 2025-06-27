import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/product_provider.dart';
import 'package:whitematrix_groupa_shopping_app/models/home_dummy_db.dart';
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
          children: [
            Text(
              bslist[index]["type"]!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
              height: 210,
              width: 150,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(
                      bslist[index]["image"]!,
                    ),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Positioned(
                      bottom: 2,
                      left: 1,
                      right: 1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          bslist[index]["offer"]!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            TempAdBanner(
                borderColor: Colors.white,
                containerColor: Colors.white,
                textrColor: Colors.black,
                height: 20,
                fSize: 10)
          ],
        );
      },
      // onTap: (index) {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => ProductDetailsPage2()));
      // },
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 200,
              width: 180,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(
                      dBList[index]["image"]!,
                    ),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                      bottom: 2,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dBList[index]["title"]!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            dBList[index]["subt"]!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            Text(
              dBList[index]["brand"]!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
      // onTap: (index) {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => ProductDetailsPage2()));
      // },
    );
  }
}

///
///
///----------------------Carousel Sliders
///
///
class CarouselSliders extends StatefulWidget {
  final List<String> imageUrls;

  const CarouselSliders({super.key, required this.imageUrls});

  @override
  State<CarouselSliders> createState() => _CarouselSlidersState();
}

class _CarouselSlidersState extends State<CarouselSliders> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => ProductDetailsPage2()));
      // },
      child: Column(
        children: [
          SizedBox(height: 10),
          CarouselSlider(
            items: widget.imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 100,
                        child: Container(
                          color: Colors.black45,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            "Min. 55% OFF",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
    final featured = context.watch<ProductProvider>().featuredBrandsList;

    if (featured.isEmpty) return const SizedBox();

    return ScrollingRow(
      itemCount: 2,
      itemBuilder: (index) {
        final item = featured[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width * 0.45,
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                item["image"] ?? "",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported);
                },
              ),
            ),
            Text(
              item["title"] ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Text(
              item["subt"] ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
<<<<<<< HEAD
      // onTap: (index) {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => ProductDetailsPage2()));
      // },
=======
      onTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductDetailsPage2()),
        );
      },
>>>>>>> auth_with_token
    );
  }
}

///
///
///---------Extracted Ad Container
///
///
class TempAdBanner extends StatelessWidget {
  final Color borderColor;
  final Color containerColor;
  final Color textrColor;
  final double height;
  final double fSize;
  const TempAdBanner({
    required this.borderColor,
    required this.containerColor,
    required this.textrColor,
    required this.height,
    required this.fSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor)),
      child: Center(
        child: Text(
          "Loading Ad........",
          style: TextStyle(
              color: textrColor, fontWeight: FontWeight.bold, fontSize: fSize),
        ),
      ),
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