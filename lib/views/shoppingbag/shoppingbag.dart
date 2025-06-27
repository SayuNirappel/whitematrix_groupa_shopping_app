import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/cartcontroller.dart';
import 'package:whitematrix_groupa_shopping_app/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/addresspage.dart';


class ShoppingProgressIndicator extends StatefulWidget {
  final int currentStep;
  final Duration animationDuration;

  const ShoppingProgressIndicator({
    Key? key,
    required this.currentStep,
    this.animationDuration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  State<ShoppingProgressIndicator> createState() =>
      _ShoppingProgressIndicatorState();
}

class _ShoppingProgressIndicatorState extends State<ShoppingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void didUpdateWidget(ShoppingProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        children: [
          // Bag Step
          Expanded(
            child: Row(
              children: [
               
                
             
                Expanded(
                  child: AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: widget.currentStep >= 1 ? 1.0 : 
                               (widget.currentStep >= 0 ? _progressAnimation.value : 0.0),
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF26A69A)),
                        minHeight: 2,
                      );
                    },
                  ),
                ),
                Stack(
  alignment: Alignment.center,
  children: [
    AnimatedContainer(
      duration: widget.animationDuration,
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.currentStep >= 1
            ? const Color(0xFF26A69A) // Green background when step >= 1
            : Colors.transparent, // No background when step < 1
        border: Border.all(
          color: widget.currentStep >= 0
              ? const Color(0xFF26A69A)
              : Colors.grey.shade300,
        ),
      ),
    ),
    
    if (widget.currentStep >= 1)
      const Icon(
        Icons.check, // Green checkmark
        size: 10,
        color: Colors.white,
      ),
    if (widget.currentStep < 1)
      Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade300,
        ),
      ),
  ],
),
              // CircleAvatar(
              //   radius: 7,bo
              // ),
                const SizedBox(width: 4),
                    Text(
                  'Bag',
                  style: TextStyle(
                    fontSize: 9.5,
                    color: widget.currentStep >= 0 
                        ? const Color(0xFF26A69A) 
                        : Colors.grey,
                    fontWeight: widget.currentStep == 0 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          
          // Address Step
          Expanded(
            child: Row(
              children: [
             
                const SizedBox(width: 4),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: widget.currentStep >= 2 ? 1.0 : 
                               (widget.currentStep >= 1 ? _progressAnimation.value : 0.0),
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF26A69A)),
                        minHeight: 2,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
             
                Stack(
                  alignment: Alignment.center,
                  children: [
                      AnimatedContainer(
      duration: widget.animationDuration,
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.currentStep >= 2
            ? const Color(0xFF26A69A) // Green background when step >= 1
            : Colors.transparent, // No background when step < 1
        border: Border.all(
          color: widget.currentStep >= 1
              ? const Color(0xFF26A69A)
              : Colors.grey.shade300,
        ),
      ),
    ),
    
    if (widget.currentStep >= 2)
      const Icon(
        Icons.check, // Green checkmark
        size: 10,
        color: Colors.white,
      ),
    if (widget.currentStep < 2)
      Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade300,
        ),
      ),
  ],
),
                const SizedBox(width: 4),
                Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 10,
                    color: widget.currentStep >= 1 
                        ? const Color(0xFF26A69A) 
                        : Colors.grey,
                    fontWeight: widget.currentStep == 1 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                  ),
                ),
          
       
          Expanded(
            child: Row(
              children: [
             
                const SizedBox(width: 4),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: widget.currentStep >= 3 ? 1.0 : 
                               (widget.currentStep >= 2 ? _progressAnimation.value : 0.0),
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF26A69A)),
                        minHeight: 2,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
             
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration: widget.animationDuration,
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                           shape: BoxShape.circle,
                        border: Border.all(color:widget.currentStep >= 2 ?
                         const Color(0xFF26A69A)
                          : Colors.grey.shade300,)
                      ),
                    ),
                     Container(
                                       width: 6,
                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade300
                                      ),
                                     )
                  ],
                ),
                const SizedBox(width: 4),
                Text(
                  'payment',
                  style: TextStyle(
                    fontSize: 10,
                    color: widget.currentStep >= 2
                        ? const Color(0xFF26A69A) 
                        : Colors.grey,
                    fontWeight: widget.currentStep == 2 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                  ),
                ),
        ],
      ),
    );
  }
}

class ShoppingBagScreen extends StatefulWidget {
  const ShoppingBagScreen({super.key});

  @override
  State<ShoppingBagScreen> createState() => _ShoppingBagScreenState();
}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
double _calculateTotalMRP() {
  if (selectedIndexes.isEmpty) return 0.0;

  double totalMRP = 0.0;
  for (int index in selectedIndexes) {
    if (index >= 0 && index < cartItems.length) {
      final item = cartItems[index];
      final cutPrice = double.tryParse(item["cutprice"].toString()) ?? 0.0;
      totalMRP += cutPrice;
    }
  }
  return totalMRP;
}
double _calculateDiscountMRP() {
  if (selectedIndexes.isEmpty) return 0.0;
  double totalOriginalPrice = 0.0;
  for (int index in selectedIndexes) {
    if (index >= 0 && index < cartItems.length) {
      final item = cartItems[index];
      final originalPrice = double.tryParse(item["price"].toString()) ?? 0.0;
      final quantity = itemQuantities[index] ?? 1;
      totalOriginalPrice += originalPrice * quantity;
    }
  }
  double totalCutPrice = _calculateTotalMRP();
  return totalOriginalPrice - totalCutPrice;
}

double _calculateTotalAmount() {
  double total = selectedTotal; // Includes price * quantity for selected items
  total += 20; // Platform fee as per your code
  if (isDonationChecked) total += selectedAmount; // Add donation if checked
  return total;
}

List<String> _getSelectedItemImages() {
  return selectedIndexes
      .where((index) => index >= 0 && index < cartItems.length)
      .map((index) => cartItems[index]["image"] as String)
      .toList();
}


 bool isDonationChecked = false;
  int selectedAmount = 10;

  List<int> donationOptions = [10, 20, 30, 40];

    final PageController _pageController = PageController(viewportFraction: 0.9);
 Set<int> selectedIndexes = {}; 
  List<Map<String, dynamic>> cartItems = [];
  final List<String> _logos = [
    'assets/images/HDFC_Bank_(1).png',
    'assets/images/HDFC_Bank_(1).png',
    'assets/images/Paytm_(3).png',
    'assets/images/Myntra_logo_PNG_(1).png',
  ];


int _currentIndex=0;
  bool isSelected = false;
 String selectedSize = "40"; // default

  final List<String> sizes = ["38", "40", "42", "44", "46"];
    Map<int, int> itemQuantities = {};
      
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
 @override
 void initState() {
  super.initState();
  // Initialize cartItems from Provider
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() {
      cartItems = context.read<CartProvider>().items;
      for (int i = 0; i < cartItems.length; i++) {
        itemQuantities[i] = 1; // Default quantity is 1
      }
    });
  });
}

  int get selectedCount => selectedIndexes.length;

  int get totalCount => cartItems.length;

  double get selectedTotal {
  double total = selectedIndexes.fold(
    0,
    (prev, i) => prev + (getItemTotalPrice(i)),
  );
  return selectedIndexes.isNotEmpty ? total + 20 : 0;
}

double _calculateTotalSavings() {
  if (selectedIndexes.isEmpty) return 0.0;

  double totalSavings = 0.0;
  for (int index in selectedIndexes) {
    if (index >= 0 && index < cartItems.length) {
      final item = cartItems[index];
      final cutPrice = double.tryParse(item["cutprice"].toString()) ?? 0.0;
      final originalPrice = double.tryParse(item["price"].toString()) ?? 0.0;
      final quantity = itemQuantities[index] ?? 1;
      final itemTotalPrice = originalPrice * quantity;
      // Savings per item = (cutPrice - originalPrice) * quantity
      double savingsPerItem = (cutPrice - itemTotalPrice).abs();
      totalSavings += savingsPerItem;
    }
  }
  return totalSavings;
}

 double getItemTotalPrice(int index) {
    final originalPrice = double.tryParse(cartItems[index]["price"].toString()) ?? 0;
    final quantity = itemQuantities[index] ?? 1;
    return originalPrice * quantity;
  }

  bool get isAllSelected => selectedCount == totalCount;

  void toggleAll(bool? value) {
    setState(() {
      if (value == true) {
        selectedIndexes = {for (int i = 0; i < totalCount; i++) i};
      } else {
        selectedIndexes.clear();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
       final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SHOPPING BAG",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.black54,
              size: 25,
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        
      ),

backgroundColor: Colors.white,
body:  cart.items.isEmpty
          ?Column(
            
           
            children: [
              SizedBox(height: 43,),
Center(
  child: Image.asset(
                  'assets/images/shopping-bag.png',
                  width: 120,
                  height: 140,
                ),
),
SizedBox(height: 30,),
Text("Hey, it feels so light!",
style: TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 17
),),
SizedBox(height: 2,),
Text("There is nothing in your bag.Let's add some items.",
style: TextStyle(
  color: Colors.black54,
  fontWeight: FontWeight.w400,
  fontSize: 13.5
),)

            ],
          )
          :
 SingleChildScrollView(
  child: Column(
    children: [
      const ShoppingProgressIndicator(currentStep: 0),
      Container(
        height: 12,
        color: const Color.fromARGB(255, 246, 244, 244),
      ),

      // Address Section
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 16, color: Colors.black87),
                      SizedBox(width: 4),
                      Text(
                        'Deliver to: ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Vadakkumkara House',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kerala 680662',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => _showChangeAddressSheet(context),
              child: const Text(
                'Change',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF3D57),
                ),
              ),
            ),
          ],
        ),
      ),

      Container(
        height: 15,
        color: const Color.fromARGB(255, 246, 244, 244),
      ),

      // Offers Section
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Logos and Offers Text
            Row(
              children: [
                ..._logos.map((logo) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(logo),
                    ),
                  ),
                )),
                const Spacer(),
                const Text(
                  "+12 Offers",
                  style: TextStyle(
                    color: Color(0xFFFF3D57),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right,
                    color: Color(0xFFFF3D57), size: 18),
              ],
            ),
            const SizedBox(height: 10),

            // Scrollable Cards
          Consumer<offersdb>(
    builder: (context, offerprovider, child) {
         final offerlists = offerprovider.bankoffer;
       
      return SizedBox(
              height: 61,
              child: 
                 PageView.builder(
                  controller: _pageController,
                  itemCount: offerlists.length,
                  onPageChanged: (index) {
                    setState(() {
            _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final offer = offerlists[index];
                    return SizedBox(
            width: MediaQuery.of(context).size.width * 1, 
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    offer["image1"],
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        SizedBox(height: 7),
                        Text(
                            offer["discount"] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        SizedBox(height: 3),
                        Text(
                          offer["bankdetails"] ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
                    );
                  },
                )
            
              );
    }
       
),
             SizedBox(height: 27),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(13, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 4.5,
                  height: 4.5,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.grey.shade800
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            const SizedBox(height: 7),
          ],
        ),
      ),

      Container(
        height: 12,
        color: const Color.fromARGB(255, 246, 244, 244),
      ),

      // Savings Banner
      if (selectedIndexes.isNotEmpty)
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFE6F4EA),
                Color(0xFFF3FAF5),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 8,
                child: Icon(
                  Icons.percent,
                  color: Colors.white,
                  size: 11,
                ),
              ),
              SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF202124),
                  ),
                  children: [
                    TextSpan(text: "You're saving "),
                    TextSpan(
                      text: '₹${_calculateTotalSavings().toInt()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.8,
                        color: Color(0xFF0F9D58),
                      ),
                    ),
                    TextSpan(
                        text: ' on this order',
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),

      // Selection Controls
      Container(
        padding: const EdgeInsets.only(right: 10),
        color: const Color.fromARGB(255, 246, 244, 244),
        child: Row(
          children: [
            Transform.scale(
              scale: 0.8,
              child: Checkbox(
                value: selectedIndexes.isNotEmpty,
                onChanged: (value) {
                  HapticFeedback.lightImpact();
                  setState(() {
                    if (value == true) {
                      selectedIndexes = {for (int i = 0; i < totalCount; i++) i};
                    } else {
                      selectedIndexes.clear();
                    }
                  });
                },
                activeColor: const Color(0xFFFF3D57),
              ),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "$selectedCount/$totalCount ITEMS SELECTED ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  if (selectedIndexes.isNotEmpty)
                    TextSpan(
                      text: "(₹${(selectedTotal.toInt() + (isDonationChecked ? selectedAmount : 0))})",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFFF3D57),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            const Icon(Icons.share_outlined, size: 18),
            const SizedBox(width: 22),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 18),
              onPressed: selectedIndexes.isNotEmpty
                  ? () {
                      _showRemoveSelectedItemsSheet(context);
                    }
                  : null,
              color: selectedIndexes.isNotEmpty ? null : Colors.grey,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 22),
            const Icon(Icons.favorite_border, size: 18),
          ],
        ),
      ),

      // Cart Items - Replace ListView with Column
      cart.items.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(50.0),
              child: Center(child: Text("Your cart is empty")),
            )
          : Column(
              children: [
                for (int index = 0; index < cart.items.length; index++) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Container(
                                  height: 162,
                                  width: 94,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(cart.items[index]['image']),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox(
                                      value: selectedIndexes.contains(index),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            selectedIndexes.add(index);
                                          } else {
                                            selectedIndexes.remove(index);
                                          }
                                        });
                                      },
                                      activeColor: const Color(0xFFFF3D57),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                       
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cart.items[index]["brand"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                    if (selectedIndexes.isEmpty)
                                  IconButton(
                                    icon: Icon(Icons.close, size: 16),
                                    onPressed: () {
                                      _showRemoveConfirmationSheet(
                                          context, index, cart.items[index]["image"]);
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                              Text(
                                cart.items[index]["title"],
                                style: TextStyle(height: 1.3, fontSize: 13),
                              ),
                              Text(
                                cart.items[index]["seller"],
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 6),
                              
                              // Size and Quantity controls
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1F0),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: _showSizeBottomSheet,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 242, 240, 240),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Size: $selectedSize",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            const Icon(Icons.keyboard_arrow_down,
                                                size: 14),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () => _showQtyBottomSheet(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 242, 240, 240),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                            "Qty: ${itemQuantities[index] ?? 1}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              
                              // Price section
                              Row(
                                children: [
                                  Text(
                                      "₹${((double.tryParse(cart.items[index]["price"].toString()) ?? 0) * (itemQuantities[index] ?? 1)).toInt()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 12)),
                                  SizedBox(width: 8),
                                  Text(
                                    cart.items[index]["cutprice"].toString(),
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF1F0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "${cart.items[index]["off"]} OFF",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 2),
                              
                              // Return policy
                              Row(
                                children: [
                                  Icon(Icons.share_arrival_time, size: 16),
                                  SizedBox(width: 4),
                                  Text.rich(
                                    TextSpan(
                                      text: '14 days ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 12),
                                      children: [
                                        TextSpan(
                                            text: 'return available',
                                            style: TextStyle(color: Colors.black38))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              
                              // Delivery info for selected items
                              if (selectedIndexes.contains(index))
                                const Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                                    SizedBox(width: 4),
                                    Text.rich(
                                      TextSpan(
                                        text: 'Delivery by ',
                                        style: TextStyle(fontSize: 12),
                                        children: [
                                          TextSpan(
                                            text: '21 Jun 2025',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Separator between items
                  if (index < cart.items.length - 1)
                    Container(
                      height: 8,
                      color: const Color.fromARGB(255, 246, 244, 244),
                    ),
                ],
              ],
            ),
      
      // Add some bottom padding to ensure content doesn't get cut off by bottom nav
     Container(
      height: 220,
           
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      
      color: Color.fromARGB(255, 237, 237, 255),
      child: Column(
        children: [
           if (selectedIndexes.isEmpty)
         Row(
           children: [
             Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("assets/images/Special-offer-PNG-HD.webp"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text('Unlock special deals ',
                      style: TextStyle(fontSize: 13.3, fontWeight: FontWeight.bold),),
                        Text('Add item worth ₹500',
                      style: TextStyle(fontSize: 13.3, fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 25, 25, 236) ),)
                                    ],
                                  )
           ],
         ),
         if (selectedIndexes.isNotEmpty)
            Row(
           children: [
             Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("assets/images/opened-gift-box-surprise-png.webp"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('special deals ',
                                                                style: TextStyle(fontSize: 13.3, fontWeight: FontWeight.bold),),
                                          Text('UNLOCKED',
                      style: TextStyle(fontSize: 13.3, fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 25, 25, 236) ),)                       
                                        ],
                                      ),
                        Text('Get a special deal on one of the below products.',
                      style: TextStyle(fontSize: 13.3,
                      color:Colors.grey),)
                                    ],
                                  )
           ],
         ),
         SizedBox(height: 22,),
        Expanded(
          child: Consumer<Dummydb>(
            builder: (context, productProvider, child) {
               final productList = productProvider.products;
   
            return ListView.separated(
                scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                 final product = productList[index];
              return Container(
              width: 250,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            Container(
              height: 76,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage( product["image"]),
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded( // 👈 Wrap Column in Expanded to prevent overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        product["brand"] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        ' set of 6',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  Text(
                     product["title"] ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        "₹${product["price"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "₹${product["cutprice"]}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "₹${product["rating"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.green,
                        size: 9,
                      ),
                      SizedBox(width: 7),
                      Text(
                        "₹${product["review"]}",
                        style: TextStyle(
                          // decoration: TextDecoration.lineThrough,
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                 
                ],
              ),
            ),
            
                    ],
                  ),
                  if (selectedIndexes.isEmpty)
                   Container(
                width: double.infinity, // 👈 Take full width inside Expanded
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 👈 Center content
                  children: [
                    Icon(Icons.shopping_bag, size: 16, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(
                      "Add to Bag",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            if (selectedIndexes.isNotEmpty)
              InkWell(
                onTap: () {
                        Provider.of<CartProvider>(context, listen: false).addItem(product);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Added to bag")),
  );
                },
                child: Container(
                  width: double.infinity, // 👈 Take full width inside Expanded
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 👈 Center content
                    children: [
                      Icon(Icons.shopping_bag, size: 16, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        "Add to Bag",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
                ],
              ),
            );
            
            }, separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ), itemCount: productList.length);
                  },
          ),
        )
        ],
      ),
          
     ),
   
      Container(
        padding: EdgeInsets.all(10),
        height: 42,
        color: const Color.fromARGB(255, 246, 244, 244),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
       
          children: [
            Center(child: Text("COUPONS",style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 12
            ),)),
          ],
        ),
      ),
        Container(
        padding: EdgeInsets.all(10),
        height: 46,
        color: Colors.white,
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
     
          children: [
            Icon(Icons.tag,size: 15,),
            SizedBox(width: 5,),
            Text("Apply Coupon",style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13.1
            ),),
            Spacer(),
            Icon(Icons.keyboard_arrow_right,
            color: Colors.black,size: 20,)
          ],
        ),
      ),
         Container(
        padding: EdgeInsets.all(10),
        height: 42,
        color: const Color.fromARGB(255, 246, 244, 244),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
       
          children: [
            Center(child: Text("GIFTING & PERSONALISATION",style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 12
            ),)),
          ],
        ),
      ),
        Container(
        padding: EdgeInsets.all(10),
        height: 95,
        color: Colors.white,
        child: Row(
       
     
          children: [
          Container(
            padding: EdgeInsets.only(left: 28,right: 28),
            width: 310,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 252, 213, 212)
            ),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 10,
                  color: const Color.fromARGB(255, 249, 100, 89),
                ),
                SizedBox(width: 15,),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Buying for a loved one?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600
                    ),),
                     Text("gift packing and personalized ",maxLines: 2,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12.5,
                      // fontWeight: FontWeight.w600
                    ),),
                        Text("message on card, only for 35",maxLines: 2,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12.5,
                      // fontWeight: FontWeight.w600
                    ),)
                  ],
                )
              ],
            ),
          ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right,
            color: Colors.black,size: 20,)
          ],
        ),
      ),
       Container(
        padding: EdgeInsets.all(10),
        height: 42,
        color: const Color.fromARGB(255, 246, 244, 244),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
       
          children: [
            Center(child: Text("SUPPORT TRANSFORMATIVE SOCIAL WORK IN INDIA",style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 12
            ),)),
          ],
        ),
      ),
 Container(
          padding: EdgeInsets.only(right: 8),
          color: Colors.white,
          height: 110,
          child: Column(
            children: [
              Row(
                children: [
                  
                    Checkbox(
                      value: isDonationChecked,
                      onChanged: (value) {
                        HapticFeedback.lightImpact(); // ✅ haptic
                        setState(() {
                          isDonationChecked = value!;
                          selectedAmount = 10;
                        });
                      },
                      activeColor: const Color(0xFFFF3D57),
                    ),
                  
                  Text(
                    "Donate and make a difference",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.1),
                  ),
                  Spacer(),
                  Text(
                    "know more",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.1),
                  ),
                ],
              ),
              Row(
                children: donationOptions.map((amount) {
                  final isSelected =
                      isDonationChecked && amount == selectedAmount;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: GestureDetector(
                      onTap: () {
                        if (isDonationChecked) {
                          HapticFeedback.lightImpact(); // ✅ haptic
                          setState(() {
                            selectedAmount = amount;
                          });
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isSelected ? Colors.red : Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "$amount",
                            style: TextStyle(
                              color: isSelected ? Colors.red : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),

         Container(
        height: 18,
        color: const Color.fromARGB(255, 246, 244, 244),
      ),
     Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PRICE DETAILS ($selectedCount Item${selectedCount != 1 ? 's' : ''})",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              Divider(height: 24, thickness: 1, color: Colors.black12),
              SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total MRP", style: TextStyle(fontSize: 14)),
                  Text("₹${_calculateTotalMRP().toInt()}", style: TextStyle(fontSize: 14)),
                ],
              ),
               if (selectedIndexes.isNotEmpty)
              SizedBox(height: 8),
              if (selectedIndexes.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discount on MRP", style: TextStyle(fontSize: 14)),
                  Text("- ₹${_calculateTotalSavings().toInt()}",
                      style: TextStyle(fontSize: 14, color: Colors.green)),
                ],
              ),
              SizedBox(height: 8),
              if (selectedIndexes.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Coupon Discount", style: TextStyle(fontSize: 14)),
                  Text("Apply Coupon",
                      style: TextStyle(fontSize: 14, color: Colors.pink)),
                ],
              ),
              if (selectedIndexes.isNotEmpty)
              SizedBox(height: 8),

              /// Visible only when checkbox is checked
              if (isDonationChecked)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Social Work Donation", style: TextStyle(fontSize: 14)),
                    Text("₹$selectedAmount", style: TextStyle(fontSize: 14)),
                  ],
                ),
              if (isDonationChecked) SizedBox(height: 8),
            if (selectedIndexes.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Platform Fee", style: TextStyle(fontSize: 14)),
                      SizedBox(width: 4),
                      Text("Know More",
                          style: TextStyle(fontSize: 14, color: Colors.pink)),
                    ],
                  ),
                  Text("₹20", style: TextStyle(fontSize: 14)),
                ],
              ),
              
              Divider(height: 24, thickness: 1, color: Colors.black12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "₹${(selectedTotal.toInt() + (isDonationChecked ? selectedAmount : 0))}", // You can update this dynamically if needed
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
  color: const Color.fromARGB(255, 246, 244, 244), // Light grey background
  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
  
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.verified_outlined, size: 30, color: Colors.black54),
              SizedBox(height: 6),
              Text(
                "Genuine Products",
                style: TextStyle(fontSize: 11.5, color: Colors.black54),
              )
            ],
          ),
          Text("•", style: TextStyle(fontSize: 18, color: Colors.black45)),
          Column(
            children: [
              Icon(Icons.social_distance, size: 30, color: Colors.black54),
              SizedBox(height: 6),
              Text(
                "Contactless Delivery",
                style: TextStyle(fontSize: 11.5, color: Colors.black54),
              )
            ],
          ),
          Text("•", style: TextStyle(fontSize: 18, color: Colors.black45)),
          Column(
            children: [
              Icon(Icons.security, size: 30, color: Colors.black54),
              SizedBox(height: 6),
              Text(
                "Secure Payments",
                style: TextStyle(fontSize: 11.5, color: Colors.black54),
              )
            ],
          ),
        ],
      ),
      SizedBox(height: 17),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: 13, color: const Color.fromARGB(255, 41, 41, 41)),
            children: [
              TextSpan(text: "By placing the order, you agree to Myntra's "),
              TextSpan(
                text: "Terms of Use",
                style: TextStyle(
                    color: Colors.pink, fontWeight: FontWeight.bold),
              ),
              TextSpan(text: " and "),
              TextSpan(
                text: "Privacy Policy",
                style: TextStyle(
                    color: Colors.pink, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)


    ],
  ),
),

 bottomNavigationBar: 
 cart.items.isEmpty?SizedBox():
 Container(
  padding: const EdgeInsets.only(left: 16,right: 16,bottom: 12, ),
  decoration: BoxDecoration(
    color: const Color(0xFFFFF5F5), // soft pinkish-white background
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 5,
        offset: const Offset(0, -2),
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Top Text: 1 Item selected for ordersi
      
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 25,
          width: double.infinity,
        
          child: Center(
            child: Text(
               '$selectedCount Item${selectedCount != 1 ? 's' : ''} selected for order',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: Color(0xFF1C1C1C), // dark text color
              ),
            ),
          ),
        ),
      ),

      // Place Order Button
      SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: () {
         
              final totalMRP = _calculateTotalMRP();
            final discountMRP = _calculateDiscountMRP();
            final totalAmount = _calculateTotalAmount();
            final itemCount = selectedCount;
            final selectedItemImages = _getSelectedItemImages();

              // Collect additional product data for selected items
              List<Map<String, dynamic>> selectedProducts = selectedIndexes
                  .where((index) => index >= 0 && index < cartItems.length)
                  .map((index) => {
                        "price": cartItems[index]["price"] ?? 0.0,
                        "rating": cartItems[index]["rating"] ?? 0.0,
                        "brand": cartItems[index]["brand"] ?? "",
                        "title": cartItems[index]["title"] ?? "",
                      })
                  .toList();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Addresspage(
                  totalMRP: totalMRP,
                  discountMRP: discountMRP,
                  totalAmount: totalAmount,
                  itemCount: itemCount,
                  selectedItemImages: selectedItemImages,
                  selectedProducts: selectedProducts, 
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF3D57), // vibrant pink-red
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          child: const Text(
            'PLACE ORDER',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
      SizedBox(height: 13,)
    ],
  ),
),

    
    );
  }
void _showChangeAddressSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
               Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
               Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
      'Select Delivery Location',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    IconButton(
      onPressed: () {
        Navigator.pop(context); // closes bottom sheet
      },
      icon: const Icon(Icons.close),
    ),
  ],
),
                const SizedBox(height: 16),

                // Selected Location Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text.rich(
                              TextSpan(
                                text: 'Selected Location - ',
                                children: [
                                  TextSpan(
                                    text: 'Vadakkumkara',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Kerala 680662',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Change',
                        style: TextStyle(
                          color: Color(0xFFFF3D57),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Pincode Input + Check Pincode
                Row(
                  children: [
                    Expanded(
                      child:Container(
                        height: 50,
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey.shade300),
  
  ),
  child: Row(
    children: [
      // Pincode Text
      const Expanded(
        child: Text(
          '680662',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // Check Pincode Button
      TextButton(
        onPressed: () {
          // Add your logic here
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFF3D57), // pink color
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Check Pincode',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
)

                    )
                  ],
                ),
                const SizedBox(height: 16),

                // Use my current location
                GestureDetector(
                  onTap: () {
                    // TODO: Use current location logic
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.my_location, color: Color(0xFFFF3D57)),
                      SizedBox(width: 6),
                      Text(
                        'Use my current Location',
                        style: TextStyle(
                          color: Color(0xFFFF3D57),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Divider with OR
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    SizedBox(width: 6),
                    Text("Or",
                    style: TextStyle(color: Colors.black
                    ,fontWeight: FontWeight.bold,
                    fontSize: 16),),
                    SizedBox(width: 6),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 10),

                // Saved Address Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Select Saved Address',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      'Add New',
                      style: TextStyle(
                          color: Color(0xFFFF3D57), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Saved Addresses
                ...[
                  {
                    "name": "user",
                    "pincode": "680662",
                    "address":
                        " house, Irinjalakuda, vellangallur, Vadakkumkara, Kerala"
                  },
                  {
                    "name": "user2",
                    "pincode": "680662",
                    "address":
                        "Vellangallur, apple bazar, Vellangallur, Thrissur, Kerala"
                  }
                ].map(
                  (addr) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${addr["name"]}, ${addr["pincode"]}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              
                           
                              Text(
                                addr["address"]!,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.check_circle_outline)
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Add New Address - Centered full-width button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Add new address screen
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Add New Address",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCCCCCC)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            ]
          );
        },
      );
    },
  );
}



  void _showSizeBottomSheet() {
    String tempSelectedSize = selectedSize;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Select Size",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    children: sizes.map((size) {
                      bool isDisabled = size == "38" || size == "46";
                      bool isSelected = tempSelectedSize == size;

                      return GestureDetector(
                        onTap: isDisabled
                            ? null
                            : () {
                                setModalState(() {
                                  tempSelectedSize = size;
                                });
                              },
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDisabled
                                  ? Colors.grey.shade400
                                  : isSelected
                                      ? Colors.pink
                                      : Colors.black54,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: isDisabled ? Colors.grey : Colors.black,
                              fontWeight:
                                  isSelected ? FontWeight.bold : FontWeight.normal,
                              decoration: isDisabled
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text.rich(
                    TextSpan(
                      text: "₹896  ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: "₹2,240",
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: " (60% OFF)",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text.rich(
                    TextSpan(
                      text: "Seller: ",
                      children: [
                        TextSpan(
                          text: "Juvenca Online Private Limited",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3D57),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedSize = tempSelectedSize;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("DONE", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showQtyBottomSheet(int index) {
  int tempQty = itemQuantities[index] ?? 1; // Use the current quantity for the item

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(builder: (context, setModalState) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Quantity",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                children: List.generate(4, (i) {
                  int qty = i + 1;
                  bool isSelected = tempQty == qty;

                  return GestureDetector(
                    onTap: () {
                      setModalState(() {
                        tempQty = qty;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.pink : Colors.black54,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "$qty",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.pink : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3D57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    setState(() {
                      itemQuantities[index] = tempQty; // Update the quantity for the specific item
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "DONE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      });
    },
  );
}

void _showRemoveConfirmationSheet(BuildContext context, int index, String imagePath) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8                                                                                                                                                   ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            // Image and Text Layout
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image (matching the screenshot's style)
                ClipRRect(
                  
                  child: Image.asset(
                    imagePath,
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Move from Bag",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                icon: const Icon(Icons.close, size: 20, color: Colors.black),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
                        ],
                      ),
                    
                      const Text(
                        "Are you sure you want to move this item from bag?",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          // textAlign: TextAlign.center,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Remove the item from cart
                      final cart = Provider.of<CartProvider>(context, listen: false);
                      cart.removeItem(cart.items[index]["id"]);
                      setState(() {
                        selectedIndexes.remove(index);
                        itemQuantities.remove(index);
                        itemQuantities = itemQuantities.map((key, value) {
                          if (key > index) return MapEntry(key - 1, value);
                          return MapEntry(key, value);
                        });
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("REMOVE"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Dummy button - no action
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3D57),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("MOVE TO WISHLIST"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // Add padding at the bottom
          ],
        ),
      );
    },


    
  );
}


void _showRemoveSelectedItemsSheet(BuildContext context) {
  final int selectedCount = selectedIndexes.length;
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.only(left: 20,right: 10, top: 8,bottom: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close Button at Top Right
           
            // Text Content
            Column(
            
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Remove $selectedCount items",
                      style: const TextStyle(
                        fontSize: 13.2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                     IconButton(
                icon: const Icon(Icons.close, size: 16, color: Colors.black),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
                  ],
                ),
            
                Text(
                  "Are you sure you want to remove $selectedCount items from bag?",
                  style: const TextStyle(
                    fontSize: 13.2,
                    color: Colors.black54,
                  
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Remove selected items from cart
                      final cart = Provider.of<CartProvider>(context, listen: false);
                      // Remove items in reverse order to avoid index issues
                      List<int> indicesToRemove = selectedIndexes.toList()..sort((a, b) => b.compareTo(a));
                      for (int index in indicesToRemove) {
                        if (index >= 0 && index < cart.items.length) {
                          cart.removeItem(cart.items[index]["id"]);
                        }
                      }
                      setState(() {
                        selectedIndexes.clear();
                        itemQuantities.clear(); // Reset quantities
                        // Reinitialize quantities if cart is not empty
                        for (int i = 0; i < cart.items.length; i++) {
                          itemQuantities[i] = 1;
                        }
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("REMOVE"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Dummy button - no action
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3D57),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("MOVE TO WISHLIST"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
}