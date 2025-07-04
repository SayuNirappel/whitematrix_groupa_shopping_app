import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/get_all_products_controller.dart';
import 'package:whitematrix_groupa_shopping_app/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/color_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/image_constants.dart';
import 'package:whitematrix_groupa_shopping_app/views/category/product_listing_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/shoppingbag.dart';

class CategoryScreen extends StatefulWidget {
  final String? token;
  final String? id;

  CategoryScreen({super.key, this.token, this.id});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedIndex = 1;

// Function to update the selected index
  isSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Color> colorList = [
    ColorConstants.secondaryColor,
    ColorConstants.blueColor,
  ];

  final List<String> categories = [
    "Trending Now",
    "Men's Wear",
    "Women's Wear",
    "Kids Wear",
    "Footwear",
    "Beauty & Grooming",
    "Home & Living",
    "Accessories",
    "Gadgets",
    "Jewellery",
  ];

  @override
  void initState() {
    print("📌 Token received in CategoryScreen: ${ApiConstants.token}");

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<GetAllProductsController>()
          .fetchAllProducts(token: widget.token);
      // context
      //     .read<GetAllProductsController>()
      //     .fetchAllProducts(token: ApiConstants.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _build_AppbarSection(),
        backgroundColor: ColorConstants.backgroundColor,
        body: Consumer<GetAllProductsController>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: ColorConstants.primaryColor,
              ));
            }

            if (value.isError) {
              return Center(
                child: Text(
                    "Error: ${value.errorMessage ?? 'Something went wrong'}"),
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  color: ColorConstants.backgroundColor,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return _buildSideTab(index);
                    },
                  ),
                ),
                _build_body_Categorysection(selectedIndex),
              ],
            );
          },
        ));
  }

  AppBar _build_AppbarSection() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: ColorConstants.textColor),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'Categories',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border_outlined,
              color: ColorConstants.textColor),
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => Shoppingbag2(
            //             userIdddd: ApiConstants.userID.toString(),
            //             BearerToken: ApiConstants.token.toString())));
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined,
              color: ColorConstants.textColor),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Shoppingbag2(
                        userIdddd: ApiConstants.userID.toString(),
                        BearerToken: ApiConstants.token.toString())));
          },
        ),
      ],
    );
  }

  Widget _build_body_Categorysection(int index) {
    List<String> itemsNameList = [
      'Shirt',
      'Tshirt',
      'Jeans',
      'Trousers',
      'Shorts',
      'pants'
    ];

    List imageSectionList = [
      DummyDb.itemsList,
      DummyDb.itemsList,
      DummyDb.itemsList,
      DummyDb.itemsList,
      DummyDb.footwearItems,
      DummyDb.groomingItems,
      DummyDb.homeItems,
      DummyDb.accessoryItems,
      DummyDb.gadgetItems,
      DummyDb.jewelleryItems,
    ];

    List sectionList = [
      DummyDb.trendingList,
      DummyDb.mensList,
      DummyDb.womensList,
      DummyDb.kidsList,
      DummyDb.footwearList,
      DummyDb.groomingList,
      DummyDb.homeList,
      DummyDb.accessoriesList,
      DummyDb.gadgetsList,
      DummyDb.jewelleryList,
    ];

    List<String> selectedList = sectionList[index];

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            if (index != 0)
              Container(
                height: 60,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: ColorConstants.boxColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConstants.greyColor,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: colorList,
                        ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                      },
                      child: Text(
                        "${categories[index]} \nStore",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: ColorConstants.backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: ColorConstants.darkGreyColor,
                        size: 8,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  1,
                  (sectionIndex) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            selectedList[sectionIndex],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.textColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Consumer<GetAllProductsController>(
  builder: (context, controller, child) {
    if (controller.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: ColorConstants.brownText,
        ),
      );
    }

    if (controller.isError) {
      return Center(
        child: Text(controller.errorMessage ?? 'Error loading products'),
      );
    }

    if (controller.isEmpty) {
      return Center(
        child: Text('No products available'),
      );
    }

    final categories = controller.uniqueCategories;

    String getFullImageUrl(String? relativePath) {
      const serverUrl = "https://myntacloneappbackend-1.onrender.com/";
      if (relativePath == null || relativePath.isEmpty) {
        return ImageConstants.fallbackImage;
      }
      return relativePath.startsWith("http")
          ? relativePath
          : "$serverUrl$relativePath";
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        final imageUrl = getFullImageUrl(category.image);

        return SizedBox(
          height: 150,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductListingScreen(title: category.name),
                    ),
                  );
                },
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        ImageConstants.dummyImage,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 80,
                        height: 80,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  },
)

                        ],
                      )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideTab(int index) {
    bool isSelectedTab = selectedIndex == index;
    bool isAboveSelected = index == selectedIndex - 1;
    bool isBelowSelected = index == selectedIndex + 1;

    final image = context.watch<Dummydb>().products[index];

    return Row(
      children: [
        Container(
          width: 10,
          height: isSelectedTab ? 50 : 100,
          decoration: BoxDecoration(
            color: isSelectedTab
                ? ColorConstants.primaryColor
                : Colors.grey.shade200,
            borderRadius: isSelectedTab
                ? BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30))
                : BorderRadius.all(Radius.circular(0)),
          ),
        ),
        GestureDetector(
          onTap: () => isSelected(index),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: isSelectedTab
                  ? ColorConstants.backgroundColor
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(isAboveSelected ? 30 : 0),
                topRight: Radius.circular(isBelowSelected ? 30 : 0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: kIsWeb
                                ? AssetImage(image["image"]) as ImageProvider
                                : NetworkImage(DummyDb.sideTabSection[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: isSelectedTab
                                  ? const Color.fromARGB(52, 240, 63, 122)
                                  : const Color.fromARGB(0, 238, 238, 238),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ],
                  ),
                ),
                Text(
                  categories[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelectedTab
                        ? ColorConstants.primaryColor
                        : Colors.black,
                    fontWeight:
                        isSelectedTab ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
