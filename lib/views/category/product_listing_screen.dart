import 'dart:developer';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:whitematrix_groupa_shopping_app/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/models/category_model.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/color_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/image_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whitematrix_groupa_shopping_app/utils/widgets/horizontal_widget.dart';

class ProductListingScreen extends StatefulWidget {
  final String title;
  ProductListingScreen({super.key, required this.title});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  int selectedIndex = 0; 

  isSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: _build_AppbarSection(),
      body: Column(
        children: [
          Container(
            height: 30,
            width: double.infinity,
            color: const Color.fromARGB(255, 235, 176, 245),
            child: Row(
      children: const [
        Icon(Icons.location_on_outlined, size: 16, color: Colors.black54),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            "C558+4R8, Perumpidikkunnu, Kerala",
            style: TextStyle(fontSize: 12, color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Icon(Icons.expand_more, size: 16, color: Colors.black54),
      ],
    ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(13),
            
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _build_Tab("Shopping", 0),
                _build_Tab("Trends", 1),
              ],
            ),
          ),
          Expanded(
          child: selectedIndex == 0 ? _buildShoppingView() : _buildTrendsView(),
        ),
        ],
      ),
      bottomNavigationBar: _build_BottomSection(),
    );
  }

  Widget _build_BottomSection() {
    return Container(
  height: 50,
  padding: const EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: ColorConstants.backgroundColor,
   
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      TextButton.icon(
        onPressed: () {
          // Open Sort Modal
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 400,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorConstants.backgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("SORT BY", style: TextStyle(fontWeight: FontWeight.bold, color: ColorConstants.greyColor, fontSize: 10)),
                    
                    Divider(color: ColorConstants.greyColor, thickness: 1),
                

                    ListTile(
                      title: Text("What's new", style: TextStyle(color: ColorConstants.darkGreyColor, fontSize: 12)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  
                    ListTile(
                      title: Text("Price - high to low", style: TextStyle(color: ColorConstants.darkGreyColor, fontSize: 12)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                 
                    ListTile(
                      title: Text("Popularity", style: TextStyle(color: ColorConstants.darkGreyColor, fontSize: 12)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                   
                    ListTile(
                      title: Text("Discount", style: TextStyle(color: ColorConstants.darkGreyColor, fontSize: 12)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    
                    ListTile(
                      title: Text("Price - low to high", style: TextStyle(color: ColorConstants.darkGreyColor, fontSize: 12)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("Customer Rating", style: TextStyle(color: ColorConstants.darkGreyColor, fontSize: 12)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.swap_vert_outlined, color: ColorConstants.darkGreyColor),
        label: const Text("Sort", style: TextStyle(color: ColorConstants.textColor)),
      ),
     Text("|", style: TextStyle(color: ColorConstants.darkGreyColor, fontSize: 20)),
      TextButton.icon(
        onPressed: () {
          // Open Filter Modal
        },
        icon: Icon(Icons.filter_alt, color: ColorConstants.darkGreyColor),
        label: const Text("Filter", style: TextStyle(color: ColorConstants.textColor)),
      ),
    ],
  ),
);
  }

  Widget _buildTrendsView() {
  final List<Category> categories = DummyDb().dummyCategories;

  // Moved out of builder
  List<String> imageList = [];
  List<String> nameList = [];

  switch (widget.title.toLowerCase()) {
    case "tshirt":
      imageList = DummyDb.tshirtList;
      nameList = DummyDb.tshirtTypes;
      break;
    case "shirt":
      imageList = DummyDb.shirtList;
      nameList = DummyDb.shirtTypes;
      break;
    case "trousers":
      imageList = DummyDb.trousersList;
      nameList = DummyDb.trousersTypes;
      break;
    case "shorts":
      imageList = DummyDb.shortsList;
      nameList = DummyDb.shortsTypes;
      break;
    case "pants":
      imageList = DummyDb.pantsList;
      nameList = DummyDb.pantsTypes;
      break;
    case "jeans":
      imageList = DummyDb.jeansList;
      nameList = DummyDb.jeansTypes;
      break;
  }

  List<Color> colorList = [
    ColorConstants.lightPinkColor,
    const Color.fromARGB(255, 238, 134, 168),
    const Color.fromARGB(255, 165, 236, 229),
    const Color.fromARGB(255, 251, 196, 196),
    ColorConstants.greyColor,
  ];

   return ListView.builder(
    itemCount: categories.length,
    padding: const EdgeInsets.all(12),
    itemBuilder: (context, index) {
      final category = categories[index];

      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorList[index % colorList.length],
              ColorConstants.backgroundColor,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ) ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        
            const SizedBox(height: 10),
        
            Container(
              height: 235,
              child: Row(
                children: [
                  _build_BigSection(imageList, index, nameList),
                  const SizedBox(width: 10),
                  _build_SmallSection(category, imageList, index),
                ],
              ),
            ),
        
            const SizedBox(height: 10),
            
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: ColorConstants.lightGreyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                   "VIEW PRODUCTS >",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: ColorConstants.textColor),
                ),
              ),
            ),
        
          ],
        ),
      );
    },
  );
}

  Expanded _build_SmallSection(Category category, List<String> imageList, int index) {
    return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(.8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, i) {
                      final product = category.products[i % category.products.length];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(imageList[(index + i) % imageList.length]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
          
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Row(  
                                         children: [
                                              Text(
                                               "₹${product.price}",
                                                   style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,
                                                                    color: ColorConstants.backgroundColor,
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 4),
                                                                Text(
                                                                  "₹${product.originalPrice}",
                                                                  style: const TextStyle(
                                                                    fontSize: 10,
                                                                    color: ColorConstants.darkGreyColor,
                                                                    decoration: TextDecoration.lineThrough,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                         
                        ],
                      );
                    },
                  ),
                );
  }

  Container _build_BigSection(List<String> imageList, int index, List<String> nameList) {
    return Container(
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(imageList[index % imageList.length]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(imageList[index % imageList.length]),
                            ),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nameList[index % nameList.length],
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                const Text(
                                  "5K followers",
                                  style: TextStyle(color: Colors.white70, fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(Icons.tv)
                        ),
                      ),
                    ],
                  ),
                );
  }


Widget _buildCategorySection(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      SizedBox(
        height: 220,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image:  AssetImage(ImageConstants.WomenSection), 
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      )
    ],
  );
}



  Widget _buildShoppingView() {

      List<String> imageList = [];
      List<String> nameList = [];

  switch (widget.title.toLowerCase()) {
    case "tshirt":
      imageList = DummyDb.tshirtList;
      nameList = DummyDb.tshirtTypes;
      break;
    case "shirt":
      imageList = DummyDb.shirtList;
      nameList = DummyDb.shirtTypes;
      break;
    case "trousers":
      imageList = DummyDb.trousersList;
      nameList = DummyDb.trousersTypes;
      break;
    case "shorts":
      imageList = DummyDb.shortsList;
      nameList = DummyDb.shortsTypes;
      break;
    case "pants":
      imageList = DummyDb.pantsList;
      nameList = DummyDb.pantsTypes;
      break;
    case "jeans":
      imageList = DummyDb.jeansList;
      nameList = DummyDb.jeansTypes;
      break;
    default:
      imageList = [];
      nameList = [];
  }
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _build_Brands(" Top Brands",  Icons.local_offer_outlined),
                SizedBox(width: 10),
                _build_Brands(" Top Rated", Icons.star_border_outlined),
                SizedBox(width: 10),
                _build_Brands(" Hot Trends", Icons.whatshot, ColorConstants.primaryColor),
                SizedBox(width: 10),
                _build_Brands(" Myntra Unique", null),
                SizedBox(width: 10),
                _build_Brands(" Global Brands", Icons.public_outlined),
                SizedBox(width: 10),
                _build_Brands(" Rising Star", Icons.trending_up, ColorConstants.secondaryColor),                
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 110,
          child: ListView.separated(
            itemCount: nameList.length,
            itemBuilder: (context, index) { 
         return Column(
          children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    //  color: Colors.yellow,
                      image: DecorationImage(
                        image: NetworkImage(imageList[index % imageList.length]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    nameList[index % nameList.length],
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorConstants.textColor),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
          
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 69,
            decoration: BoxDecoration(
              color: ColorConstants.lightPinkColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [          
                                   _build_PromoColumn("FREE", "Shipping"),
                                    _buildDivider(),
                                    _build_PromoColumn("40% off", "upto ₹300"),
                                    _buildDivider(),
                                    _build_PromoColumn("EASY", "Returns"),
                  
                
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: 20 / 9,
            autoPlayInterval: const Duration(seconds: 3),
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: DummyDb.imageUrls.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: DummyDb.imageUrls.length,
            effect: ScrollingDotsEffect(
              activeDotColor: ColorConstants.textColor,
              dotColor: Colors.grey,
              dotHeight: 5,
              dotWidth: 5,
            ),
            onDotClicked: (index) {
              _controller.animateToPage(index);
            },
          ),
        ),    
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: DummyDb().dummySproducts.length,
          itemBuilder: (context, index) {
            final product = DummyDb().dummySproducts[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageList[index % imageList.length]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(31, 0, 0, 0),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text("AD", style: TextStyle(color: ColorConstants.backgroundColor, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            height: 20,
                            width: 90,
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                              
                                Text(product.rating.toString(), style: TextStyle(color:  ColorConstants.textColor, fontWeight: FontWeight.bold,fontSize: 10)),
                                  Icon(Icons.star, color: ColorConstants.secondaryColor, size: 10),
                                  SizedBox(width: 8,),
                                 Text("|", style: TextStyle(color: ColorConstants.greyColor, fontSize: 12)),
                                  SizedBox(width: 8,),
                                  Text(product.reviews.toString(), style: TextStyle(color: ColorConstants.textColor, fontSize: 10)),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.brand,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Icon(Icons.favorite_border_outlined, color: ColorConstants.textColor, size: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.title,
                style: const TextStyle(fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                children: [
                   Text(
                    "₹${(product.originalPrice).toStringAsFixed(0)}",
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "₹${product.discountedPrice}",
                    style: const TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: ColorConstants.textColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                 
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                     // borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "₹${(product.originalPrice - product.discountedPrice).toStringAsFixed(0)} OFF!",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.isExpress ? "Express by ${product.deliveryDate}" : "Delivery by ${product.deliveryDate}",
                style: TextStyle(
                  fontSize: 10,
                  color: product.isExpress ? Colors.green : Colors.black54,
                ),
              ),
            ),
                ]
              )
              );
          },
        )
      ],
    ),
  );
}



  Widget _build_PromoColumn(String title, String subtitle) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(title, style: const TextStyle(color: ColorConstants.brownText, fontWeight: FontWeight.bold, fontSize: 20)),
      Text(subtitle, style: const TextStyle(color: ColorConstants.textColor, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _buildDivider() {
  return Text("|", style: const TextStyle(color: ColorConstants.brownText, fontSize: 30));
}
  Widget _build_Brands(String title, IconData? icon, [Color? color]) {
    return Container(
            width: 120,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              color: ColorConstants.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color ?? ColorConstants.textColor),
                Text(title, style: TextStyle(color:  ColorConstants.textColor, fontWeight: FontWeight.bold,fontSize: 12)),
              ],
            ), );
  }
  Widget _build_Tab(String label, int index) {
     bool isSelectedTab = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => isSelected(index),
        child: Container(
                    width: 100,
                    height:  30,
                    decoration: BoxDecoration(
                     color: isSelectedTab ? ColorConstants.textColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),               
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isSelectedTab ? Colors.white : ColorConstants.textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),  
                  ),
      ),
      )
    );
  }
  AppBar _build_AppbarSection() {
    return AppBar(
      centerTitle: true,
    leadingWidth: 120, 
    leading: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConstants.textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SvgPicture.asset(
          ImageConstants.logo, 
          height: 40,
          width: 40,
        ),
      ],
    ),
    title: Text(
      widget.title.toUpperCase(),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
    ),
    backgroundColor: ColorConstants.backgroundColor,
    actions: [
      IconButton(
        icon: const Icon(Icons.search_outlined, color: ColorConstants.textColor),
        onPressed: () {
          
        },
      ),
      IconButton(
        icon: const Icon(Icons.favorite_border_outlined, color: ColorConstants.textColor),
        onPressed: () {
          
        },
      ),
      IconButton(
        icon: const Icon(Icons.shopping_bag_outlined, color: ColorConstants.textColor),
        onPressed: () {
        
        },
      ),
    ],
  
  );
  
  }
}