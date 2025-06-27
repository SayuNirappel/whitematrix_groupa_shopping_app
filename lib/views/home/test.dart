// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';
// import 'package:whitematrix_groupa_shopping_app/models/home_dummy_db.dart';
// import 'package:whitematrix_groupa_shopping_app/services/api/home_api/product_service.dart';
// import 'package:whitematrix_groupa_shopping_app/views/category/category_screen.dart';
// import 'package:whitematrix_groupa_shopping_app/views/category/product_listing_screen.dart';
// import 'package:whitematrix_groupa_shopping_app/views/home/home_screen_widgets.dart';
// import 'package:whitematrix_groupa_shopping_app/views/notifications/notification_screen.dart';
// import 'package:whitematrix_groupa_shopping_app/views/product_details/product_detail_screen.dart';
// import 'package:whitematrix_groupa_shopping_app/views/profile/profile_screen.dart';
// import 'package:whitematrix_groupa_shopping_app/views/testing_parameterPassing/parameter_test.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   //int selectedCategory = 0;
//   String? dropdownValue;
//   final List carouselImgeUrl = DummyDb.carousel1ImgeUrl;

//   int carousel1Index = 0;
//   @override
//   Widget build(BuildContext context) {
//     //appbar + tab at bottom
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//           backgroundColor: Color.fromARGB(255, 255, 239, 244),
//           appBar: AppBar(
//             backgroundColor: Color.fromARGB(255, 255, 239, 244),
//             title: Padding(
//               padding: EdgeInsets.all(5),
//               child: Container(
//                 height: 40,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         spacing: 10,
//                         children: [
//                           Text(
//                             " M",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFFE91E63)),
//                           ),
//                           Text(
//                             "Search",
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ],
//                       ),
//                       Icon(Icons.search)
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             actions: [
//               InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => NotificationScreen()));
//                   },
//                   child: Icon(Icons.notification_important_outlined)),
//               SizedBox(
//                 width: 15,
//               ),
//               Icon(Icons.favorite_outline),
//               SizedBox(
//                 width: 15,
//               ),
//               InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ProfileScreen()));
//                   },
//                   child: Icon(Icons.account_circle_outlined)),
//               SizedBox(
//                 width: 15,
//               )
//             ],
//             //tabs
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(48),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TabBar(
//                         isScrollable: false,
//                         labelColor: Color(0xFFE91E63),
//                         unselectedLabelColor: Colors.black,
//                         indicatorColor: Color(0xFFE91E63),
//                         tabs: const [
//                           Tab(text: "All"),
//                           Tab(text: "Men"),
//                           Tab(text: "Women"),
//                           Tab(text: "Kids"),
//                         ]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                     child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => CategoryScreen()));
//                         },
//                         child: Icon(Icons.window_outlined)),
//                   ) //path to collections
//                 ],
//               ),
//             ),
//           ),
//           body: TabBarView(children: [
//             ///
//             ///
//             ///____________________________________________________Tabs ___________________________________________________
//             ///
//             ///
//             NestedTabScreenWidget(),
//             NestedTabScreenWidget(),
//             NestedTabScreenWidget(),
//             NestedTabScreenWidget(),
//           ])),
//     );
//   }
// }

// ///
// ///
// ///
// ///
// ///

// ///
// ///
// ///
// ///
// ///

// ///
// ///
// ///
// ///
// ///

// class NestedTabScreenWidget extends StatefulWidget {
//   const NestedTabScreenWidget({super.key});

//   @override
//   State<NestedTabScreenWidget> createState() => NestedTabScreenWidgetState();
// }

// class NestedTabScreenWidgetState extends State<NestedTabScreenWidget>
//     with TickerProviderStateMixin {
//   int selectedCategoryIndex = 0;
//   List<ProductsResModel> allProducts = [];

//   final List<String> tabBar3Titles = [
//     "Trending",
//     "New Arrivals",
//     "Top Rated",
//     "On Sale",
//     "Seasonal",
//     "Editor's Picks",
//     "Recommended",
//   ];

//   late TabController tabBar3Controller;

//   @override
//   void initState() {
//     super.initState();

//     tabBar3Controller =
//         TabController(length: tabBar3Titles.length, vsync: this);
//     fetchAndStoreProducts();
//   }

//   @override
//   void dispose() {
//     tabBar3Controller.dispose();
//     super.dispose();
//   }

//   ///
//   ///
//   ///
// //   Future<List<ProductsResModel>> fetchProductsBySelectedCategory() async {
// //   final selectedCategory =
// //       DummyDb.categories[selectedCategoryIndex]["title"]!;
// //   return await ProductService.fetchProductsByCategory(selectedCategory);
// // }
//   ///
//   ///
//   ///

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: tabBar3Titles.length,
//       child: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           SliverToBoxAdapter(child: SizedBox(height: 5)),
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: 90,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: DummyDb.categories.length,
//                 itemBuilder: (context, index) {
//                   final item = DummyDb.categories[index];
//                   final isSelected = selectedCategoryIndex == index;

//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedCategoryIndex = index;
//                       });
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: isSelected
//                                     ? Colors.transparent
//                                     : Colors.amber.shade300,
//                               ),
//                             ),
//                             height: 50,
//                             width: 50,
//                             clipBehavior: Clip.antiAlias,
//                             child: Image.network(
//                               item["image"]!,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             item["title"]!,
//                             style: TextStyle(
//                               fontWeight: isSelected
//                                   ? FontWeight.bold
//                                   : FontWeight.normal,
//                               color:
//                                   isSelected ? Color(0xFFE91E63) : Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),

//           ///
//           ///-----------------------Ad-------------------------------------------
//           ///
//           SliverToBoxAdapter(
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => CategoryScreen()));
//               },
//               child: TempAdBanner(
//                 borderColor: Colors.deepOrange,
//                 containerColor: Colors.orangeAccent,
//                 textrColor: Colors.white,
//                 height: 50,
//                 fSize: 20,
//               ),
//             ),
//           ),

//           ///
//           ///
//           ///----------------------------Sliding images using CarouselSlider-------------------------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//               child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   child: CarouselSliders(imageUrls: DummyDb.carousel1ImgeUrl))),

//           ///
//           ///-----------------------Ad-------------------------------------------
//           ///
//           SliverToBoxAdapter(
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => CategoryScreen()));
//               },
//               child: TempAdBanner(
//                 borderColor: Colors.white,
//                 containerColor: Colors.white,
//                 textrColor: Colors.black,
//                 height: 30,
//                 fSize: 10,
//               ),
//             ),
//           ),

//           ///
//           ///
//           ///------------------------------------Double Layer Row-------------------------------------------
//           ///
//           ///
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ScrollingRow(
//                   itemCount: DummyDb.featuredBrandsList.length,
//                   itemBuilder: (index) {
//                     return Column(
//                       spacing: 10,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: 80,
//                           width: 80,
//                           clipBehavior: Clip.antiAlias,
//                           child: Stack(
//                             children: [
//                               Image(
//                                 image: NetworkImage(
//                                   DummyDb.featuredBrandsList[index]["image"]!,
//                                 ),
//                                 fit: BoxFit.cover,
//                                 height: double.infinity,
//                                 width: double.infinity,
//                               ),
//                               Positioned(
//                                   child: Row(
//                                 spacing: 5,
//                                 children: [
//                                   Text(
//                                     DummyDb.featuredBrandsList[index]["brand"]!,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                         color: Colors.white,
//                                         backgroundColor: Colors.black),
//                                   ),
//                                   Icon(
//                                     Icons.arrow_forward_ios_outlined,
//                                     color: Colors.grey,
//                                     size: 10,
//                                   )
//                                 ],
//                               ))
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                   onTap: (index) {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => CategoryScreen()));
//                   },
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///
//           ///
//           ///

//           ///
//           ///
//           ///------------------------------------Continue Shopping------------------------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "Continue Shopping",
//                   fontSize: 20,
//                 ),
//                 SizedBox(height: 10),
//                 ContinuingRow(),
//                 SizedBox(height: 10),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///-------------------------------------Price Store Row------------------------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Color.fromARGB(255, 248, 240, 213),
//                           Color.fromARGB(255, 255, 239, 244)
//                         ]),
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         "PRICE STORE",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 25),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       ScrollingRow(
//                         itemCount: 4,
//                         itemBuilder: (index) {
//                           return Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     "Flat",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   Text(
//                                     "80%",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 25,
//                                       color: Colors.deepPurple,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Off",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   Icon(
//                                     Icons.arrow_forward_rounded,
//                                     size: 10,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         onTap: (index) {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => CategoryScreen()));
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///-------------------------------------Featured Brands Row------------------------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "FEATURED BRANDS",
//                   fontSize: 20,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 RowWithBorderContainerType1(dBList: DummyDb.featuredBrandsList),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///-----------------------------------Featured Picks Row---------------------------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TitleRow(
//                     title: "Featured Picks",
//                     fontSize: 20,
//                     mainAxisAlignment: MainAxisAlignment.start),
//                 ScrollingRow(
//                   itemCount: DummyDb.featuredPicks.length,
//                   itemBuilder: (index) {
//                     return Column(mainAxisSize: MainAxisSize.min, children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         height: 200,
//                         width: 150,
//                         clipBehavior: Clip.antiAlias,
//                         child: Stack(
//                           children: [
//                             Image(
//                               image: NetworkImage(
//                                 DummyDb.featuredPicks[index]["image"]!,
//                               ),
//                               fit: BoxFit.cover,
//                               height: double.infinity,
//                               width: double.infinity,
//                             ),
//                             Positioned(
//                                 bottom: 10,
//                                 left: 2,
//                                 right: 2,
//                                 child: Container(
//                                   width: double.infinity,
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               DummyDb.featuredPicks[index]
//                                                   ["name"],
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                           IconButton(
//                                               onPressed: () {
//                                                 /// add to fav function
//                                               },
//                                               icon: Icon(
//                                                 Icons.favorite_border,
//                                                 color: Colors.grey,
//                                               ))
//                                         ],
//                                       ),
//                                       Text(
//                                         DummyDb.featuredPicks[index]
//                                             ["category"],
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       Row(
//                                         spacing: 5,
//                                         children: [
//                                           Text(
//                                             DummyDb.featuredPicks[index]["oP"],
//                                             style: TextStyle(
//                                               decoration:
//                                                   TextDecoration.lineThrough,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           Text(
//                                             DummyDb.featuredPicks[index]["nP"],
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                           Text(
//                                             DummyDb.featuredPicks[index]
//                                                 ["reduction"],
//                                             style: TextStyle(color: Colors.red),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ))
//                           ],
//                         ),
//                       ),
//                     ]);
//                   },
//                   onTap: (index) {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ProductDetailsPage2()));
//                   },
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///----------------------Best Seller Category------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "BESTSELLER CATEGORY",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                 ),
//                 PhotoTypeRow(bslist: DummyDb.bestSellerCategory),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///-------------------------------------Continue Browsing Style------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "Continue Browsing These Styles",
//                   fontSize: 20,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ContinuingRow(),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///------------------------------Seasons Best Brands---------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "Season's Best Brands",
//                   fontSize: 20,
//                 ),
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "Iconic styles to steal the spot light",
//                   color: Colors.grey,
//                   fontSize: 15,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 RowWithBorderContainerType1(dBList: DummyDb.seasonsBrandsList),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///------------------------------Hidden Gems---------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "HIDDEN GEMS",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 PhotoTypeRow(bslist: DummyDb.hiddenGems),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///------------------------------Mynthra Recommends---------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "Mynthre Recommends",
//                   fontSize: 20,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(color: Color(0xFFE91E63))),
//                       child: Text(
//                         "Picks You'll Love",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFFE91E63)),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ScrollingRow(
//                   itemCount: DummyDb.featuredPicks.length,
//                   itemBuilder: (index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 210,
//                           width: 150,
//                           child: Image(
//                             image: NetworkImage(
//                                 DummyDb.featuredPicks[index]["image"]),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(2),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 DummyDb.featuredPicks[index]["name"],
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 DummyDb.featuredPicks[index]["category"],
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(color: Colors.grey),
//                               ),
//                               Row(spacing: 5, children: [
//                                 Text(
//                                   DummyDb.featuredPicks[index]["oP"],
//                                   style: TextStyle(
//                                     decoration: TextDecoration.lineThrough,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 Text(
//                                   DummyDb.featuredPicks[index]["nP"],
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   DummyDb.featuredPicks[index]["reduction"],
//                                   style: TextStyle(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ])
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                   onTap: (index) {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ProductDetailsPage2()));
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///------------------------------Whats Trending Nearby---------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   color: Color.fromARGB(255, 248, 240, 213),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "What's Trending Nearby!",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 25),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         "discover What's Hot in Your Region",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(color: Colors.grey, fontSize: 15),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       ScrollingRowV2(
//                         itemCount: DummyDb.trendingNearby.length,
//                         itemBuilder: (index) {
//                           return Stack(
//                             children: [
//                               Container(
//                                 color: Colors.transparent,
//                                 padding: EdgeInsets.all(15),
//                                 height: 210,
//                                 width: 150,
//                                 child: Image(
//                                   image: NetworkImage(
//                                       DummyDb.trendingNearby[index]["image"]!),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               Positioned(
//                                   bottom: 0,
//                                   left: 0,
//                                   child: Text(
//                                     "${index + 1}",
//                                     style: TextStyle(
//                                         fontSize: 100,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   ))
//                             ],
//                           );
//                         },
//                         onTap: (index) {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ProductDetailsPage2()));
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///------------------------------Featured Picks---------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "Featured Picks",
//                   fontSize: 20,
//                 ),
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "Iconic styles to steal the spot light",
//                   color: Colors.grey,
//                   fontSize: 15,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 RowWithBorderContainerType1(dBList: DummyDb.featuredBrandsList),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///------------------------------Seasons Best Brands---------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TitleRow(
//                     title: "Season's Best Brands",
//                     fontSize: 20,
//                     mainAxisAlignment: MainAxisAlignment.start),
//                 TitleRow(
//                     title: "Iconic styles to seal teh spotlight",
//                     fontSize: 15,
//                     color: Colors.grey,
//                     mainAxisAlignment: MainAxisAlignment.start),
//                 CarouselSliders(imageUrls: DummyDb.carousel1ImgeUrl),
//                 SizedBox(
//                   height: 5,
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///------------------------------Featured Picks---------------------------
//           ///
//           ///
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "Featured Picks",
//                   fontSize: 20,
//                 ),
//                 TitleRow(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   title: "Iconic styles to steal the spot light",
//                   color: Colors.grey,
//                   fontSize: 15,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 RowWithBorderContainerType1(dBList: DummyDb.seasonsBrandsList),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),

//           ///
//           ///
//           ///
//           ///
//           ///

//           ///
//           ///
// //           SliverToBoxAdapter(
// //   child: FutureBuilder<List<ProductsResModel>>(
// //     future: fetchProductsBySelectedCategory(),
// //     builder: (context, snapshot) {
// //       if (snapshot.connectionState == ConnectionState.waiting) {
// //         return const Center(child: CircularProgressIndicator());
// //       } else if (snapshot.hasError) {
// //         return Center(child: Text("Error: ${snapshot.error}"));
// //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //         return const Center(child: Text("No products found."));
// //       }

// //       final products = snapshot.data!;

// //       return Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 10),
// //         child: GridView.builder(
// //           shrinkWrap: true,
// //           physics: const NeverScrollableScrollPhysics(),
// //           itemCount: products.length,
// //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //             crossAxisCount: 2,
// //             mainAxisExtent: 240,
// //             crossAxisSpacing: 10,
// //             mainAxisSpacing: 10,
// //           ),
// //           itemBuilder: (context, index) {
// //             final p = products[index];
// //             return Container(
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: Column(
// //                 children: [
// //                   Expanded(
// //                     child: ClipRRect(
// //                       borderRadius: const BorderRadius.vertical(
// //                           top: Radius.circular(8)),
// //                       child: Image.network(
// //                         p.image ?? '',
// //                         fit: BoxFit.cover,
// //                         width: double.infinity,
// //                         errorBuilder: (_, __, ___) =>
// //                             const Icon(Icons.broken_image, size: 50),
// //                       ),
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.all(6.0),
// //                     child: Column(
// //                       children: [
// //                         Text(
// //                           p.title ?? 'No Title',
// //                           style: const TextStyle(fontWeight: FontWeight.bold),
// //                           overflow: TextOverflow.ellipsis,
// //                           maxLines: 1,
// //                         ),
// //                         Text(
// //                           "₹${p.price ?? 0}",
// //                           style: const TextStyle(color: Colors.pink),
// //                         ),
// //                       ],
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       );
// //     },
// //   ),
// // ),

//           ///
//           ///

//           ///
//           ///
//           ///
//           ///
//           ///

//           ///
//           ///
//           ///------------------------------------Tab Bar 3-------------------------------------------
//           ///
//           ///
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: TabBarDelegate(
//               TabBar(
//                 controller: tabBar3Controller,
//                 isScrollable: true,
//                 labelColor: Colors.transparent,
//                 indicatorColor: Colors.transparent,
//                 tabs: tabBar3Titles.asMap().entries.map((entry) {
//                   final index = entry.key;
//                   final title = entry.value;

//                   return Tab(
//                     child: AnimatedBuilder(
//                       animation: tabBar3Controller,
//                       builder: (context, _) {
//                         final isSelected = tabBar3Controller.index == index;

//                         return Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 8),
//                           decoration: BoxDecoration(
//                             borderRadius:
//                                 BorderRadius.circular(30), // pill shape
//                             border: Border.all(
//                               color:
//                                   isSelected ? Color(0xFFE91E63) : Colors.grey,
//                               width: 2,
//                             ),
//                             color: isSelected
//                                 ? Colors.transparent
//                                 : Colors.transparent,
//                           ),
//                           child: Text(
//                             title,
//                             style: TextStyle(
//                               color:
//                                   isSelected ? Color(0xFFE91E63) : Colors.black,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             softWrap: false,
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//         body: TabBarView(
//           controller: tabBar3Controller,
//           children: tabBar3Titles.map((_) {
//             return InfiniteScrollGridView();
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   Future<void> fetchAndStoreProducts() async {
//     allProducts = await ProductService.fetchProducts();
//     setState(() {}); // Refresh UI after data is loaded
//   }
// }

// ///
// ///
// ///----------------------------------------- Reusable infinite scroll grid
// ///
// ///
// class InfiniteScrollGridView extends StatefulWidget {
//   const InfiniteScrollGridView({super.key});

//   @override
//   State<InfiniteScrollGridView> createState() => _InfiniteScrollGridViewState();
// }

// class _InfiniteScrollGridViewState extends State<InfiniteScrollGridView> {
//   final ScrollController _scrollController = ScrollController();
//   List<int> items = List.generate(20, (index) => index);
//   bool isLoadingMore = false;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollListener);
//   }

//   void _scrollListener() {
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent - 100 &&
//         !isLoadingMore) {
//       loadMoreItems();
//     }
//   }

//   void loadMoreItems() async {
//     setState(() {
//       isLoadingMore = true;
//     });

//     await Future.delayed(const Duration(seconds: 2)); // simulate load delay
//     final newItems = List.generate(20, (index) => items.length + index);

//     setState(() {
//       items.addAll(newItems);
//       isLoadingMore = false;
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       controller: _scrollController,
//       padding: const EdgeInsets.all(8),
//       itemCount: DummyDb.featuredPicks.length + (isLoadingMore ? 1 : 0),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//         mainAxisExtent: 290,
//       ),
//       itemBuilder: (context, index) {
//         if (index >= DummyDb.featuredPicks.length) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final item = DummyDb.featuredPicks[index];

//         return InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ProductDetailsPage2(),
//               ),
//             );
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                   height: 210,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     // image: DecorationImage(
//                     //   image: NetworkImage(
//                     //     item["image"],
//                     //   ),
//                     //   fit: BoxFit.cover,
//                     // ),
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: Image.network(
//                     item["image"],
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Image.network(
//                         "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg",
//                         fit: BoxFit.cover,
//                       );
//                     },
//                   )),
//               Container(
//                 padding: const EdgeInsets.all(4),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item["name"],
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       item["category"],
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Text(
//                           item["oP"],
//                           style: const TextStyle(
//                             decoration: TextDecoration.lineThrough,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           item["nP"],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         Flexible(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 6, vertical: 2),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.transparent),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               item["reduction"],
//                               style: const TextStyle(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class TabBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar tabBar;

//   TabBarDelegate(this.tabBar);

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: const Color.fromARGB(
//           255, 252, 250, 251), // So it doesn't blend with background
//       child: tabBar,
//     );
//   }

//   @override
//   double get maxExtent => tabBar.preferredSize.height;

//   @override
//   double get minExtent => tabBar.preferredSize.height;

//   @override
//   bool shouldRebuild(TabBarDelegate oldDelegate) {
//     return false;
//   }
// }

// class TabBar2Delegate extends SliverPersistentHeaderDelegate {
//   final Widget child;

//   TabBar2Delegate({required this.child});

//   @override
//   double get minExtent => 48;
//   @override
//   double get maxExtent => 48;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   bool shouldRebuild(covariant TabBar2Delegate oldDelegate) {
//     return false;
//   }
// }
