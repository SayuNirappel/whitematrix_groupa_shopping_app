import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/color_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/image_constants.dart';
import 'package:whitematrix_groupa_shopping_app/views/category/product_listing_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

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
    ColorConstants.BlueColor,
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
  Widget build(BuildContext context) {
    return Scaffold(
appBar: _build_AppbarSection(),
      backgroundColor: ColorConstants.backgroundColor,
      body: Row(
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
      ),
    );
  }

  AppBar _build_AppbarSection() {
    return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: ColorConstants.textColor),
      onPressed: () {
        // Navigator.pop(context);
      },
    ),
    title: const Text(
      'Categories',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
    ),
    backgroundColor: ColorConstants.backgroundColor,
    actions: [
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

  Widget _build_body_Categorysection(int index) {

    List<String> itemsNameList = [
      'Shirt', 'Tshirt', 'Jeans', 'Trousers', 'Shorts','pants'
    ];

    List imageSectionList =[
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
                            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
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
                 children: List.generate(selectedList.length, (sectionIndex) => Column(
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
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: itemsNameList.length,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            childAspectRatio: 1.0,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                              
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductListingScreen(
                                      title: itemsNameList[index].toLowerCase(),
                                    
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(imageSectionList[selectedIndex][index]),
                                  ),
                                  Text(
                                    itemsNameList[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstants.textColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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

  return Row(
    children: [
      Container(
        width: 10,
        height: isSelectedTab ? 50 : 100,
        decoration: BoxDecoration(
          color: isSelectedTab ? ColorConstants.primaryColor : Colors.grey.shade200,
          borderRadius: isSelectedTab ? BorderRadius.only(
            bottomRight: Radius.circular( 30),
            topRight: Radius.circular( 30)) : BorderRadius.all(Radius.circular(0)),
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
                       image:  DecorationImage(
                          image: NetworkImage(
                            DummyDb.sideTabSection[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                     
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom:0,
                      child:
                    Container(
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
                  fontWeight: isSelectedTab ? FontWeight.bold : FontWeight.normal,
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