import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/models/home_dummy_db.dart';
import 'package:whitematrix_groupa_shopping_app/views/category/category_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/home/home_screen_widgets.dart';
import 'package:whitematrix_groupa_shopping_app/views/notifications/notification_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/product_details/product_detail_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/testing_parameterPassing/parameter_test.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? dropdownValue;

  //int selectedCategory = 0;

  final carouselImgeUrl = DummyDb.carousel1ImgeUrl;

  int carousel1Index = 0;
  @override
  Widget build(BuildContext context) {
    //appbar + tab at bottom
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 239, 244),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 239, 244),
            title: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Text(
                            " M",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE91E63)),
                          ),
                          Text(
                            "Search",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Icon(Icons.search)
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
                  },
                  child: Icon(Icons.notification_important_outlined)),
              SizedBox(
                width: 15,
              ),
              Icon(Icons.favorite_outline),
              SizedBox(
                width: 15,
              ),
              Icon(Icons.account_circle_outlined),
              SizedBox(
                width: 15,
              )
            ],
            //tabs
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                        isScrollable: false,
                        labelColor: Color(0xFFE91E63),
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Color(0xFFE91E63),
                        tabs: const [
                          Tab(text: "All"),
                          Tab(text: "Men"),
                          Tab(text: "Women"),
                          Tab(text: "Kids"),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen()));
                        },
                        child: Icon(Icons.window_outlined)),
                  ) //path to collections
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            ///
            ///
            ///____________________________________________________Tab1 ___________________________________________________
            ///
            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),

              ///
              ///--------Custom Scroll View for future Slivers
              ///
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),

                      ///
                      ///
                      ///-----------------------------item type selection with category updaation-------------------------
                      ///
                      ///

                      ScrollingRowV2(
                        itemCount: DummyDb.categories.length,
                        onTap: (index) {
                          DummyDb.selectedCategory = index;
                          setState(() {});

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen()));
                        },
                        itemBuilder: (index) {
                          final item = DummyDb.categories[index];
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                height: 50,
                                width: 50,
                                clipBehavior: Clip.antiAlias,
                                child: Image(
                                  image: NetworkImage(item["image"]!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                item["title"]!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      ///
                      ///-----------------------Ad-------------------------------------------
                      ///

                      InkWell(
                        onTap: () {
                          //ad navigation
                        },
                        child: TempAdBanner(
                            borderColor: Colors.deepOrange,
                            containerColor: Colors.orangeAccent,
                            textrColor: Colors.white,
                            height: 50,
                            fSize: 20),
                      ),

                      ///
                      ///
                      ///----------------------------Sliding images using CarouselSlider-------------------------------------------
                      ///
                      ///
                      SizedBox(
                        height: 10,
                      ),
                      CarouselSliders(imageUrls: DummyDb.carousel1ImgeUrl),

                      SizedBox(
                        height: 5,
                      ),

                      ///
                      ///-----------------------Ad-------------------------------------------
                      ///
                      InkWell(
                        onTap: () {
                          //ad navigation
                        },
                        child: TempAdBanner(
                            borderColor: Colors.white,
                            containerColor: Colors.white,
                            textrColor: Colors.black,
                            height: 30,
                            fSize: 10),
                      ),

                      ///
                      ///
                      ///------------------------------------Double Layer Row-------------------------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),

                      ScrollingRow(
                        itemCount: DummyDb.featuredBrandsList.length,
                        itemBuilder: (index) {
                          return Column(
                            spacing: 10,
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
                                    Image(
                                      image: NetworkImage(
                                        DummyDb.featuredBrandsList[index]
                                            ["image"]!,
                                      ),
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                                    Positioned(
                                        child: Row(
                                      spacing: 5,
                                      children: [
                                        Text(
                                          DummyDb.featuredBrandsList[index]
                                              ["brand"]!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.grey,
                                          size: 10,
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 80,
                                width: 80,
                                clipBehavior: Clip.antiAlias,
                                child: Stack(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        DummyDb.featuredBrandsList[index]
                                            ["image"]!,
                                      ),
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                                    Positioned(
                                        child: Row(
                                      spacing: 5,
                                      children: [
                                        Text(
                                          DummyDb.featuredBrandsList[index]
                                              ["brand"]!,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.grey,
                                          size: 10,
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                        onTap: (index) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ParameterTest(
                                      dbList: DummyDb.featuredBrandsList,
                                      passedIndex: index)));
                        },
                      ),

                      ///
                      ///
                      ///------------------------------------Continue Shopping------------------------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
                      TitleRow(
                        mainAxisAlignment: MainAxisAlignment.start,
                        title: "Continue Shopping",
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ContinuingRow(),
                      SizedBox(
                        height: 10,
                      ),

                      ///
                      ///
                      ///-------------------------------------Price Store Row------------------------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 248, 240, 213),
                                Color.fromARGB(255, 255, 239, 244)
                              ]),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "PRICE STORE",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ScrollingRow(
                              itemCount: 4,
                              itemBuilder: (index) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Flat",
                                        ),
                                        Text(
                                          "80%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        Text(
                                          "Off",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              onTap: (index) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryScreen()));
                              },
                            ),
                          ],
                        ),
                      ),

                      ///
                      ///
                      ///-------------------------------------Featured Brands Row------------------------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
                      TitleRow(
                        mainAxisAlignment: MainAxisAlignment.start,
                        title: "FEATURED BRANDS",
                        fontSize: 20,
                      ),
                      RowWithBorderContainerType1(
                          dBList: DummyDb.featuredBrandsList),

                      ///
                      ///
                      ///-----------------------------------Featured Picks Row---------------------------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
                      TitleRow(
                          title: "Featured Picks",
                          fontSize: 20,
                          mainAxisAlignment: MainAxisAlignment.start),

                      ScrollingRow(
                        itemCount: DummyDb.featuredPicks.length,
                        itemBuilder: (index) {
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
                                      Image(
                                        image: NetworkImage(
                                          DummyDb.featuredPicks[index]
                                              ["image"]!,
                                        ),
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                      Positioned(
                                          bottom: 10,
                                          left: 2,
                                          right: 2,
                                          child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        DummyDb.featuredPicks[
                                                            index]["name"],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          /// add to fav function
                                                        },
                                                        icon: Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.grey,
                                                        ))
                                                  ],
                                                ),
                                                Text(
                                                  DummyDb.featuredPicks[index]
                                                      ["category"],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Row(
                                                  spacing: 5,
                                                  children: [
                                                    Text(
                                                      DummyDb.featuredPicks[
                                                          index]["oP"],
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      DummyDb.featuredPicks[
                                                          index]["nP"],
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      DummyDb.featuredPicks[
                                                          index]["reduction"],
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ]);
                        },
                        onTap: (index) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ParameterTest(
                                      dbList: DummyDb.featuredPicks,
                                      passedIndex: index)));
                        },
                      ),

                      ///
                      ///
                      ///----------------------Best Seller Category------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "BESTSELLER CATEGORY",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),

                      PhotoTypeRow(bslist: DummyDb.bestSellerCategory),
                      SizedBox(
                        height: 10,
                      ),

                      ///
                      ///
                      ///-------------------------------------Continue Browsing Style------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
                      TitleRow(
                        mainAxisAlignment: MainAxisAlignment.start,
                        title: "Continue Browsing These Styles",
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ContinuingRow(),
                      SizedBox(
                        height: 10,
                      ),

                      ///
                      ///
                      ///------------------------------Seasons Best Brands---------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),

                      TitleRow(
                        mainAxisAlignment: MainAxisAlignment.start,
                        title: "Season's Best Brands",
                        fontSize: 20,
                      ),
                      TitleRow(
                        mainAxisAlignment: MainAxisAlignment.start,
                        title: "Iconic styles to steal the spot light",
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RowWithBorderContainerType1(
                          dBList: DummyDb.seasonsBrandsList),
                      SizedBox(
                        height: 10,
                      ),

                      ///
                      ///
                      ///------------------------------Hidden Gems---------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "HIDDEN GEMS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PhotoTypeRow(bslist: DummyDb.hiddenGems),
                      SizedBox(
                        height: 10,
                      ),

                      ///
                      ///
                      ///------------------------------Mynthra Recommends---------------------------
                      ///
                      ///
                      SizedBox(
                        height: 10,
                      ),
                      TitleRow(
                        mainAxisAlignment: MainAxisAlignment.start,
                        title: "Mynthre Recommends",
                        fontSize: 20,
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
                                border: Border.all(color: Color(0xFFE91E63))),
                            child: Text(
                              "Picks You'll Love",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE91E63)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ScrollingRow(
                        itemCount: DummyDb.featuredPicks.length,
                        itemBuilder: (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 210,
                                width: 150,
                                child: Image(
                                  image: NetworkImage(
                                      DummyDb.featuredPicks[index]["image"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DummyDb.featuredPicks[index]["name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      DummyDb.featuredPicks[index]["category"],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Row(spacing: 5, children: [
                                      Text(
                                        DummyDb.featuredPicks[index]["oP"],
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        DummyDb.featuredPicks[index]["nP"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        DummyDb.featuredPicks[index]
                                            ["reduction"],
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
                                  builder: (context) => ParameterTest(
                                      dbList: DummyDb.featuredPicks,
                                      passedIndex: index)));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      ///
                      ///
                      ///------------------------------Whats Trending Nearby---------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Color.fromARGB(255, 248, 240, 213),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "What's Trending Nearby!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "discover What's Hot in Your Region",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ScrollingRowV2(
                              itemCount: DummyDb.trendingNearby.length,
                              itemBuilder: (index) {
                                return Stack(
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.all(15),
                                      height: 210,
                                      width: 150,
                                      child: Image(
                                        image: NetworkImage(DummyDb
                                            .trendingNearby[index]["image"]!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                              fontSize: 100,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))
                                  ],
                                );
                              },
                              onTap: (index) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ParameterTest(
                                            dbList: DummyDb.trendingNearby,
                                            passedIndex: index)));
                              },
                            )
                          ],
                        ),
                      ),

                      ///
                      ///
                      ///------------------------------Featured Picks---------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
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
                      SizedBox(
                        height: 10,
                      ),
                      RowWithBorderContainerType1(
                          dBList: DummyDb.featuredBrandsList),

                      ///
                      ///
                      ///------------------------------Seasons Best Brands---------------------------
                      ///
                      ///
                      SizedBox(
                        height: 20,
                      ),
                      TitleRow(
                          title: "Season's Best Brands",
                          fontSize: 20,
                          mainAxisAlignment: MainAxisAlignment.start),
                      TitleRow(
                          title: "Iconic styles to seal teh spotlight",
                          fontSize: 15,
                          color: Colors.grey,
                          mainAxisAlignment: MainAxisAlignment.start),
                      CarouselSliders(imageUrls: DummyDb.carousel1ImgeUrl),

                      SizedBox(
                        height: 5,
                      ),

                      ///
                      ///
                      ///------------------------------Featured Picks---------------------------
                      ///
                      ///

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
                      SizedBox(
                        height: 10,
                      ),
                      RowWithBorderContainerType1(
                          dBList: DummyDb.seasonsBrandsList),
                      SizedBox(
                        height: 20,
                      ),

                      ///
                      ///
                      ///
                      ///-----------------------------------Explore More + Slivers----------------------
                      ///
                      ///
                      ///
                      ///
                      DefaultTabController(
                        length: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "EXPLORE MORE DETAILS",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),

                            // Tab Bar
                            TabBar(
                              isScrollable: true,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.black,
                              indicatorColor: Colors.transparent,
                              tabs: [
                                Tab(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.grey)),
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      hint: Text(
                                          "Gender"), // this shows when value is null
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownValue = value!;
                                        });
                                      },
                                      underline: SizedBox(),
                                      items: ["Men", "Boys", "Girls", "Women"]
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                NestedButtonTabs(
                                  icon: Icons.label_important,
                                  label: "Top Brands",
                                ),
                                NestedButtonTabs(
                                  icon: Icons.star_border,
                                  label: "Top Rated",
                                ),
                                NestedButtonTabs(
                                  icon: Icons.abc_outlined,
                                  label: "Hot Trends",
                                ),
                                NestedButtonTabs(
                                  icon: Icons.format_underline_outlined,
                                  label: "Mynthra Unique",
                                ),
                                NestedButtonTabs(
                                  icon: Icons.public,
                                  label: "Global Brands",
                                ),
                                NestedButtonTabs(
                                  icon: Icons.auto_graph,
                                  label: "Rising Star",
                                )
                              ],
                            ),

                            // TabBarView with Grids
                            Container(
                              height: 800,
                              child: TabBarView(
                                children: List.generate(7, (tabIndex) {
                                  return GridView.builder(
                                    padding: EdgeInsets.all(12),
                                    itemCount: DummyDb.featuredPicks.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      mainAxisExtent: 290,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ParameterTest(
                                                            dbList: DummyDb
                                                                .featuredPicks,
                                                            passedIndex:
                                                                index)));
                                          },

                                          ///
                                          ///------------------Grid Items
                                          ///
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 210,
                                                width: 150,
                                                child: Image(
                                                  image: NetworkImage(DummyDb
                                                          .featuredPicks[index]
                                                      ["image"]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      DummyDb.featuredPicks[
                                                          index]["name"],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      DummyDb.featuredPicks[
                                                          index]["category"],
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        //spacing: 1,
                                                        children: [
                                                          Text(
                                                            DummyDb.featuredPicks[
                                                                index]["oP"],
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Text(
                                                            DummyDb.featuredPicks[
                                                                index]["nP"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              DummyDb.featuredPicks[
                                                                      index]
                                                                  ["reduction"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ])
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ));
                                    },
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
            //____________________________________________________Tab 2/3/4______________________________________________________
            DummyTabData(),
            DummyTabData(),
            DummyTabData(),
          ])),
    );
  }
}

///
///
///------------------Dummy Tab Contents
///
///
class DummyTabData extends StatelessWidget {
  const DummyTabData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),

              TitleRow(
                mainAxisAlignment: MainAxisAlignment.start,
                title: "Season's Best Brands",
                fontSize: 20,
              ),
              TitleRow(
                mainAxisAlignment: MainAxisAlignment.start,
                title: "Iconic styles to steal the spot light",
                color: Colors.grey,
                fontSize: 15,
              ),
              SizedBox(
                height: 10,
              ),
              RowWithBorderContainerType1(dBList: DummyDb.seasonsBrandsList),
              SizedBox(
                height: 10,
              ),

              ///
              ///
              ///------------------------------Hidden Gems---------------------------
              ///
              ///
              SizedBox(
                height: 20,
              ),
              Text(
                "HIDDEN GEMS",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              PhotoTypeRow(bslist: DummyDb.hiddenGems),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
