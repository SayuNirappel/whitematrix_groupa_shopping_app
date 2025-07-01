import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/home_product_controller.dart';
import 'package:whitematrix_groupa_shopping_app/data/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';
import 'package:whitematrix_groupa_shopping_app/models/home_dummy_db.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/home_api/banner_service.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/home_api/product_service.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/color_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/font_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/image_constants.dart';
import 'package:whitematrix_groupa_shopping_app/views/category/category_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/category/product_listing_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/home/home_screen_widgets.dart';
import 'package:whitematrix_groupa_shopping_app/views/notifications/notification_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/product_details/product_detail_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/profile/profile_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/testing_parameterPassing/parameter_test.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Fetch products from provider when screen loads
    Future.microtask(() {
      Provider.of<HomeProductController>(context, listen: false)
          .fetchInitialData();
    });

    loadInitialData(); // load local or cached data
  }

  Future<void> loadInitialData() async {
    // await loadProductsOnce(); // fetch and cache
    // await loadBanners(); // fetch banners and replace DummyDb.carousel1ImgeUrl
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<HomeProductController>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorConstants.homeBG,
        appBar: AppBar(
          backgroundColor: ColorConstants.bnavpink,
          title: _buildSearchBar(),
          actions: _buildAppBarActions(context),
          bottom: _buildTabBar(),
        ),
        body: productProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: ColorConstants.mynthraPink,
              ))
            : TabBarView(
                children: [
                  NestedTabScreenWidget(),
                  NestedTabScreenWidget(),
                  NestedTabScreenWidget(),
                  NestedTabScreenWidget(),
                  // const FilteredTabScreenWidget(gender: "men"),
                  // const FilteredTabScreenWidget(gender: "women"),
                  // const FilteredTabScreenWidget(gender: "unisex"),
                ],
              ),
      ),
    );
  }

  PreferredSize _buildTabBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              isScrollable: false,
              labelColor: ColorConstants.mynthraPink,
              unselectedLabelColor: Colors.black,
              indicatorColor: ColorConstants.mynthraPink,
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Men"),
                Tab(text: "Women"),
                Tab(text: "Kids"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CategoryScreen(
                              token: ApiConstants.token,
                              id: ApiConstants.userID,
                            )));
              },
              child:Container(
                padding: EdgeInsets.all(1),
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: ColorConstants.textColor),
                  borderRadius: BorderRadius.circular(3)
                ),
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: 1), itemBuilder: (context, index) {
                  return Center(
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: ColorConstants.darkGreyColor,
                    ),
                  );

                },
                itemCount: 4,),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   SvgPicture.asset(
                    ImageConstants.logo, 
                    height: 20,
                    width: 25,
                  ),
                  const SizedBox(width: 8),
                  const Text("Search", style: TextStyle(fontSize: 15)),
                ],
              ),
              const Icon(Icons.search),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
      InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NotificationScreen()));
        },
        child: const Icon(Icons.notification_important_outlined),
      ),
      const SizedBox(width: 15),
      const Icon(Icons.favorite_outline),
      const SizedBox(width: 15),
      InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ProfileScreen()));
        },
        child: const Icon(Icons.account_circle_outlined),
      ),
      const SizedBox(width: 15),
    ];
  }
}

///
///
///
///
///

///
///
///
///
///

///
///
///
///
///

class FilteredTabScreenWidget extends StatelessWidget {
  List<ProductsResModel> _sortProductsForTab(
      String title, List<ProductsResModel> products) {
    switch (title) {
      case "Trending":
        return products.where((product) {
          final hasProductDiscount = product.discount?.isActive == true;
          final hasVariantDiscount = product.variants?.any(
                (v) => v.discount?.isActive == true,
              ) ??
              false;
          return hasProductDiscount || hasVariantDiscount;
        }).toList();

      case "New Arrivals":
        return products.where((p) => p.createdAt != null).toList()
          ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      case "Top Rated":
        return products.toList()
          ..sort((a, b) =>
              _totalStock(b.variants) -
              _totalStock(a.variants)); // More stock = popular

      case "On Sale":
        return products.toList()
          ..sort((a, b) =>
              _totalStock(a.variants) -
              _totalStock(b.variants)); // Low stock = selling fast

      default:
        return products;
    }
  }

  final String gender;
  const FilteredTabScreenWidget({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProductController>(
      builder: (context, productProvider, _) {
        final genderedProducts = productProvider.genderProducts;

        return Center(
          child: Column(
            children: [
              Text("Gender: $gender"),
              Text("Filtered List Count: ${genderedProducts.length}"),
              Text("All Products Count: ${productProvider.allProducts.length}"),
            ],
          ),
        );
      },
    );
  }

  int _totalStock(List<Variant>? variants) {
    if (variants == null || variants.isEmpty) return 0;
    return variants.fold(0, (sum, v) => sum + (v.stock ?? 0));
  }
}

///
///
///
///
///

///
///
///
///
///

///
///
///
///
///
class NestedTabScreenWidget extends StatefulWidget {
  const NestedTabScreenWidget({super.key});

  @override
  State<NestedTabScreenWidget> createState() => NestedTabScreenWidgetState();
}

class NestedTabScreenWidgetState extends State<NestedTabScreenWidget>
    with TickerProviderStateMixin {
  int selectedCategoryIndex = 0;
  List<ProductsResModel> allProducts = [];

  final List<String> tabBar3Titles = [
    "Trending",
    "New Arrivals",
    "Top Rated",
    "On Sale",
    "Seasonal",
    "Editor's Picks",
    "Recommended",
  ];

  late TabController tabBar3Controller;

  @override
  void initState() {
    super.initState();

    tabBar3Controller =
        TabController(length: tabBar3Titles.length, vsync: this);
    fetchAndStoreProducts();
  }

  @override
  void dispose() {
    tabBar3Controller.dispose();
    super.dispose();
  }

  ///
  ///
  ///
//   Future<List<ProductsResModel>> fetchProductsBySelectedCategory() async {
//   final selectedCategory =
//       DummyDb.categories[selectedCategoryIndex]["title"]!;
//   return await ProductService.fetchProductsByCategory(selectedCategory);
// }
  ///
  ///
  ///

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<HomeProductController>(context);
    final categories = productProvider.categories;
    return DefaultTabController(
      length: tabBar3Titles.length,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(child: SizedBox(height: 5)),

          ///
          ///------------------------------first widget ---------------------------------
          ///
          SliverToBoxAdapter(
            child: SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  final isSelected = selectedCategoryIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: isSelected
                                        ? Colors.transparent
                                        : Colors.amber.shade300,
                                  ),
                                ),
                                clipBehavior: Clip.hardEdge, // <-- important
                                child: Image.network(
                                  item["image"] ?? ImageConstants.fallbackImage,
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
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item["title"]!,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? ColorConstants.mynthraPink
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          ///
          ///-----------------------Ad-------------------------------------------
          ///
          // SliverToBoxAdapter(
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => CategoryScreen()),
          //       );
          //     },
          //     child: Container(
          //       height: 150,
          //       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.deepOrange),
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       child: Center(
          //         child: Image.network(
          //           allProducts[1].brand?.image ??
          //               "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg", // Access nested brand image
          //           height: 40,
          //           fit: BoxFit.contain,
          //           errorBuilder: (context, error, stackTrace) =>
          //               Icon(Icons.image_not_supported),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          ///
          ///
          ///----------------------------Sliding images using CarouselSlider-------------------------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Consumer<HomeProductController>(
                builder: (context, provider, _) {
                  final selectedCategory =
                      categories[selectedCategoryIndex]["title"];

                  final filteredProducts = provider.allProducts
                      .where((p) =>
                          (p.category ?? "").toLowerCase() ==
                          selectedCategory!.toLowerCase())
                      .toList();

                  final filteredImages = <String>[];
                  final filteredIds = <String?>[];

                  for (var product in filteredProducts) {
                    if (product.variants?.isNotEmpty == true &&
                        product.variants!.first.images?.isNotEmpty == true) {
                      filteredImages.add(
                        provider.getFullImageUrl(
                            product.variants!.first.images!.first),
                      );
                      filteredIds.add(product.id);
                    }
                  }

                  return CarouselSliders(
                    imageUrls: filteredImages.isNotEmpty
                        ? filteredImages
                        : provider.bannerImages,
                    productIds: filteredImages.isNotEmpty
                        ? filteredIds
                        : null, // Pass null if fallback to banner
                  );
                },
              ),
            ),
          ),

          ///
          ///
          ///------------------------------------Double Layer Row-------------------------------------------
          ///
          ///
          ///
          ///
          SliverToBoxAdapter(
            child: Consumer<HomeProductController>(
              builder: (context, provider, _) {
                final featured = provider.featuredBrandsList;

                return Column(
                  children: [
                    SizedBox(height: 20),
                    ScrollingRow(
                      itemCount: featured.length,
                      itemBuilder: (index) {
                        final item = featured[index];

                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 80,
                              width: 80,
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  Image.network(
                                    item["image"] ??
                                        ImageConstants.fallbackImage,
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                        ImageConstants.fallbackImage,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 4,
                                    left: 4,
                                    right: 4,
                                    child: Container(
                                      color: Colors.black54,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item["brand"]!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white70,
                                            size: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      onTap: (index) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),

          ///
          ///
          ///
          ///
          ///

          ///
          ///
          ///------------------------------------Continue Shopping------------------------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Continue Shopping",
                  fontSize: FontConstants.title,
                ),
                SizedBox(height: 10),
                ContinuingRow(),
                SizedBox(height: 10),
              ],
            ),
          ),

          ///
          ///-----------------------Ad-------------------------------------------
          ///
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Consumer<HomeProductController>(
                builder: (context, provider, _) {
                  return CarouselSliders(imageUrls: provider.bannerImages);
                },
              ),
            ),
          ),

          ///
          ///
          ///-------------------------------------Price Store Row------------------------------------------
          ///
          ///
          // SliverToBoxAdapter(
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: 20,
          //       ),
          //       Container(
          //         decoration: BoxDecoration(
          //           gradient: LinearGradient(
          //               begin: Alignment.topCenter,
          //               end: Alignment.bottomCenter,
          //               colors: [
          //                 Color.fromARGB(255, 248, 240, 213),
          //                 Color.fromARGB(255, 255, 239, 244)
          //               ]),
          //         ),
          //         child: Column(
          //           children: [
          //             Text(
          //               "PRICE STORE",
          //               maxLines: 1,
          //               overflow: TextOverflow.ellipsis,
          //               style: TextStyle(
          //                   fontWeight: FontWeight.bold, fontSize: 25),
          //             ),
          //             SizedBox(
          //               height: 20,
          //             ),
          //             ScrollingRow(
          //               itemCount: 4,
          //               itemBuilder: (index) {
          //                 return Center(
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Column(
          //                       children: [
          //                         Text(
          //                           "Flat",
          //                           maxLines: 1,
          //                           overflow: TextOverflow.ellipsis,
          //                         ),
          //                         Text(
          //                           "80%",
          //                           maxLines: 1,
          //                           overflow: TextOverflow.ellipsis,
          //                           style: TextStyle(
          //                             fontWeight: FontWeight.bold,
          //                             fontSize: 25,
          //                             color: Colors.deepPurple,
          //                           ),
          //                         ),
          //                         Text(
          //                           "Off",
          //                           maxLines: 1,
          //                           overflow: TextOverflow.ellipsis,
          //                           style: TextStyle(
          //                             fontWeight: FontWeight.bold,
          //                             color: Colors.black,
          //                           ),
          //                         ),
          //                         Icon(
          //                           Icons.arrow_forward_rounded,
          //                           size: 10,
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 );
          //               },
          //               onTap: (index) {
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => CategoryScreen()));
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

// Positioned(
//                         bottom: 10,
//                         left: 100,
//                         child: Container(
//                           color: Colors.black45,
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                           child: Text(
//                             "Min. 55% OFF",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),

          ///
          ///
          ///-------------------------------------Featured Brands Row------------------------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Featured Brands",
                  fontSize: FontConstants.title,
                ),
                SizedBox(height: 10),
                Consumer<HomeProductController>(
                  builder: (context, provider, _) {
                    return RowWithBorderContainerType1(
                      dBList: provider.featuredBrandsList,
                    );
                  },
                ),
              ],
            ),
          ),

          ///
          ///
          ///-----------------------------------Featured Picks Row---------------------------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                TitleRow(
                  title: "Featured Picks",
                  fontSize: FontConstants.title,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                SizedBox(height: 10),
                Consumer<HomeProductController>(
                  builder: (context, provider, _) {
                    return ScrollingRow(
                      itemCount: provider.featuredPicks.length,
                      itemBuilder: (index) {
                        final item = provider.featuredPicks[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 200,
                              width: 150,
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  Image.network(
                                    item["image"]?.isNotEmpty == true
                                        ? item["image"]!
                                        : ImageConstants.fallbackImage,
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                        ImageConstants.fallbackImage,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),

                                  /// ↓↓↓ Semi-transparent background with content ↓↓↓
                                  Positioned(
                                    bottom: 10,
                                    left: 5,
                                    right: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item["name"] ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            item["category"] ?? "",
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                "₹${item["oP"] ?? ""}",
                                                style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: ColorConstants.homeBG,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                item["nP"] ?? "",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                item["reduction"] ?? "",
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                              productId: provider.featuredPicks[index]["id"] ??
                                  "685cf800728c88a1bc918219",
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          ///
          ///
          ///----------------------Best Seller Category------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                TitleRow(
                  title: "Bestseller Category",
                  fontSize: FontConstants.title,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                SizedBox(height: 10),
                Consumer<HomeProductController>(
                  builder: (context, provider, _) {
                    return PhotoTypeRow(bslist: provider.bestSellerCategory);
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          ///
          ///
          ///-------------------------------------Continue Browsing Style------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Continue Browsing These Styles",
                  fontSize: FontConstants.title,
                ),
                SizedBox(
                  height: 10,
                ),
                ContinuingRow(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          ///
          ///
          ///------------------------------Seasons Best Brands---------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Season's Best Brands",
                  fontSize: FontConstants.title,
                ),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Iconic styles to steal the spot light",
                  color: Colors.grey,
                  fontSize: FontConstants.subtitle,
                ),
                SizedBox(height: 10),
                Consumer<HomeProductController>(
                  builder: (context, provider, _) {
                    return RowWithBorderContainerType1(
                        dBList: provider.seasonsBrandsList);
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          ///
          ///
          ///------------------------------Hidden Gems---------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Hidden Gems",
                  fontSize: FontConstants.title,
                ),
                SizedBox(height: 10),
                Consumer<HomeProductController>(
                  builder: (context, provider, _) {
                    return PhotoTypeRow(bslist: provider.hiddenGems);
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          ///
          ///
          ///------------------------------Mynthra Recommends---------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Mynthra Recommends",
                  fontSize: FontConstants.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: ColorConstants.mynthraPink)),
                      child: Text(
                        "Picks You'll Love",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: FontConstants.subtitle,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.mynthraPink),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<HomeProductController>(
                  builder: (context, provider, _) {
                    final picks = provider.featuredPicks;

                    return ScrollingRow(
                      itemCount: picks.length,
                      itemBuilder: (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 210,
                              width: 150,
                              child: Image(
                                image: NetworkImage(picks[index]["image"] ??
                                    ImageConstants.fallbackImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    picks[index]["name"] ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: FontConstants.ititle,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    picks[index]["category"] ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: FontConstants.isubtitle,
                                        color: Colors.grey),
                                  ),
                                  Row(spacing: 5, children: [
                                    Text(
                                      "₹${picks[index][" oP"] ?? ""}",
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    Text(
                                      picks[index]["nP"] ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontConstants.isubtitle,
                                      ),
                                    ),
                                    Text(
                                      picks[index]["reduction"] ?? "",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ])
                                ],
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
                                productId: provider.featuredPicks[index]
                                        ["id"] ??
                                    "685cf800728c88a1bc918219"),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          ///
          ///
          ///------------------------------Whats Trending Nearby---------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: ColorConstants.homeYellow,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "What's Trending Nearby!",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "discover What's Hot in Your Region",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Consumer<HomeProductController>(
                        builder: (context, provider, _) {
                          final nearby = provider.trendingNearby;

                          return ScrollingRowV2(
                            itemCount: nearby.length,
                            itemBuilder: (index) {
                              return Stack(
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.all(15),
                                    height: 210,
                                    width: 150,
                                    child: Image(
                                      image: NetworkImage(nearby[index]
                                              ["image"] ??
                                          ImageConstants.fallbackImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: -8, // Shift left to overflow
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10,
                                            color: Colors.black87,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
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
                                      productId: nearby[index]["id"] ??
                                          "685cf800728c88a1bc918219"),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///
          ///
          ///------------------------------Featured Picks---------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Featured Picks",
                  fontSize: 20,
                ),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Iconic styles to steal the spotlight",
                  color: Colors.grey,
                  fontSize: 15,
                ),
                SizedBox(height: 10),

                /// 👇 Wrap with Consumer to access Provider
                Consumer<HomeProductController>(
                  builder: (context, provider, _) {
                    final featured = provider.featuredBrandsList;

                    return RowWithBorderContainerType1(dBList: featured);
                  },
                ),
              ],
            ),
          ),

          ///
          ///
          ///------------------------------Seasons Best Brands---------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                TitleRow(
                  title: "Season's Best Offers",
                  fontSize: 20,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),

                ///  Use Provider for bannerImages
                Consumer<HomeProductController>(
                  builder: (context, provider, _) {
                    return CarouselSliders(imageUrls: provider.bannerImages);
                  },
                ),

                SizedBox(height: 5),
              ],
            ),
          ),

          ///
          ///
          ///------------------------------Featured Picks---------------------------
          ///
          ///
          SliverToBoxAdapter(
            child: Column(
              children: [
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Featured Picks",
                  fontSize: 20,
                ),
                TitleRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  title: "Iconic styles to steal the spot light",
                  color: Colors.grey,
                  fontSize: 15,
                ),
                SizedBox(height: 10),

                /// 👇 Replace DummyDb with provider version
                Consumer<HomeProductController>(
                  builder: (context, provider, _) {
                    return RowWithBorderContainerType1(
                      dBList: provider.seasonsBrandsList,
                    );
                  },
                ),

                SizedBox(height: 20),
              ],
            ),
          ),

          ///
          ///
          ///
          ///
          ///

          ///
          ///
//           SliverToBoxAdapter(
//   child: FutureBuilder<List<ProductsResModel>>(
//     future: fetchProductsBySelectedCategory(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Center(child: Text("Error: ${snapshot.error}"));
//       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         return const Center(child: Text("No products found."));
//       }

//       final products = snapshot.data!;

//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: products.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisExtent: 240,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//           itemBuilder: (context, index) {
//             final p = products[index];
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(8)),
//                       child: Image.network(
//                         p.image ?? '',
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         errorBuilder: (_, __, ___) =>
//                             const Icon(Icons.broken_image, size: 50),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(6.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           p.title ?? 'No Title',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                         Text(
//                           "₹${p.price ?? 0}",
//                           style: const TextStyle(color: Colors.pink),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//     },
//   ),
// ),

          ///
          ///

          ///
          ///
          ///
          ///
          ///

          ///
          ///
          ///------------------------------------Tab Bar 3-------------------------------------------
          ///
          ///
          SliverPersistentHeader(
            pinned: true,
            delegate: TabBarDelegate(
              TabBar(
                controller: tabBar3Controller,
                isScrollable: true,
                labelColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabs: tabBar3Titles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final title = entry.value;

                  return Tab(
                    child: AnimatedBuilder(
                      animation: tabBar3Controller,
                      builder: (context, _) {
                        final isSelected = tabBar3Controller.index == index;

                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(30), // pill shape
                            border: Border.all(
                              color:
                                  isSelected ? Color(0xFFE91E63) : Colors.grey,
                              width: 2,
                            ),
                            color: isSelected
                                ? Colors.transparent
                                : Colors.transparent,
                          ),
                          child: Text(
                            title,
                            style: TextStyle(
                              color:
                                  isSelected ? Color(0xFFE91E63) : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 8)),
        ],
        body: TabBarView(
          controller: tabBar3Controller,
          children: tabBar3Titles.map((title) {
            return Consumer<HomeProductController>(
              builder: (context, provider, _) {
                final sortedProducts =
                    _sortProductsForTab(title, provider.allProducts);

                return InfiniteScrollGridView(
                  sourceList: _sortProductsForTab(title, provider.allProducts),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  //____________________________________for tab switch-----------------
  Future<void> fetchAndStoreProducts() async {
    allProducts = await ProductService.fetchProducts();

    if (!mounted) return; // Exit if widget is no longer in the tree

    setState(() {}); // Refresh UI safely
  }

  List<ProductsResModel> _sortProductsForTab(
      String title, List<ProductsResModel> products) {
    switch (title) {
      case "Trending":
        return products.where((product) {
          final hasProductDiscount = product.discount?.isActive == true;
          final hasVariantDiscount = product.variants?.any(
                (v) => v.discount?.isActive == true,
              ) ??
              false;
          return hasProductDiscount || hasVariantDiscount;
        }).toList();

      case "New Arrivals":
        return products.where((p) => p.createdAt != null).toList()
          ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      case "Top Rated":
        return products.toList()
          ..sort((a, b) =>
              _totalStock(b.variants) -
              _totalStock(a.variants)); // More stock = more trusted

      case "On Sale":
        return products.toList()
          ..sort((a, b) =>
              _totalStock(a.variants) -
              _totalStock(b.variants)); // Low stock = hot item

      default:
        return products;
    }
  }

  int _totalStock(List<Variant>? variants) {
    if (variants == null || variants.isEmpty) return 0;
    return variants.fold(0, (sum, v) => sum + (v.stock ?? 0));
  }
}

///
///
///----------------------------------------- Reusable infinite scroll grid
///
///
class InfiniteScrollGridView extends StatefulWidget {
  final List<ProductsResModel> sourceList;
  const InfiniteScrollGridView({super.key, required this.sourceList});

  @override
  State<InfiniteScrollGridView> createState() => _InfiniteScrollGridViewState();
}

class _InfiniteScrollGridViewState extends State<InfiniteScrollGridView> {
  final ScrollController _scrollController = ScrollController();
  List<ProductsResModel> allProducts = [];
  bool isLoadingMore = false;
  bool hasMore = true;
// int page = 1;// for future pagination

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    loadMoreItems(); // Call fetch here initially
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !isLoadingMore) {
      loadMoreItems();
    }
  }
//--------------------------For future pagination code
  // void loadMoreItems() async {
  //   if (!hasMore || isLoadingMore) return;

  //   setState(() {
  //     isLoadingMore = true;
  //   });

  //   final fetched = await ProductService.fetchProducts(); // your API call

  //   if (fetched.isEmpty) {
  //     hasMore = false;
  //   } else {
  //     setState(() {
  //       allProducts.addAll(fetched);
  //     });
  //   }

  //   setState(() {
  //     isLoadingMore = false;
  //   });
  // }
  void loadMoreItems() {
    if (!hasMore || isLoadingMore) return;

    setState(() {
      isLoadingMore = true;
    });

    int start = allProducts.length;
    int end = start + 20;

    if (start >= widget.sourceList.length) {
      hasMore = false;
    } else {
      final newItems = widget.sourceList.sublist(
        start,
        end > widget.sourceList.length ? widget.sourceList.length : end,
      );
      allProducts.addAll(newItems);
    }

    setState(() {
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      itemCount: allProducts.length + (isLoadingMore ? 1 : 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        mainAxisExtent: 290,
      ),
      itemBuilder: (context, index) {
        if (index >= allProducts.length) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorConstants.mynthraPink,
          ));
        }

        final product = allProducts[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage2(
                    productId:
                        allProducts[index].id ?? "685cf800728c88a1bc918219"),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // image: DecorationImage(
                    //   image: NetworkImage(
                    //     item["image"],
                    //   ),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    product.variants?.first.images?.first ??
                        "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg",
                        fit: BoxFit.cover,
                      );
                    },
                  )),
              Container(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? "No Title",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.category ?? "Unknown",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const SizedBox(width: 4),
                    Row(
                      children: [
                        Text(
                          "₹ ${product.variants?.first.price.toString()} " ??
                              "0 ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          getFormattedDiscount(product),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String getFormattedDiscount(ProductsResModel product) {
    final discount = product.variants?.first.discount;

    if (discount == null || discount.value == null || discount.type == null) {
      return "NO OFFER";
    }

    final type = typeValues.reverse[discount.type];

    if (type == "flat") {
      return "₹${discount.value} OFF";
    } else if (type == "percentage") {
      return "${discount.value}% OFF";
    }

    return "NO OFFER";
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  TabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color.fromARGB(
          255, 252, 250, 251), // So it doesn't blend with background
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(TabBarDelegate oldDelegate) {
    return false;
  }
}

class TabBar2Delegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  TabBar2Delegate({required this.child});

  @override
  double get minExtent => 48;
  @override
  double get maxExtent => 48;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant TabBar2Delegate oldDelegate) {
    return false;
  }
}