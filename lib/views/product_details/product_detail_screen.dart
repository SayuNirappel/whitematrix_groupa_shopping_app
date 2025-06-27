import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/product_details_controller.dart';
import 'package:whitematrix_groupa_shopping_app/core/network/api_helper.dart';
import 'package:whitematrix_groupa_shopping_app/data/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/color_constants.dart';

import 'package:flutter/material.dart';

class ProductDetailsPage2 extends StatefulWidget {
<<<<<<< HEAD
  const ProductDetailsPage2({super.key});

=======
   final String productId;

  const ProductDetailsPage2({super.key, required this.productId}); 
>>>>>>> 0d9fef504b8d3e228b86f12d9dd5f577d3186ceb
  @override
  State<ProductDetailsPage2> createState() => _ProductDetailsPage2State();
}

class _ProductDetailsPage2State extends State<ProductDetailsPage2> {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
// class ProductDetailsPage2 extends StatefulWidget {
//   const ProductDetailsPage2({super.key});
=======
  int selectedVariantIndex = 0;
  int selectedImageIndex = 0;
  String? selectedSize;
  final ScrollController scrollController = ScrollController();
  bool showAppBarDetails = false;
  final GlobalKey screenButtonKey = GlobalKey();
  bool showStickyButton = false;

  @override
void initState() {
  super.initState();
  scrollController.addListener(() {  //for header
      if (scrollController.offset > 600 && !showAppBarDetails) {
        setState(() => showAppBarDetails = true);
      } else if (scrollController.offset <= 600 && showAppBarDetails) {
        setState(() => showAppBarDetails = false);
      }
    });
>>>>>>> 0d9fef504b8d3e228b86f12d9dd5f577d3186ceb
  
   scrollController.addListener(() { //for sticky button on bottom bar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final RenderBox? box =
            screenButtonKey.currentContext?.findRenderObject() as RenderBox?;
        if (box != null) {
          final pos = box.localToGlobal(Offset.zero).dy;
          final screenHeight = MediaQuery.of(context).size.height;
          final shouldShow = pos > screenHeight - 100;
          if (shouldShow != showStickyButton) {
            setState(() {
              showStickyButton = shouldShow;
            });
          }
        }
      });
    });
    
   
    WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<ProductProvider>().fetchProductById(widget.productId);
  
  });
}
@override
Widget build(BuildContext context) {
   String timeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);
  if (diff.inDays >= 365) return '${(diff.inDays / 365).floor()} year ago';
  if (diff.inDays >= 30) return '${(diff.inDays / 30).floor()} month ago';
  if (diff.inDays >= 1) return '${diff.inDays} day ago';
  if (diff.inHours >= 1) return '${diff.inHours} hour ago';
  return '${diff.inMinutes} minute ago';
}
  
  final provider = context.watch<ProductProvider>();
  final product = provider.selectedProduct;
  
  if (provider.isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (product == null) {
    return const Center(child: Text("Product not found"));
  }

    final selectedVariant = product.variants![selectedVariantIndex];
    final selectedSku = selectedVariant.sku;
    final images = selectedVariant.images;
    final reviews = product.reviews;
    final productId = widget.productId;
    final mainImageUrl = (images != null && images.isNotEmpty)
        ? '${AppConfig.baseUrl}$productId${images[selectedImageIndex]}'
        : '';

    final pricing = provider.getPricingInfo(product, selectedSize);
    final price = pricing['price'];
    final offerPrice = pricing['offerPrice'];
    final discountText = pricing['discountText'];
    final hasDiscount = pricing['hasDiscount'];
     final formattedDate = DateFormat('EEE, d MMM').format(
      DateTime.now().add(const Duration(days: 5)),
     );


    final variantSizes = (product.variants ?? [])
        .map((v) => v.size)
        .where((s) => s?.isNotEmpty == true)
        .toSet()
        .toList();
        
       final avgRating = (reviews == null || reviews.isEmpty)
              ? 0.0
              : reviews
                  .map((r) => r.rating as int)
                  .fold<int>(0, (a, b) => a + b) /
                reviews.length;  
        
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
            // Header section
            buildHeader(context, product, offerPrice, discountText, avgRating),

            // Image carousel
            SliverToBoxAdapter(child: buildImages(
              product,
              selectedVariantIndex,
              selectedImageIndex,
              widget.productId,
              avgRating,
              reviews
            ),),           
             // Product detail section 
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // Dots indicator
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(
                    //     product.image?.length ?? 0,
                    //     (i) => Container(
                    //       width: 8,
                    //       height: 8,
                    //       margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: currentIndex == i
                    //             ? ColorConstants.grey
                    //             : ColorConstants.secondaryColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                     
                          buildTitleAndSize(
                          context,
                          product,
                          formattedDate,
                          offerPrice,
                          discountText,
                          price,
                          hasDiscount,
                          variantSizes,
                          selectedVariantIndex,
                          selectedImageIndex,
                          mainImageUrl,
                          productId,
                          images ?? [],
                          selectedSize,
                          (int newIndex) => setState(() => selectedImageIndex = newIndex),
                          (String newSize) => setState(() => selectedSize = newSize),
                        ),

                        const SizedBox(height: 20),
                          buildSummary(selectedVariant, offerPrice, discountText ,formattedDate),
                        // screen button
                        Container(
                         key: screenButtonKey,
                         color: Colors.white,
                         child: buildBottomButtons(),
                        ),
                       const SizedBox(height: 16),
                       buildDeliveryandServices(formattedDate),
                       buildProductDetails(product),
                        Divider(
                          thickness: 1,
                          color: ColorConstants.secondaryColor,
                          indent: 6,
                          endIndent: 6,
                        ),
                        buildcustomerQuestions(),
                        Divider(
                          thickness: 1,
                          color: ColorConstants.secondaryColor,
                          indent: 6,
                          endIndent: 6,
                        ),
                      buildCustomerRating(reviews ?? [], timeAgo , avgRating),
                      buildService(),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Similar products
          //  SliverToBoxAdapter(child: buildSimilarProducts(product,provider)),

            // More info section
            SliverToBoxAdapter(child: buildMoreInfoSection()),
          ],
        ),

        // Sticky button
        Positioned(
          bottom: showStickyButton ? 0 : -120,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Container(
                color: Colors.white,
                child: buildBottomButtons(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Column buildDeliveryandServices(String formattedDate) {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      "Delivery & Services",
      style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 22),
    ),
    const SizedBox(height: 10),

    /// PIN Code Row
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            '456788',
            style: GoogleFonts.roboto(fontSize: 16),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
            },
            child: Text(
              "Change",
              style: GoogleFonts.roboto(
                color: ColorConstants.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),

    const SizedBox(height: 20),

    /// Express Delivery
      Row(
        children: [
          const Icon(Icons.local_shipping_outlined),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Express delivery by $formattedDate",
              style: GoogleFonts.roboto(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),

    const SizedBox(height: 20),

    /// Pay on Delivery
    Row(
      children: [
        const Icon(Icons.payments_outlined),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "Pay on Delivery is available",
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),

    const SizedBox(height: 20),

    /// Return & Exchange
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.swap_horizontal_circle_outlined),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "Hassle-free 7 days Return & Exchange",
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),

    const SizedBox(height: 20),
  ],
);
}

Column buildSummary(Variant selectedVariant, offerPrice, discountText,formattedDate) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
children: [
  Text(
    "Tag past purchases & get right size recommendations",
    style: GoogleFonts.roboto(
      fontSize: 16,
      color: Colors.grey.shade500,
    ),
  ),
  const SizedBox(height: 16),

// Pricing Row
Row(
children: [
  if (selectedVariant.price != null &&
      selectedVariant.discount != null &&
      selectedVariant.discount?.isActive == true) ...[
    Text(
      '₹${selectedVariant.price != null ? selectedVariant.price!.toStringAsFixed(0) : ''}',
      style: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.grey,
        decoration: TextDecoration.lineThrough,
      ),
    ),
    const SizedBox(width: 8),
  ],
  Text(
    '₹${offerPrice.toStringAsFixed(0)}',
    style: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
  if (discountText != null) ...[
    const SizedBox(width: 8),
    Text(
      '($discountText)',
      style: GoogleFonts.roboto(
        color: Colors.orange.shade300,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
],
),

const SizedBox(height: 8),

// Seller Info
Row(
children: [
  Text('Seller:'),
  const SizedBox(width: 4),
  Text(
    "Flashstar Commerce",
    style: GoogleFonts.roboto(
      color: ColorConstants.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  ),
],
),

const SizedBox(height: 16),
],
);
}


 Column buildCustomerRating(List<dynamic> reviews, String Function(DateTime date) timeAgo, avgRating) {
   return Column(
  children: [
    if (reviews.isNotEmpty) ...[
      Builder(
        builder: (context) {
          final totalRatings = reviews.length;
        
          return ExpansionTile(
            childrenPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ratings & Reviews",
                    style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.green, borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          '${avgRating.toStringAsFixed(1)} ★',
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('$totalRatings rating'),
                  ],
                ),
              ],
            ),
            children: reviews.map<Widget>((r) {
             final rating = r.rating;
             final comment = r.comment;
             final created = r.createdAt;
              final ago = timeAgo(created);

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.green, borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          child: Text("${rating.toStringAsFixed(1)} ★",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(ago, style: GoogleFonts.roboto(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(comment, style: GoogleFonts.roboto(fontSize: 16)),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          );
        },
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "View all reviews >",
          style: GoogleFonts.roboto(
            color: ColorConstants.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Divider(
        thickness: 1,
        color: ColorConstants.secondaryColor,
        indent: 6,
        endIndent: 6,
      ),
    ],
  ],
);
 }

 Padding buildService() {
   return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(2, (i) {
        final itemIndex = i + 2;
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorConstants.secondaryColor.withAlpha(50),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                Dummydb.items[itemIndex]['icon']!,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              Dummydb.items[itemIndex]['text']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: ColorConstants.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }),
    ),
  );
 }
//similiar poducts

// Padding buildSimilarProducts(product,provider) {
//   //final provider = context.watch<ProductProvider>();
//   final currentProduct = provider.selectedProduct;

//   // Guard: no product or empty list
//   if (currentProduct == null || provider.product.isEmpty) {
//     return const Padding(
//       padding: EdgeInsets.all(16),
//       child: Text('No similar products available.'),
//     );
//   }

//   // Filter similar products by category, excluding current product
//   final similarProducts = provider.products
//       .where((p) => p.category == currentProduct.category && p.id != currentProduct.id)
//       .toList();

//   if (similarProducts.isEmpty) {
//     return const Padding(
//       padding: EdgeInsets.all(16),
//       child: Text('No similar products found.'),
//     );
//   }

//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Similar Products',
//           style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         SizedBox(
//           height: 300,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: similarProducts.length,
//             itemBuilder: (context, i) {
//               final item = similarProducts[i];

//               return Container(
//                 width: 160,
//                 margin: const EdgeInsets.only(right: 12),
//                 child: Card(
//                   color: ColorConstants.backgroundColor,
//                   elevation: 0,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Image.network(
//                           item.image?.first ?? '',
//                           width: double.infinity,
//                           height: 170,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text(
//                           item.title ?? '',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: GoogleFonts.roboto(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: Text(
//                           item.subtitle ?? '',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: GoogleFonts.roboto(
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal,
//                             color: ColorConstants.textColor.withAlpha(110),
//                           ),
//                         ),
//                       ),
//                       ElevatedButton(
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                           side: BorderSide(color: ColorConstants.primaryColor),
//                           backgroundColor: ColorConstants.backgroundColor,
//                           foregroundColor: ColorConstants.primaryColor,
//                         ),
//                         onPressed: () {
//                        
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Add to Bag",
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.roboto(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }


  Padding buildMoreInfoSection() {
    return Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
            "More Information",
            style: GoogleFonts.roboto(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            ),
          ),
      const SizedBox(height: 6),
      const Text("Product Code: 32467"),
      const SizedBox(height: 4),
      Text(
        "View More",
        style: TextStyle(color: ColorConstants.primaryColor, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      ],
    ),
);
  }

  SliverAppBar buildHeader(
  BuildContext context,
  product,
  double offerPrice,
  String? discountText,
  double avgRating,
) {
  final List<dynamic> reviews = product.reviews ?? [];
  final int totalReviews = reviews.length;

  return SliverAppBar(
    backgroundColor: ColorConstants.backgroundColor,
    surfaceTintColor: ColorConstants.backgroundColor,
    elevation: 0,
    pinned: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_sharp, size: 35),
      onPressed: () => Navigator.pop(context),
    ),
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: Image.network(
            'https://aartisto.com/wp-content/uploads/2020/11/myntra-930x620.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: showAppBarDetails
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${product.title}',
                      style: GoogleFonts.roboto(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (totalReviews > 0) ...[
                          Text(
                            avgRating.toStringAsFixed(1),
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.textColor,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.star, size: 12, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            '|',
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              color: ColorConstants.textColor,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          '₹ $offerPrice',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (discountText != null)
                          Flexible(
                            child: Text(
                              '($discountText)',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: ColorConstants.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                      ],
                    ),
                  ],
                )
              : Text(
                  product.title ?? '',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
        ),
      ],
    ),
    actions: [
      IconButton(icon: const Icon(Icons.share_outlined, size: 25), onPressed: () {}),
      IconButton(icon: const Icon(Icons.favorite_border_outlined, size: 25), onPressed: () {}),
      IconButton(icon: const Icon(Icons.shopping_bag_outlined, size: 25), onPressed: () {}),
    ],
  );
}


Stack buildImages(product, int selectedVariantIndex, int selectedImageIndex, String productId, avgRating, reviews) {
  final images = product.variants![selectedVariantIndex].images ?? [];
  final imageUrl = images.isNotEmpty
      ? '${AppConfig.baseUrl}$productId${images[selectedImageIndex]}'
      : '';

  return Stack(
    children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl.isNotEmpty
              ? imageUrl
              : 'https://via.placeholder.com/500x500?text=No+Image',
          height: 500,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.broken_image, size: 100),
          ),
        ),
      ),
      
      if (reviews.isNotEmpty)
  
      Positioned(
        bottom: 15,
        right: 18,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                avgRating.toStringAsFixed(1),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.star, color: Colors.green, size: 16),
            ],
          ),
        ),
      ),
    ],
  );
}

}

ExpansionTile buildcustomerQuestions() {
  return ExpansionTile(
    childrenPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    title: Text(
      "Customer Questions",
      style: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Be the first one to ask a question",
                  style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Your questions will be\nanswered by people who\nbought this",
                  style: GoogleFonts.roboto(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Image section
          Image.network(
            "https://cdn-icons-png.flaticon.com/512/6396/6396130.png",
            width: 80,
            height: 80,
          ),
        ],
      ),
      Center(
        child: SizedBox(
          width: 350,
          height: 40,
          child: OutlinedButton(
            onPressed: null,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              foregroundColor: ColorConstants.textColor,
              backgroundColor: ColorConstants.backgroundColor,
              side: BorderSide(color: ColorConstants.secondaryColor),
            ),
            child: Text(
              "Ask a question",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstants.textColor,
              ),
            ),
          ),
        ),
      )
    ],
  );
}
ExpansionTile buildProductDetails(product) {
  return ExpansionTile(
    childrenPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product details",
          style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          "Explore product’s standout features",
          style: GoogleFonts.roboto(fontSize: 16),
        ),
      ],
    ),
    children: [
      Text(
        product.description!,
        style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
      ),
    ],
  );
}


Column buildTitleAndSize(
  BuildContext context,
  ProductsResModel product,
  String formattedDate,
  double offerPrice,
  String? discountText,
  int price,
  bool hasDiscount,
  List<String?> variantSizes,
  int selectedVariantIndex,
  int selectedImageIndex,
  String mainImageUrl,
  String productId,
  List<String> images,
  String? selectedSize,
  Function(int) onImageSelected,
  Function(String) onSizeSelected,
) {
  final provider = Provider.of<ProductProvider>(context);  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// Title and subtitle
      RichText(
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: GoogleFonts.roboto(fontSize: 22, color: Colors.black),
          children: [
            TextSpan(
              text: '${product.title} ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),

      /// Price section
      Row(
        children: [
          if (hasDiscount) ...[
            Text(
              'MRP',
              style: GoogleFonts.roboto(
                fontSize: 22,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '₹${product.variants != null ? product.variants![selectedVariantIndex].price : ''}',
              style: GoogleFonts.roboto(
                fontSize: 22,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            '₹${offerPrice.toStringAsFixed(0)}',
            style: GoogleFonts.roboto(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (discountText != null) ...[
            const SizedBox(width: 8),
            Container(
              height: 22,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6161), Color(0xFFFFA761)],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  discountText,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),

      const SizedBox(height: 16),

      /// Color Section
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Colour ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: product.variants != null
                      ? product.variants![selectedVariantIndex].color
                      : '',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          /// Variant Images
          Row(
            children: List.generate(images.length, (imageIndex) {
              final imagePath = images[imageIndex];
              final fullImageUrl = '${AppConfig.baseUrl}$productId$imagePath';

              return GestureDetector(
                onTap: () => onImageSelected(imageIndex),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedImageIndex == imageIndex
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: fullImageUrl,
                      width: 120,
                      height: 180,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 120,
                        height: 180,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 120,
                        height: 180,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),

      const SizedBox(height: 16),

      /// Size Section
      if (variantSizes.isNotEmpty)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'SIZE: ${selectedSize ?? ''}',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
                Text(
                  "Size Chart",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: ColorConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                 Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 15,
                  color: ColorConstants.primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: variantSizes.map<Widget>((size) {
                  final isSelected = selectedSize == size;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => onSizeSelected(size),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorConstants.textColor
                              : ColorConstants.backgroundColor,
                          border: Border.all(
                            color: isSelected
                                ? ColorConstants.textColor
                                : ColorConstants.secondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          size!,
                          style: GoogleFonts.roboto(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
    ],
  );
}

  SafeArea buildBottomButtons() {
    return SafeArea(
    child: Container(
      height: 45,
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline_sharp, color: ColorConstants.primaryColor, size: 28),
          ),
          Expanded(
            child: ElevatedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                side: BorderSide(color: ColorConstants.primaryColor),
                backgroundColor: ColorConstants.backgroundColor,
                foregroundColor: ColorConstants.primaryColor,
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 20),
                  const SizedBox(width: 6),
                  Text("Buy Now", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 17)),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                side: BorderSide(color: ColorConstants.primaryColor),
                backgroundColor: ColorConstants.primaryColor,
                foregroundColor: ColorConstants.backgroundColor,
              ),
              onPressed: () {
  //                Provider.of<CartProvider>(context, listen: false).addItem(products);
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(content: Text("Added to cart")),
  // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 20, color: ColorConstants.backgroundColor),
                  SizedBox(width: 6),
                  Text("Add To Bag", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 17)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }
