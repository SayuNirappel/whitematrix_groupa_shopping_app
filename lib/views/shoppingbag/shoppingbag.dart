import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/cartcontroller.dart';
import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/orders.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/addresspage.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/couponscreen.dart';

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
                        value: widget.currentStep >= 1
                            ? 1.0
                            : (widget.currentStep >= 0
                                ? _progressAnimation.value
                                : 0.0),
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF26A69A)),
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
                            ? const Color(
                                0xFF26A69A) // Green background when step >= 1
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
                        value: widget.currentStep >= 2
                            ? 1.0
                            : (widget.currentStep >= 1
                                ? _progressAnimation.value
                                : 0.0),
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF26A69A)),
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
                      ? const Color(
                          0xFF26A69A) // Green background when step >= 1
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
              fontWeight:
                  widget.currentStep == 1 ? FontWeight.bold : FontWeight.normal,
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
                        value: widget.currentStep >= 3
                            ? 1.0
                            : (widget.currentStep >= 2
                                ? _progressAnimation.value
                                : 0.0),
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF26A69A)),
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
                    border: Border.all(
                      color: widget.currentStep >= 2
                          ? const Color(0xFF26A69A)
                          : Colors.grey.shade300,
                    )),
              ),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade300),
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
              fontWeight:
                  widget.currentStep == 2 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class Shoppingbag2 extends StatefulWidget {
  final String userIdddd;
  final String BearerToken;

  const Shoppingbag2(
      {super.key, required this.userIdddd, required this.BearerToken});

  @override
  State<Shoppingbag2> createState() => _Shoppingbag2State();
}

class _Shoppingbag2State extends State<Shoppingbag2> {
  List<String> _getSelectedItemImages() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return selectedIndexes
        .where((index) => index >= 0 && index < cartProvider.cartItems.length)
        .map(
            (index) => cartProvider.cartItems[index]["image"]?.toString() ?? '')
        .toList();
  }

  Map<String, dynamic>? selectedAddress;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();

  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController landmarkcontroller = TextEditingController();
  final TextEditingController alternatePhoneController =
      TextEditingController();

  String selectedFullNamePincode = 'customer B';
  String selectedLocalityCityState = 'Kerala 680662';
  double couponDiscount = 0.0;
  Set<int> selectedIndexes = {};
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);
  bool isDonationChecked = false;
  int selectedAmount = 10;
  final List<int> donationOptions = [10, 20, 50, 100];

  final List<String> _logos = [
    'assets/images/HDFC_Bank_(1).png',
    'assets/images/HDFC_Bank_(1).png',
    'assets/images/Paytm_(3).png',
    'assets/images/Myntra_logo_PNG_(1).png',
  ];

  @override
  void initState() {
    super.initState();
    selectedAddress = {
      'fullName': 'customer',
      'pincode': '680662',
      'locality': 'vellangallur',
      'city': 'irinjalakuda',
      'state': 'Kerala',
      'mobile': '1234567895',
      'address': 'houseee',
      'landmark': 'near.....',
      'alternatePhone': '7356556028',
      'addressType': 'Home',
    };
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CartProvider>().fetchCartItems(widget.userIdddd);
      await context.read<CartProvider>().fetchUserAddresses(
            userId: widget.userIdddd,
            token: widget.BearerToken,
          );
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    pincodeController.dispose();
    localityController.dispose();
    cityController.dispose();
    stateController.dispose();
    alternatePhoneController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  int get totalCount => context.read<CartProvider>().cartItems.length;
  int get selectedCount => selectedIndexes.length;
  double get selectedTotal {
    final cartItems = context.read<CartProvider>().cartItems;
    return selectedIndexes.fold(0.0, (sum, index) {
      final item = cartItems[index];
      return sum + (item['finalPrice'] ?? 0.0) * (item['quantity'] ?? 1);
    });
  }

  double _calculateTotalMRP() {
    final cartItems = context.read<CartProvider>().cartItems;
    return selectedIndexes.fold(0.0, (sum, index) {
      final item = cartItems[index];
      return sum + (item['originalPrice'] ?? 0.0) * (item['quantity'] ?? 1);
    });
  }

  double _calculateDiscountMRP() {
    return _calculateTotalSavings();
  }

  double _calculateTotalSavings() {
    final cartItems = context.read<CartProvider>().cartItems;
    return selectedIndexes.fold(0.0, (sum, index) {
      final item = cartItems[index];
      final originalPrice =
          (item['originalPrice'] ?? 0.0) * (item['quantity'] ?? 1);
      final finalPrice = (item['finalPrice'] ?? 0.0) * (item['quantity'] ?? 1);
      return sum + (originalPrice - finalPrice);
    });
  }

  double _calculateTotalAmount() {
    // Include coupon discount in total calculation
    return selectedTotal +
        (isDonationChecked ? selectedAmount : 0) +
        (selectedIndexes.isNotEmpty ? 20 : 0) -
        couponDiscount; // Subtract coupon discount
  }

  @override
  Widget build(BuildContext context) {
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
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Orders(),
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(13)),
              child: Text(
                "Orders",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: context.watch<CartProvider>().cartItems.isEmpty
          ? Consumer<CartProvider>(
              builder: (context, value, child) => value.productiloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 43,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/shopping-bag.png',
                            width: 120,
                            height: 140,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Hey, it feels so light!",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "There is nothing in your bag.Let's add some items.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.5),
                        )
                      ],
                    ),
            )
          : Consumer<CartProvider>(
              builder: (context, value, child) => value.productiloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ShoppingProgressIndicator(currentStep: 0),
                          Container(
                            height: 12,
                            color: const Color.fromARGB(255, 246, 244, 244),
                          ),
                          // Address Section
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on_outlined,
                                              size: 16, color: Colors.black87),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'Deliver to: ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87),
                                          ),
                                          Flexible(
                                            child: Text(
                                              selectedAddress != null
                                                  ? '${selectedAddress!['fullName']}, ${selectedAddress!['pincode']}'
                                                  : 'Select an address',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        selectedAddress != null
                                            ? '${selectedAddress!['locality']}, ${selectedAddress!['city']}, ${selectedAddress!['state']}'
                                            : '',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => _showChangeAddressSheet(
                                    context,
                                    widget.BearerToken,
                                    widget.userIdddd,
                                    (selectedAddress) {
                                      setState(() {
                                        this.selectedAddress =
                                            Map<String, dynamic>.from(
                                                selectedAddress);
                                        selectedFullNamePincode =
                                            '${selectedAddress['fullName']}, ${selectedAddress['pincode']}';
                                        selectedLocalityCityState =
                                            '${selectedAddress['locality']}, ${selectedAddress['city']}, ${selectedAddress['state']}';
                                      });
                                    },
                                  ),
                                  child: const Text(
                                    'Change',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF3D57)),
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
                                Row(
                                  children: [
                                    ..._logos.map((logo) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
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
                                SizedBox(
                                  height: 61,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: _logos.length,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              _logos[index],
                                              width: 30,
                                              height: 30,
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  SizedBox(height: 7),
                                                  Text(
                                                    "10% OFF",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(height: 3),
                                                  Text(
                                                    "Use HDFC Bank Card",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 27),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      List.generate(_logos.length, (index) {
                                    return AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: 4.5,
                                      height: 4.5,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
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
                          if (selectedIndexes.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 11),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFE6F4EA),
                                    Color(0xFFF3FAF5)
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
                                    child: Icon(Icons.percent,
                                        color: Colors.white, size: 11),
                                  ),
                                  SizedBox(width: 8),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF202124)),
                                      children: [
                                        TextSpan(text: "You're saving "),
                                        TextSpan(
                                          text:
                                              '₹${_calculateTotalSavings().toInt()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.8,
                                            color: Color(0xFF0F9D58),
                                          ),
                                        ),
                                        TextSpan(text: ' on this order'),
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
                                          selectedIndexes = {
                                            for (int i = 0; i < totalCount; i++)
                                              i
                                          };
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
                                        text:
                                            "$selectedCount/$totalCount ITEMS SELECTED ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                      if (selectedIndexes.isNotEmpty)
                                        TextSpan(
                                          text:
                                              "(₹${_calculateTotalAmount().toInt()})",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFFFF3D57),
                                              fontWeight: FontWeight.bold),
                                        ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.share_outlined, size: 18),
                                const SizedBox(width: 22),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      size: 18),
                                  onPressed: selectedIndexes.isNotEmpty
                                      ? () =>
                                          _showRemoveSelectedItemsSheet(context)
                                      : null,
                                  color: selectedIndexes.isNotEmpty
                                      ? null
                                      : Colors.grey,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const SizedBox(width: 22),
                                const Icon(Icons.favorite_border, size: 18),
                              ],
                            ),
                          ),
                          // Cart Items List
                          Consumer<CartProvider>(
                            builder: (context, cartProvider, child) {
                              final cartItems = cartProvider.cartItems;

                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  final item = cartItems[index];
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Stack(
                                              alignment: Alignment.topLeft,
                                              children: [
                                                Container(
                                                  height: 162,
                                                  width: 94,
                                                  child: Image.network(
                                                    item['image'] ??
                                                        '', // Use the image URL directly from the API
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null)
                                                        return child; // Image loaded successfully
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  (loadingProgress
                                                                          .expectedTotalBytes ??
                                                                      1)
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/images/img1.jpg', // Fallback asset image
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Container(
                                                            color: Colors
                                                                .grey.shade200,
                                                            child: Center(
                                                              child: Text(
                                                                'Image\nNot Found',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                  child: Transform.scale(
                                                    scale: 0.8,
                                                    child: Checkbox(
                                                      value: selectedIndexes
                                                          .contains(index),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (value == true) {
                                                            selectedIndexes
                                                                .add(index);
                                                          } else {
                                                            selectedIndexes
                                                                .remove(index);
                                                          }
                                                        });
                                                      },
                                                      activeColor: const Color(
                                                          0xFFFF3D57),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    item['brand'] ??
                                                        'Unknown Brand',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  if (selectedIndexes.isEmpty)
                                                    IconButton(
                                                      icon: Icon(Icons.close,
                                                          size: 16),
                                                      onPressed: () {
                                                        _showRemoveConfirmationSheet(
                                                            context,
                                                            index,
                                                            item);
                                                      },
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          const BoxConstraints(),
                                                    ),
                                                ],
                                              ),
                                              Text(
                                                item['productTitle'] ??
                                                    'Unknown Title',
                                                style: TextStyle(
                                                    height: 1.3, fontSize: 13),
                                              ),
                                              Text(
                                                'Sold by StyleWear',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(height: 6),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFFF1F0),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () =>
                                                          _showSizeBottomSheet(
                                                              index, item),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              242, 240, 240),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "Size: ${item['size'] ?? 'M'}",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12),
                                                            ),
                                                            const Icon(
                                                                Icons
                                                                    .keyboard_arrow_down,
                                                                size: 14),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    InkWell(
                                                      onTap: () =>
                                                          _showQtyBottomSheet(
                                                              index, item),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              242, 240, 240),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Text(
                                                          "Qty: ${item['quantity'] ?? 1}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Text(
                                                    "₹${item['finalPrice'] ?? '0'}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    "₹${item['originalPrice'] ?? '0'}",
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFFFF1F0)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "${item['applicableDiscount']?['value'] ?? 0}% OFF",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  Icon(Icons.share_arrival_time,
                                                      size: 16),
                                                  SizedBox(width: 4),
                                                  Text.rich(
                                                    TextSpan(
                                                      text: '14 days ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                'return available',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black38)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              if (selectedIndexes
                                                  .contains(index))
                                                const Row(
                                                  children: [
                                                    Icon(Icons.check_circle,
                                                        color: Colors.green,
                                                        size: 16),
                                                    SizedBox(width: 4),
                                                    Text.rich(
                                                      TextSpan(
                                                        text:
                                                            'Delivery within ',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        children: [
                                                          TextSpan(
                                                            text: '1 day',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
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
                                  );
                                },
                                separatorBuilder: (context, index) => Container(
                                  height: 8,
                                  color:
                                      const Color.fromARGB(255, 246, 244, 244),
                                ),
                              );
                            },
                          ),

                          Container(
                            padding: EdgeInsets.all(10),
                            height: 42,
                            color: const Color.fromARGB(255, 246, 244, 244),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "COUPONS",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (selectedIndexes.isEmpty) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Select at least one item in bag to Apply coupon"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Couponscreen(
                                          userId: widget.userIdddd,
                                          cartTotal: _calculateTotalAmount() +
                                              couponDiscount)),
                                ).then((result) {
                                  if (result != null &&
                                      result is Map &&
                                      result.containsKey('discount')) {
                                    setState(() {
                                      couponDiscount =
                                          result['discount'] ?? 0.0;
                                    });
                                  }
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 46,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Icon(Icons.tag, size: 15),
                                  SizedBox(width: 5),
                                  Text(
                                    "Apply Coupon",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.1,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.keyboard_arrow_right,
                                      color: Colors.black, size: 20)
                                ],
                              ),
                            ),
                          ),

                          if (couponDiscount > 0)
                            Container(
                              padding: EdgeInsets.all(14),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.greenAccent),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Saved ₹${couponDiscount.toInt()}",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        couponDiscount =
                                            0.0; // Reset coupon discount
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Coupon removed"),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      });
                                    },
                                    child: Text(
                                      "remove",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
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
                                Center(
                                  child: Text(
                                    "GIFTING & PERSONALISATION",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
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
                                  padding: EdgeInsets.only(left: 28, right: 28),
                                  width: 310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color.fromARGB(
                                        255, 252, 213, 212),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 10,
                                        color: const Color.fromARGB(
                                            255, 249, 100, 89),
                                      ),
                                      SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          Text(
                                            "Buying for a loved one?",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Gift packing and personalized ",
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 12.5),
                                          ),
                                          Text(
                                            "message on card, only for ₹35",
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 12.5),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.keyboard_arrow_right,
                                    color: Colors.black, size: 20)
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
                                Center(
                                  child: Text(
                                    "SUPPORT TRANSFORMATIVE SOCIAL WORK IN INDIA",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
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
                                        HapticFeedback.lightImpact();
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
                                    final isSelected = isDonationChecked &&
                                        amount == selectedAmount;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (isDonationChecked) {
                                            HapticFeedback.lightImpact();
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
                                              color: isSelected
                                                  ? Colors.red
                                                  : Colors.grey.shade400,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "$amount",
                                              style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.red
                                                      : Colors.black),
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
                                Divider(
                                    height: 24,
                                    thickness: 1,
                                    color: Colors.black12),
                                SizedBox(height: 7),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total MRP",
                                        style: TextStyle(fontSize: 14)),
                                    Text("₹${_calculateTotalMRP().toInt()}",
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                if (selectedIndexes.isNotEmpty)
                                  SizedBox(height: 8),
                                if (selectedIndexes.isNotEmpty)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Discount on MRP",
                                          style: TextStyle(fontSize: 14)),
                                      Text(
                                        "- ₹${_calculateTotalSavings().toInt()}",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.green),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 8),
                                if (selectedIndexes.isNotEmpty)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Coupon Discount",
                                          style: TextStyle(fontSize: 14)),
                                      Text(
                                        couponDiscount > 0
                                            ? "- ₹${couponDiscount.toInt()}"
                                            : "Apply Coupon",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.pink),
                                      ),
                                    ],
                                  ),
                                if (selectedIndexes.isNotEmpty)
                                  SizedBox(height: 8),
                                if (isDonationChecked)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Social Work Donation",
                                          style: TextStyle(fontSize: 14)),
                                      Text("₹$selectedAmount",
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                if (isDonationChecked) SizedBox(height: 8),
                                if (selectedIndexes.isNotEmpty)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Platform Fee",
                                              style: TextStyle(fontSize: 14)),
                                          SizedBox(width: 4),
                                          Text("Know More",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.pink)),
                                        ],
                                      ),
                                      Text("₹20",
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                Divider(
                                    height: 24,
                                    thickness: 1,
                                    color: Colors.black12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "₹${_calculateTotalAmount().toInt()}",
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
                            color: const Color.fromARGB(255, 246, 244, 244),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(Icons.verified_outlined,
                                            size: 30, color: Colors.black54),
                                        SizedBox(height: 6),
                                        Text(
                                          "Genuine Products",
                                          style: TextStyle(
                                              fontSize: 11.5,
                                              color: Colors.black54),
                                        )
                                      ],
                                    ),
                                    Text("•",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45)),
                                    Column(
                                      children: [
                                        Icon(Icons.social_distance,
                                            size: 30, color: Colors.black54),
                                        SizedBox(height: 6),
                                        Text(
                                          "Contactless Delivery",
                                          style: TextStyle(
                                              fontSize: 11.5,
                                              color: Colors.black54),
                                        )
                                      ],
                                    ),
                                    Text("•",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45)),
                                    Column(
                                      children: [
                                        Icon(Icons.security,
                                            size: 30, color: Colors.black54),
                                        SizedBox(height: 6),
                                        Text(
                                          "Secure Payments",
                                          style: TextStyle(
                                              fontSize: 11.5,
                                              color: Colors.black54),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 17),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: const Color.fromARGB(
                                              255, 41, 41, 41)),
                                      children: [
                                        TextSpan(
                                            text:
                                                "By placing the order, you agree to Myntra's "),
                                        TextSpan(
                                          text: "Terms of Use",
                                          style: TextStyle(
                                              color: Colors.pink,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: " and "),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          style: TextStyle(
                                              color: Colors.pink,
                                              fontWeight: FontWeight.bold),
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
            ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.cartItems;
          if (cartItems.isEmpty) {
            return SizedBox();
          }
          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5F5),
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
                          color: Color(0xFF1C1C1C),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      final totalMRP = _calculateTotalMRP();
                      final discountMRP = _calculateDiscountMRP();
                      final totalAmount = _calculateTotalAmount();
                      final selectedItemImages = _getSelectedItemImages();
                      final itemCount = selectedCount;

                      List<Map<String, dynamic>> selectedItems = selectedIndexes
                          .where(
                              (index) => index >= 0 && index < cartItems.length)
                          .map((index) => {
                                "productId":
                                    cartItems[index]["productId"] as String,
                                "quantity": cartItems[index]["quantity"] ?? 1,
                                "variantSKU":
                                    cartItems[index]["variantSKU"] as String,
                                "price": cartItems[index]["finalPrice"] ?? 0.0,
                              })
                          .toList();

                      if (selectedIndexes.isEmpty) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Select at least one item in bag to place order"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (selectedAddress == null) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select a delivery address"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else if (selectedAddress == null) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select a delivery address"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddressPage(
                              userId: widget.userIdddd,
                              bearerToken: widget.BearerToken,
                              selectedItems: selectedItems,
                              cartTotal: totalAmount,
                              itemCount: itemCount,
                              totalMRP: totalMRP,
                              discountMRP: discountMRP,
                              selectedAddress: selectedAddress!,
                              selectedItemImages: selectedItemImages,
                            ),
                          ),
                        ).then((_) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3D57),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                SizedBox(height: 13),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showChangeAddressSheet(BuildContext context, String token,
      String userId, Function(Map<String, dynamic>)? onAddressSelected) {
    // Controllers for text fields

    // State for managing selected address and checkbox states
    List<Map<String, dynamic>> savedAddresses = [];
    List<bool> isSelected = [];
    int? selectedIndex;
    bool isLoading = true; //

    // Fetch saved addresses and update sta

    void _fetchAddresses(StateSetter setModalState) async {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      savedAddresses = await cartProvider.fetchUserAddresses(
        userId: userId,
        token: token,
      );
      isSelected = List<bool>.filled(savedAddresses.length, false);
      setModalState(() {
        isLoading = false; // Update loading state
      });
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            if (isLoading) {
              _fetchAddresses(setModalState);
            }
            return DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              expand: false,
              builder: (_, controller) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: isLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator()) // Show loading indicator
                    : ListView(
                        controller: controller,
                        children: [
                          const Text(
                            'Saved Addresses',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Container for saved addresses
                          if (savedAddresses.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: savedAddresses.length,
                              itemBuilder: (context, index) {
                                final address = savedAddresses[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: isSelected[index]
                                          ? Colors.red
                                          : Colors.grey.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          size: 16, color: Colors.black87),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${address['fullName']}, ${address['pincode']}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  address['addressType'],
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${address['locality']}, ${address['city']}, ${address['state']}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Mob: ${address['mobile']}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Checkbox(
                                            value: isSelected[index],
                                            onChanged: (value) {
                                              setModalState(() {
                                                for (int i = 0;
                                                    i < isSelected.length;
                                                    i++) {
                                                  isSelected[i] =
                                                      i == index && value!;
                                                }
                                                selectedIndex =
                                                    value! ? index : null;
                                              });
                                            },
                                          ),
                                          if (isSelected[index])
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedAddress =
                                                      Map<String, dynamic>.from(
                                                          address);
                                                  selectedFullNamePincode =
                                                      '${address['fullName']}, ${address['pincode']}';
                                                  selectedLocalityCityState =
                                                      '${address['locality']}, ${address['city']}, ${address['state']}';
                                                });
                                                if (onAddressSelected != null) {
                                                  onAddressSelected(address);
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Deliver Here'),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          if (savedAddresses.isEmpty)
                            const Text(
                              'No saved addresses found.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          const SizedBox(height: 16),
                          // OR separator
                          const Center(
                            child: Text(
                              'OR',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // New Address Section
                          const Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: mobileController,
                            decoration: const InputDecoration(
                              labelText: 'Mobile',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: pincodeController,
                            decoration: const InputDecoration(
                              labelText: 'Pincode',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: localityController,
                            decoration: const InputDecoration(
                              labelText: 'Locality',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: addresscontroller,
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: cityController,
                            decoration: const InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: stateController,
                            decoration: const InputDecoration(
                              labelText: 'State',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: landmarkcontroller,
                            decoration: const InputDecoration(
                              labelText: 'landmark',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: alternatePhoneController,
                            decoration: const InputDecoration(
                              labelText: 'Alternate Phone Number',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: 'Home',
                            decoration: const InputDecoration(
                              labelText: 'Address Type',
                              border: OutlineInputBorder(),
                            ),
                            items: ['Home', 'Work'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              final addressData = {
                                "fullName": nameController.text,
                                "mobile": mobileController.text,
                                "pincode": pincodeController.text,
                                "locality": localityController.text,
                                "address": addresscontroller.text,
                                "city": cityController.text,
                                "state": stateController.text,
                                "landmark": landmarkcontroller.text,
                                "alternatePhone": alternatePhoneController.text,
                                "addressType": "Home",
                              };

                              await Provider.of<CartProvider>(context,
                                      listen: false)
                                  .Addressupdate(
                                token: token,
                                userId: userId,
                                addressData: addressData,
                              );

                              Navigator.pop(context);
                            },
                            child: const Text('Save Address'),
                          ),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }

  void _showRemoveConfirmationSheet(
      BuildContext context, int index, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              icon: const Icon(Icons.close,
                                  size: 20, color: Colors.black),
                              onPressed: () => Navigator.pop(context),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        Text(
                          "Are you sure you want to remove ${item['productTitle']} from bag?",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await context.read<CartProvider>().removeCartItem(
                              userId: widget.userIdddd,
                              productId: item['productId'],
                              variantSKU: item['variantSKU'],
                            );
                        setState(() {
                          selectedIndexes.remove(index);
                          // Adjust indices after removal
                          selectedIndexes = selectedIndexes
                              .where((i) =>
                                  i <
                                  context.read<CartProvider>().cartItems.length)
                              .map((i) => i > index ? i - 1 : i)
                              .toSet();
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("REMOVE"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Move to wishlist not implemented")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3D57),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
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

  void _showRemoveSelectedItemsSheet(BuildContext context) {
    final int selectedCount = selectedIndexes.length;
    final cartItems = context.read<CartProvider>().cartItems;
    if (selectedCount == 0) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding:
              const EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 8),
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
                    icon:
                        const Icon(Icons.close, size: 16, color: Colors.black),
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
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final itemsToRemove = selectedIndexes.map((index) {
                            final item = cartItems[index];
                            return {
                              'productId': item['productId'] as String,
                              'variantSKU': item['variantSKU'] as String,
                            };
                          }).toList();

                          await context
                              .read<CartProvider>()
                              .removeMultipleCartItems(
                                userId: widget.userIdddd,
                                items: itemsToRemove,
                              );

                          setState(() {
                            selectedIndexes.clear();
                          });

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Items removed successfully'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } catch (e) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to remove items: $e'),
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("REMOVE"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Move to wishlist not implemented")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3D57),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
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

  void _showSizeBottomSheet(int index, Map<String, dynamic> item) {
    final List<String> sizes = ['S', 'M', 'L', 'XL'];
    String tempSelectedSize = item['size'] ?? 'M';

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
                    child: Text(
                      "Select Size",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    children: sizes.map((size) {
                      bool isSelected = tempSelectedSize == size;
                      return GestureDetector(
                        onTap: () {
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
                              color: isSelected ? Colors.pink : Colors.black54,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: isSelected ? Colors.pink : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Text.rich(
                    TextSpan(
                      text: "₹${item['finalPrice'] ?? '0'}  ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: "₹${item['originalPrice'] ?? '0'}",
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text:
                              " (${item['applicableDiscount']?['value'] ?? 0}% OFF)",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: "Seller: ",
                      children: [
                        TextSpan(
                          text: "StyleWear",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // Size update not supported by API, show message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Size update not supported")),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("DONE",
                          style: TextStyle(color: Colors.white)),
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

  void _showQtyBottomSheet(int index, Map<String, dynamic> item) {
    int tempQty = item['quantity'] ?? 1;

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
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      await context.read<CartProvider>().updateCartItem(
                            userId: widget.userIdddd,
                            productId: item['productId'],
                            variantSKU: item['variantSKU'],
                            quantity: tempQty,
                          );
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
}
