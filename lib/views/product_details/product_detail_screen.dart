import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:whitematrix_groupa_shopping_app/data/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_model.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/color_constants.dart';


class ProductDetailsPage2 extends StatefulWidget {
  const ProductDetailsPage2({super.key});
  
  @override
  State<ProductDetailsPage2> createState() => _ProductDetailsPage2State();
}

class _ProductDetailsPage2State extends State<ProductDetailsPage2> {
  int currentIndex = 0;
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
}

  @override
  Widget build(BuildContext context) {
     final product = Dummydb.products[0];
   return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children:[
          CustomScrollView(
          controller: scrollController,
          slivers: [
            //header section
            buildHeader(context, product),
             SliverToBoxAdapter(
               //image section
             child: buildImages(product),
              ), 
        SliverList(
        delegate: SliverChildBuilderDelegate(
         childCount: Dummydb.products.length,
        (context, index) {
          final product = Dummydb.products[index];
          
          final formattedDate = DateFormat('EEE, d MMM').format(DateTime.now().add(Duration(days: 5)));

       return Padding(
         padding: const EdgeInsets.all(15.0),
         child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                product.imageUrls?.length ?? 0,
                (i) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == i
                        ? ColorConstants.grey
                        : ColorConstants.secondaryColor1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //title, price, and size selection,delivery,services
                buildTitleAndSize(product, formattedDate),
                const SizedBox(height: 20),
                buildProductDetails(),
                Divider(
                  thickness: 1,
                  color: ColorConstants.secondaryColor1,
                  indent: 6,
                  endIndent: 6,
                ),
                buildcustomerQuestions(),
                Divider(
                  thickness: 1,
                  color: ColorConstants.secondaryColor1,
                  indent: 6,
                  endIndent: 6,
                ),
                buildCustomerRatings(),
                Text(
                  "View all reviews >",
                  style: GoogleFonts.roboto(
                    color: ColorConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  thickness: 1,
                  color: ColorConstants.secondaryColor1,
                  indent: 6,
                  endIndent: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(2, (i) {
                      int itemIndex = i + 2;
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ColorConstants.secondaryColor1.withAlpha(50),
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
                ),
                const SizedBox(height: 16,),
    
              ],
            ),
          ],
               ),
       );
    },
   
  ),
),       
   //similar products     
  SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Similar Products',
          style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Dummydb.products.length,
            itemBuilder: (context, i) {
              final item = Dummydb.products[i];
              return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              color: ColorConstants.backgroundColor,
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item.imageUrls?.first ?? '',
                      width: double.infinity,
                      height: 170,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: 
                    Text(
                      item.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: 
                    Text(
                      item.subtitle ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: ColorConstants.textColor.withAlpha(110)),
                    ),
                  ),
                ElevatedButton(
                style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                side: BorderSide(color: ColorConstants.primaryColor),
                backgroundColor: ColorConstants.backgroundColor,
                foregroundColor: ColorConstants.primaryColor,
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Add to Bag", 
                       overflow: TextOverflow.ellipsis, 
                       style: GoogleFonts.roboto(
                         fontWeight: FontWeight.bold, 
                         fontSize: 16
                         )),
                ],
              ),
            ),
                ],
              ),
            ),
          );
            },
          ),
        ),
      ],
    ),
  ),
),
SliverToBoxAdapter(
  child: Padding(
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
  ),
    
)

        ],
       ),
          // Sticky Buy Now/Add to Bag Buttons
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
      ]),
  );
  }

  SliverAppBar buildHeader(BuildContext context, ProductModel product) {
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${product.title} ${product.subtitle}',
                            style: GoogleFonts.roboto(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (product.rating != null)
                          Row(
                            children: [
                              Text(
                                '${product.rating?.toStringAsFixed(1)}',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.textColor,
                                ),
                              ),
                              Icon(Icons.star, size: 12, color: ColorConstants.textColor),
                            ],
                          ),
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
                        Text(
                          '₹${product.price?.toStringAsFixed(0)}',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (product.offer != null)
                          Flexible(
                            child: Text(
                              '(${product.offer})',
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
                  softWrap: false,
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

Stack buildImages(ProductModel product) {
  return Stack(
    children: [
      CarouselSlider(
        items: product.imageUrls?.map((url) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 500,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          onPageChanged: (indexVal, reason) {
            setState(() {
              currentIndex = indexVal;
            });
          },
        ),
      ),
      if (product.rating != null)
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
                  product.rating!.toStringAsFixed(1),
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
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


  ExpansionTile buildCustomerRatings() {
    return ExpansionTile(
        childrenPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
          ),
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ratings & Reviews", style: GoogleFonts.roboto(
              fontSize: 22,
              fontWeight: FontWeight.bold)),
          
            Row(
            children: [
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text("4.8 ★", 
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          SizedBox(width: 8),
          Text("9 ratings | 2 reviews"),
        ]),
        ],
      ),
      children: [
        const SizedBox(height: 8),
          Align(
          alignment: Alignment.centerLeft,
          child: Text('Customer Reviews (2)', style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
        ),
        
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Text("5 ★", style: GoogleFonts.roboto(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ),
             const SizedBox(width: 8),
              Text(
              '2 months ago',
              style: GoogleFonts.roboto(color: Colors.grey),
             )
            ],
          ),
          const SizedBox(height: 8),

// Review Text
Align(
  alignment: Alignment.centerLeft,
  child: const Text(
    'Good 😊',
    style: TextStyle(fontSize: 16),
  ),
),
const SizedBox(height: 8),
  Align(
    alignment: Alignment.centerLeft,
    child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: ColorConstants.secondaryColor1.withAlpha(50),
      borderRadius: BorderRadius.circular(4),
    ),
    child: const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Size bought: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: 'S'),
        ],
      ),
    ),
              ),
  ),
const SizedBox(height: 12),
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
      'Shadiya Zama',
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
    Row(
      children: [
        const Text(
          'Helpful?',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            const Icon(Icons.thumb_up_alt_outlined, size: 20),
            const SizedBox(width: 2),
            const Text('2'),
          ],
        ),
        const SizedBox(width: 12),
        const Icon(Icons.thumb_down_alt_outlined, size: 20),
        const SizedBox(width: 8),
        const Icon(Icons.more_vert, size: 20),
      ],
    )
  ],
),
const SizedBox(height: 16),
      ],
    );
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
              side: BorderSide(color: ColorConstants.secondaryColor1),
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
ExpansionTile buildProductDetails() {
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
        Dummydb.products[0].description!,
        style: GoogleFonts.roboto(fontSize: 16, color: Colors.black54),
      ),
    ],
  );
}

Column buildTitleAndSize(ProductModel product, formattedDate) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: GoogleFonts.roboto(fontSize: 22, color: Colors.black),
          children: [
            TextSpan(
              text: '${product.title ?? ''} ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: product.subtitle ?? ''),
          ],
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
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
            '₹${product.originalPrice?.toStringAsFixed(0) ?? ''}',
            style: GoogleFonts.roboto(
              fontSize: 22,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '₹${product.price?.toStringAsFixed(0) ?? ''}',
            style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Container(
            height: 22,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFF6161), Color(0xFFFFA761)]),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                product.offer ?? '',
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      if (product.sizes != null && product.sizes!.isNotEmpty)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "SIZE: S",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 22),
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
                Icon(Icons.arrow_forward_ios_outlined, size: 15, color: ColorConstants.primaryColor),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: product.sizes!.map((size) {
                  final isSelected = selectedSize == size;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = size;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        decoration: BoxDecoration(
                          color: isSelected ? ColorConstants.textColor : ColorConstants.backgroundColor,
                          border: Border.all(
                            color: isSelected ? ColorConstants.textColor : ColorConstants.secondaryColor1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          size,
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
      const SizedBox(height: 16),
      Text(
        "Tag past purchases & get right size recommendations",
        style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey.shade500),
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Text(
            '₹${product.originalPrice?.toStringAsFixed(0) ?? ''}',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '₹${product.price?.toStringAsFixed(0) ?? ''}',
            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
           Text(
           '( ${product.offer})',
            style: GoogleFonts.roboto(color: Colors.orange.shade300, fontSize: 16, fontWeight: FontWeight.bold),
          ),
           ],
      ),
      Text('Delivery by $formattedDate'),
      Row(
        children: [
          const Text('Seller:'),
          const SizedBox(width: 4),
          Text(
            "Flashstar Commerce",
            style: GoogleFonts.roboto(color: ColorConstants.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
      const SizedBox(height: 16),
      
      //screen button
      Container(
        key: screenButtonKey,
        color: Colors.white,
        child: buildBottomButtons(),
      ),
      const SizedBox(height: 16),
      Text(
        "Delivery & Services",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              product.pin ?? 'no pin',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                "Change",
                style: TextStyle(
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
      if (product.deliveryInfo != null)
        Row(
          children: [
            const Icon(Icons.local_shipping_outlined),
            const SizedBox(width: 8),
            Text(
              "Express delivery by $formattedDate",
              style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
          ],
        ),
      Row(
        children: [
          const SizedBox(width: 35),
          Text(product.deliveryInfo!),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          const Icon(Icons.payments_outlined),
          const SizedBox(width: 8),
          Text(
            "Pay on Delivery is available",
            style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.swap_horizontal_circle_outlined, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Hassle free 7 days Return & Exchange",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
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
              onPressed: () {},
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
}