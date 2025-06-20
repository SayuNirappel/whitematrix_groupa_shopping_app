import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/models/category_model.dart';
import 'package:whitematrix_groupa_shopping_app/models/products_models.dart';

class DummyDb {

  static List <String> trendingList = [
    "In The Spotlight",
    "Trending Stores",
    "Trending Sproducts",
    "Trending Categories",
  ];

static List <String> mensList = [
    "Casual Wear",
    "Work Wear",
    "Sports Wear",
    "Occasion Wear",
    "GenZ Fashion",
];

static List <String> womensList = [
    "Western Wear",
    "Ethnic Wear",
    "Sports Wear",
    "Lingerie & Loungewear",
    "GenZ Fashion",
];
  
  static List <String> kidsList = [
    "For Infants",
    "For Girls",
    "For Boys",
    "For Teens",

  ];

  static List <String> footwearList = [
    "Women's Footwear",
    "Men's Footwear",
    "GenZ Men's Footwear",
    "GenZ Women's Footwear",

  ];

  static List <String> groomingList = [
    "Grooming",
    "Fragrances",
    "Hair Care",
    "Skin Care",
    "Makeup",
  ];

  static List <String> homeList =[
    "Kitchen & Dining",
    "Home Decor",
    "Bath & Bedding",
  ];
  
  static List <String> accessoriesList = [
    "Men's Accessories",
    "Women's Accessories"
    "GenZ Accessories",
    "Kids' Accessories",
  ];

  static List <String> gadgetsList =[
    "Gadgets",
    "Smartphones",
    "Smartwatches",
    "Audio & Headphones",
  ];

  static List <String> jewelleryList = [
    "Jewellery",
    "Watches",
    "Fashion Jewellery",
    "Fine Jewellery",
   
  ];

  

  static List <String> itemsList = [
"https://i.pinimg.com/736x/82/44/0c/82440c9d34d1b505fa06d9914e2eaca3.jpg",
"https://i.pinimg.com/736x/aa/6c/49/aa6c495772269e80e74d587d367f5d25.jpg",
"https://i.pinimg.com/736x/63/37/13/633713e418138279e955ff2e625d7155.jpg",
"https://i.pinimg.com/736x/48/a6/05/48a6057b53b81198ac9bb6b91c292989.jpg",
"https://i.pinimg.com/736x/b9/86/0d/b9860db3e22c954580163a46e2fca15e.jpg",
"https://i.pinimg.com/736x/fb/1d/33/fb1d3328285e8cb4471fc0250b9eb8e6.jpg"
  ];

  static List <String> tshirtList = [
    "https://i.pinimg.com/736x/3d/a1/4b/3da14b51d706dbd752cfb260f980e4bf.jpg",
    "https://i.pinimg.com/736x/f7/13/77/f71377efc6a0bb959a34bae7f0fd0cba.jpg",
    "https://i.pinimg.com/736x/78/89/09/788909dc8642849c24abdcb12ec278c1.jpg",
    "https://i.pinimg.com/736x/97/6a/42/976a4233007d94544ab2407e50607615.jpg",
    "https://i.pinimg.com/736x/f7/29/2d/f7292debe40b18aa0856e2855771d563.jpg",
    "https://i.pinimg.com/736x/a6/f7/eb/a6f7eba00b953c8caec5e6190c37c7aa.jpg",
    "https://i.pinimg.com/736x/78/89/09/788909dc8642849c24abdcb12ec278c1.jpg",
    "https://i.pinimg.com/736x/97/6a/42/976a4233007d94544ab2407e50607615.jpg",
    "https://i.pinimg.com/736x/f7/29/2d/f7292debe40b18aa0856e2855771d563.jpg",
     "https://i.pinimg.com/736x/f7/29/2d/f7292debe40b18aa0856e2855771d563.jpg",
    "https://i.pinimg.com/736x/a6/f7/eb/a6f7eba00b953c8caec5e6190c37c7aa.jpg",
    "https://i.pinimg.com/736x/78/89/09/788909dc8642849c24abdcb12ec278c1.jpg",
  ];

  static List <String> tshirtTypes = [
      "Round Neck",
      "Cotton",
      "Regular",
      "Set Of Two",
      "Solid",
      "Printed",
      "Striped",
      "Oversized",
      "Polo Collar",
      "Graphic",
      "Half Sleeve",
  ];

 

 static List <String> shirtTypes = [
  "Linen",
  "Summer Whites",
  "Formal",
  "half Sleeve",
  "Textured",
  "Solid",
  "Resort",
  "Utility",
  "Cotton",
  "Indie Print",
  "Oversized",
 ];

   static List<String> shirtList = [
   "https://i.pinimg.com/736x/7f/95/6f/7f956f373a6f8f1f2dc73c61f89baa57.jpg",
   "https://i.pinimg.com/736x/30/a8/78/30a878401f50faace9bbf9c687928995.jpg",
   "https://i.pinimg.com/736x/91/ba/98/91ba98ff9d45b9de16a249175ae55012.jpg",
   "https://i.pinimg.com/736x/1d/c8/12/1dc8127a8a679f1d9a4a958e627a854a.jpg",
   "https://i.pinimg.com/736x/da/18/49/da1849668b6c55c93e233b7646ca0edc.jpg",
   "https://i.pinimg.com/736x/ce/55/09/ce5509d742fb587bb534ee7fdef81aa1.jpg",
    "https://i.pinimg.com/736x/91/ba/98/91ba98ff9d45b9de16a249175ae55012.jpg",
   "https://i.pinimg.com/736x/1d/c8/12/1dc8127a8a679f1d9a4a958e627a854a.jpg",
   "https://i.pinimg.com/736x/da/18/49/da1849668b6c55c93e233b7646ca0edc.jpg",
   "https://i.pinimg.com/736x/91/ba/98/91ba98ff9d45b9de16a249175ae55012.jpg",
   "https://i.pinimg.com/736x/1d/c8/12/1dc8127a8a679f1d9a4a958e627a854a.jpg",
   "https://i.pinimg.com/736x/da/18/49/da1849668b6c55c93e233b7646ca0edc.jpg",
  ];

  static List<String> jeansList = [
   "https://i.pinimg.com/736x/fe/e2/be/fee2be31deb238b096629b6a21fae10e.jpg",
   "https://i.pinimg.com/736x/8f/73/c3/8f73c3be1ce3203776dd5889d5643778.jpg",
   "https://i.pinimg.com/736x/f6/47/82/f647824af7e057c61bd6ca73b6c5e133.jpg",
   "https://i.pinimg.com/736x/7d/fb/a5/7dfba5f6f90b4d313447dd74e42539cf.jpg",
   "https://i.pinimg.com/736x/5b/21/e6/5b21e698071ffdf588413c67c6942e51.jpg",
   "https://i.pinimg.com/736x/fe/e2/be/fee2be31deb238b096629b6a21fae10e.jpg",
   "https://i.pinimg.com/736x/8f/73/c3/8f73c3be1ce3203776dd5889d5643778.jpg",
   "https://i.pinimg.com/736x/f6/47/82/f647824af7e057c61bd6ca73b6c5e133.jpg",
   "https://i.pinimg.com/736x/7d/fb/a5/7dfba5f6f90b4d313447dd74e42539cf.jpg",
   "https://i.pinimg.com/736x/7d/fb/a5/7dfba5f6f90b4d313447dd74e42539cf.jpg",
   "https://i.pinimg.com/736x/5b/21/e6/5b21e698071ffdf588413c67c6942e51.jpg",
   "https://i.pinimg.com/736x/fe/e2/be/fee2be31deb238b096629b6a21fae10e.jpg",
  ];

  static List<String> shortsList = [
   "https://i.pinimg.com/736x/40/d8/47/40d8470c064f84520e73a0e7956c26d4.jpg",
   "https://i.pinimg.com/736x/58/4b/9c/584b9c1191a43481b5fd3106f3c7023f.jpg",
   "https://i.pinimg.com/736x/ba/db/10/badb102a712db6640d092a50bb004ca3.jpg",
   "https://i.pinimg.com/736x/d9/c5/2b/d9c52be28ac91a5c25da84af0c759539.jpg",
   "https://i.pinimg.com/736x/b3/0c/78/b30c781f8b80f063e19dce09c56e2883.jpg",
   "https://i.pinimg.com/736x/40/d8/47/40d8470c064f84520e73a0e7956c26d4.jpg",
   "https://i.pinimg.com/736x/58/4b/9c/584b9c1191a43481b5fd3106f3c7023f.jpg",
   "https://i.pinimg.com/736x/ba/db/10/badb102a712db6640d092a50bb004ca3.jpg",
   "https://i.pinimg.com/736x/d9/c5/2b/d9c52be28ac91a5c25da84af0c759539.jpg",
   "https://i.pinimg.com/736x/ba/db/10/badb102a712db6640d092a50bb004ca3.jpg",
   "https://i.pinimg.com/736x/d9/c5/2b/d9c52be28ac91a5c25da84af0c759539.jpg",
   "https://i.pinimg.com/736x/b3/0c/78/b30c781f8b80f063e19dce09c56e2883.jpg",
  ];

  static List<String> trousersList = [
   "https://i.pinimg.com/736x/e3/17/21/e31721aba61fe6004fc2fcb06360553d.jpg",
   "https://i.pinimg.com/736x/c2/10/7b/c2107bae1fd39469bf2c9c66f2c0c9dd.jpg",
   "https://i.pinimg.com/736x/fc/a0/6d/fca06d2ab1fae886211254d877e72bb1.jpg",
  "https://i.pinimg.com/736x/7c/78/00/7c780061c0eab045f3e2829bd9f91445.jpg",
  "https://i.pinimg.com/736x/61/b3/5d/61b35d0ed99564feee93fe421d53556e.jpg",
  "https://i.pinimg.com/736x/02/ba/c7/02bac73e1184178cf5128850e27de572.jpg",
  "https://i.pinimg.com/736x/e3/17/21/e31721aba61fe6004fc2fcb06360553d.jpg",
   "https://i.pinimg.com/736x/c2/10/7b/c2107bae1fd39469bf2c9c66f2c0c9dd.jpg",
   "https://i.pinimg.com/736x/fc/a0/6d/fca06d2ab1fae886211254d877e72bb1.jpg",
  "https://i.pinimg.com/736x/fc/a0/6d/fca06d2ab1fae886211254d877e72bb1.jpg",
  "https://i.pinimg.com/736x/7c/78/00/7c780061c0eab045f3e2829bd9f91445.jpg",
  "https://i.pinimg.com/736x/61/b3/5d/61b35d0ed99564feee93fe421d53556e.jpg",
  ];

  static List<String> pantsList = [
   "https://i.pinimg.com/736x/2b/df/dc/2bdfdc556d4d2939194f42dbe76b8cf1.jpg",
   "https://i.pinimg.com/736x/78/a2/db/78a2db5c221e9572fcae00a8bb0a8694.jpg",
   "https://i.pinimg.com/736x/8a/86/18/8a8618d17995f3dde5590d3897f3b58e.jpg",
"https://i.pinimg.com/736x/73/2b/b9/732bb9c39f2d14e46143c0716e059f33.jpg",
"https://i.pinimg.com/736x/63/de/69/63de69460cfee341c78001536400dd15.jpg",
"https://i.pinimg.com/736x/49/e4/2c/49e42c43ddd33b7c9745e2b3f990da19.jpg",
"https://i.pinimg.com/736x/8a/86/18/8a8618d17995f3dde5590d3897f3b58e.jpg",
"https://i.pinimg.com/736x/73/2b/b9/732bb9c39f2d14e46143c0716e059f33.jpg",
"https://i.pinimg.com/736x/63/de/69/63de69460cfee341c78001536400dd15.jpg",
"https://i.pinimg.com/736x/78/a2/db/78a2db5c221e9572fcae00a8bb0a8694.jpg",
   "https://i.pinimg.com/736x/8a/86/18/8a8618d17995f3dde5590d3897f3b58e.jpg",
"https://i.pinimg.com/736x/73/2b/b9/732bb9c39f2d14e46143c0716e059f33.jpg",
  ];

  static List <String> jeansTypes = [
    "Skinny Fit",
    "Slim Fit",
    "Regular Fit",
    "Bootcut",
    "Tapered",
    "Straight Fit",
    "Distressed",
    "High Rise",
    "Low Rise",
    "Mid Rise",
  ];

  static List <String> shortsTypes = [
    "Casual Shorts",
    "Denim Shorts",
    "Cargo Shorts",
    "Sports Shorts",
    "Chino Shorts",
    "Linen Shorts",
    "Printed Shorts",
    "Solid Color Shorts",
  ];

  static List <String> pantsTypes = [
    "Casual Trousers",
    "Formal Trousers",
    "Chinos",
    "Cargo Trousers",
    "Linen Trousers",
    "Joggers",
    "Culottes",
    "Palazzo Pants",
  ];

  static List <String> trousersTypes = [
    "Slim Fit",
    "Regular Fit",
    "Wide Leg",
    "High Rise",
    "Low Rise",
    "Straight Leg",
    "Tapered",
    "Pleated",
    "Cuffed",
  ];

  static List<String> imageUrls = [
    "https://assets.myntassets.com/f_webp,w_980,c_limit,fl_progressive,dpr_2.0/assets/images/2021/6/8/b07ef9e8-b1b7-4b9d-9d15-e633d7ac70a91623162255312-DK-MAIN-BANNER.jpg",
    "https://cms.klubworks.com/content/images/2024/06/Myntra-hacks.webp",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbeM0TX6cYX-u4kVnHvU_Qc_bWkoDpEtBpQg&s",
    "https://assets.myntassets.com/f_webp,w_980,c_limit,fl_progressive,dpr_2.0/assets/images/2021/6/8/b07ef9e8-b1b7-4b9d-9d15-e633d7ac70a91623162255312-DK-MAIN-BANNER.jpg",
    "https://cms.klubworks.com/content/images/2024/06/Myntra-hacks.webp",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbeM0TX6cYX-u4kVnHvU_Qc_bWkoDpEtBpQg&s",
  ];

  
List<Sproduct> dummySproducts = [
  Sproduct(
    brand: 'Urbano Fashion',
    title: 'Men Solid Casual Shirt',
    rating: 4.2,
    reviews: 244,
    originalPrice: 1599,
    discountedPrice: 559,
    discountPercent: 65,
    bestPrice: 447,
    deliveryDate: 'Jun 21',
    isExpress: false,
  ),
  Sproduct(
    brand: 'The Indian Garage Co',
    title: 'Checked Cotton Casual Shirt',
    rating: 4.0,
    reviews: 807,
    originalPrice: 1949,
    discountedPrice: 526,
    discountPercent: 73,
    bestPrice: 420,
    deliveryDate: 'Jun 22',
    isExpress: true,
  ),
  Sproduct(
    brand: 'Roadster',
    title: 'Slim Fit Denim Shirt',
    rating: 4.5,
    reviews: 1100,
    originalPrice: 1799,
    discountedPrice: 699,
    discountPercent: 61,
    bestPrice: 599,
    deliveryDate: 'Jun 22',
    isExpress: false,
  ),
  Sproduct(
    brand: 'HIGHLANDER',
    title: 'Printed Casual Shirt',
    rating: 4.1,
    reviews: 329,
    originalPrice: 1299,
    discountedPrice: 499,
    discountPercent: 62,
    bestPrice: 399,
    deliveryDate: 'Jun 23',
    isExpress: true,
  ),
  Sproduct(
    brand: 'Dennis Lingo',
    title: 'Cotton Formal Shirt',
    rating: 4.3,
    reviews: 190,
    originalPrice: 1499,
    discountedPrice: 599,
    discountPercent: 60,
    bestPrice: 499,
    deliveryDate: 'Jun 21',
    isExpress: false,
  ),
  Sproduct(
    brand: 'H&M',
    title: 'Regular Fit Linen Shirt',
    rating: 4.6,
    reviews: 520,
    originalPrice: 2299,
    discountedPrice: 999,
    discountPercent: 57,
    bestPrice: 799,
    deliveryDate: 'Jun 24',
    isExpress: true,
  ),
  Sproduct(
    brand: 'WROGN',
    title: 'Striped Casual Shirt',
    rating: 4.4,
    reviews: 860,
    originalPrice: 1899,
    discountedPrice: 749,
    discountPercent: 60,
    bestPrice: 649,
    deliveryDate: 'Jun 20',
    isExpress: false,
  ),
  Sproduct(
    brand: 'Louis Philippe',
    title: 'Formal Cotton Shirt',
    rating: 4.7,
    reviews: 600,
    originalPrice: 2599,
    discountedPrice: 1299,
    discountPercent: 50,
    bestPrice: 1199,
    deliveryDate: 'Jun 23',
    isExpress: true,
  ),
  Sproduct(
    brand: 'Allen Solly',
    title: 'Checked Slim Fit Shirt',
    rating: 4.0,
    reviews: 432,
    originalPrice: 1799,
    discountedPrice: 799,
    discountPercent: 55,
    bestPrice: 699,
    deliveryDate: 'Jun 25',
    isExpress: false,
  ),
  Sproduct(
    brand: 'Peter England',
    title: 'Half Sleeve Casual Shirt',
    rating: 4.2,
    reviews: 310,
    originalPrice: 1399,
    discountedPrice: 599,
    discountPercent: 57,
    bestPrice: 499,
    deliveryDate: 'Jun 21',
    isExpress: true,
  ),
];

final List<Category> dummyCategories = [
  Category(
    title: 'Textured Shirts',
    products: [
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1585079546985-3160e27c1e9b',
        brand: 'Urbano',
        price: '1049',
        originalPrice: '2499',
      ),
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1556909218-ef9b4728b81b',
        brand: 'Highlander',
        price: '959',
        originalPrice: '1599',
      ),
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1562157873-818bc0726f0a',
        brand: 'Locomotive',
        price: '1259',
        originalPrice: '3499',
      ),
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1602810316682-9a4506fd2b02',
        brand: 'Dennis Lingo',
        price: '619',
        originalPrice: '1799',
      ),
    ],
  ),
  Category(
    title: 'Summer Shirts',
    products: [
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1600180758890-6f77bff829f4',
        brand: 'H&M',
        price: '499',
        originalPrice: '999',
      ),
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1531473181181-0f94c8ecf4c9',
        brand: 'WROGN',
        price: '549',
        originalPrice: '1299',
      ),
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1602810316682-9a4506fd2b02',
        brand: 'Allen Solly',
        price: '679',
        originalPrice: '1949',
      ),
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1520974735194-6d8e09849b36',
        brand: 'Peter England',
        price: '899',
        originalPrice: '2599',
      ),
    ],
  ),
  Category(
    title: 'Linen Shirts',
    products: [
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1571019613914-85f342c1d4bb',
        brand: 'HIGHLANDER',
        price: '740',
        originalPrice: '1999',
      ),
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1600180758890-6f77bff829f4',
        brand: 'Zara',
        price: '430',
        originalPrice: '1999',
      ),
      Product(
        imageUrl: 'https://images.unsplash.com/photo-1585079546985-3160e27c1e9b',
        brand: 'Myntra',
        price: '430',
        originalPrice: '1999',
      ),
    ],
  ),
];

static List<String> sideTabSection = [
  "https://i.pinimg.com/736x/7d/e4/64/7de464914f7e9741236c6ad0caa42792.jpg",
  "https://i.pinimg.com/736x/2b/4f/37/2b4f37ad98838ecc07ebc038885b28cc.jpg",
  "https://i.pinimg.com/736x/30/a4/b1/30a4b14e98d7ae9d21a1f3e417b8260a.jpg",
  "https://i.pinimg.com/736x/7f/4b/e7/7f4be7cdee31ee9d1f125452fff22987.jpg",
  "https://i.pinimg.com/736x/9f/de/fe/9fdefef664e6a987afafb90e1d35dec1.jpg",
  "https://i.pinimg.com/736x/25/21/a0/2521a0fb06cbf894390f28d70c03e757.jpg",
  "https://i.pinimg.com/736x/4b/d1/55/4bd1553e155c23709d3b2d1ba38d694c.jpg",
  "https://i.pinimg.com/736x/05/51/de/0551de04a2d7698f13e93f7c87cd813f.jpg",
  "https://i.pinimg.com/736x/a1/0b/b6/a10bb690617e4369edb18519034cc309.jpg",
  "https://i.pinimg.com/736x/65/fb/e9/65fbe9cf333ec55e59e2a6adaa59778c.jpg"
];

  static List<String> jewelleryItems =[
    "https://i.pinimg.com/736x/68/47/fa/6847fada022cb08eb70ecafa51b6c622.jpg",
    "https://i.pinimg.com/736x/c6/a6/bc/c6a6bc0bca9f0bc73af1dd83c544be27.jpg",
    "https://i.pinimg.com/736x/62/7a/56/627a56bf9a10e6ae4d99209e84d43e76.jpg",
    "https://i.pinimg.com/736x/25/e9/96/25e996ae856187bd54b6ca78b9047e6e.jpg",
    "https://i.pinimg.com/736x/8f/c7/9c/8fc79c01c9917d5cf702bd31abc08f9f.jpg",
    "https://i.pinimg.com/736x/89/d9/99/89d99936142926fd172486f382868bc6.jpg"
    ];

  static List<String> gadgetItems = [
    "https://i.pinimg.com/736x/4f/d2/07/4fd2075c7782fc6dd8abcc1a3d732bc4.jpg",
    "https://i.pinimg.com/736x/37/da/2e/37da2ea53d12ca4d0729b3272e2b64c0.jpg",
    "https://i.pinimg.com/736x/5a/15/40/5a1540fcce47084c4f27f149421117c9.jpg",
    "https://i.pinimg.com/736x/d0/aa/db/d0aadb46e8d6be0b5aeeaa6348522033.jpg",
    "https://i.pinimg.com/736x/60/62/96/606296ba14b1f2b1f270c68f4262ac84.jpg",
    "https://i.pinimg.com/736x/4a/bf/ac/4abfac43a361ff122dfc0a781e7272d1.jpg"
  ];

  static List<String> accessoryItems = [
    "https://i.pinimg.com/736x/91/9c/b9/919cb959850f2d0f3510958114947df6.jpg",
    "https://i.pinimg.com/736x/ae/d5/4e/aed54ef4818956b3366cf508bf71e5f4.jpg",
    "https://i.pinimg.com/736x/c4/a3/b4/c4a3b4501392607066c1df554739755d.jpg",
    "https://i.pinimg.com/736x/44/17/4a/44174a9733b894827bfcae660ab02239.jpg",
    "https://i.pinimg.com/736x/f4/02/cf/f402cf325d4ffeca3305a002f89e3ccf.jpg",
    "https://i.pinimg.com/736x/ee/71/aa/ee71aad898a5701cf93face7b75cd549.jpg"
  ];
  
  static List<String> homeItems = [
    "https://i.pinimg.com/736x/bc/b6/b1/bcb6b186bbdd58a6f3e8e12e66292640.jpg",
    "https://i.pinimg.com/736x/fe/bc/53/febc531aabc451f3edbab0abe532b48d.jpg",
    "https://i.pinimg.com/736x/b9/fb/67/b9fb67ec077c9084941a649979702334.jpg",
    "https://i.pinimg.com/736x/4d/d2/e8/4dd2e84d035d8a71202cc2d047c9b53a.jpg",
    "https://i.pinimg.com/736x/f3/cc/99/f3cc99cc111ce5a8e7b4a3d9242a6dc9.jpg",
    "https://i.pinimg.com/736x/c2/cb/78/c2cb78397e97f5c48ae6f4003a53b378.jpg"
  ];

  static List<String> groomingItems = [
    "https://i.pinimg.com/736x/11/01/4b/11014b433d5dbceaafaaf4518e2ad13a.jpg",
    "https://i.pinimg.com/736x/59/f0/b6/59f0b6ee30d6261c2fef2af84d3b957b.jpg",
    "https://i.pinimg.com/736x/35/fa/a2/35faa268a4d1db59aa9fb2f297e7ba90.jpg",
    "https://i.pinimg.com/736x/c0/1d/60/c01d60bfc65c41b687ddf131f9b592d9.jpg",
    "https://i.pinimg.com/736x/81/c1/8b/81c18b311133f2c25b35bb4b1e09cd53.jpg",
    "https://i.pinimg.com/736x/82/ec/54/82ec54e140e525c5bc63d31f717ccb16.jpg"
  ];

  static List<String> footwearItems = [
   "https://i.pinimg.com/736x/8c/f2/3a/8cf23a95a8a114a93fd1abca3c64fb20.jpg",
   "https://i.pinimg.com/736x/19/ee/1d/19ee1d00578bb1398850b977f243ac5f.jpg",
   "https://i.pinimg.com/736x/bb/3d/d9/bb3dd99565152b4dde6c7b7541fe01d5.jpg",
   "https://i.pinimg.com/736x/d5/07/31/d507318ac07e2674ddff02775c238f06.jpg",
   "https://i.pinimg.com/736x/aa/a1/31/aaa131423108c4f93412e6718871f77e.jpg",
   "https://i.pinimg.com/736x/de/c1/87/dec187cb8e63a092f30d7a4e9a188243.jpg"
  ];

  static List<String> kidsItems = [
    "https://i.pinimg.com/736x/3c/0f/8e/3c0f8e2d1b4a5b6d7f9c1a2b4f5e6d7a.jpg",
    "https://i.pinimg.com/736x/4b/2c/1d/4b2c1d3e5f6a7b8c9d0e1f2a3b4c5d6e.jpg",
    "https://i.pinimg.com/736x/5a/3b/2c/5a3b2c4d5e6f7a8b9c0d1e2f3a4b5c6d.jpg",
    "https://i.pinimg.com/736x/6c/4d/3e/6c4d3e5f7a8b9c0d1e2f3a4b5c6d7e8f.jpg",
    "https://i.pinimg.com/736x/7e/5f/4a/7e5f4a6b7c8d9e0f1a2b3c4d5e6f7g8h.jpg",
    "https://i.pinimg.com/736x/8f/a0/b1/8fa0b1c2d3e4f5g6h7i8j9k0l1m2n3o.jpg"
  ];

  static List<String> womensItems = [
    "https://i.pinimg.com/736x/1a/2b/3c/1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d.jpg",
    "https://i.pinimg.com/736x/2b/3c/4d/2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7.jpg",
    "https://i.pinimg.com/736x/3c/4d/5e/3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8.jpg",
    "https://i.pinimg.com/736x/4d/5e/6f/4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9.jpg",
    "https://i.pinimg.com/736x/5e/6f/7a/5e6f7a8b9c0d1e2f3a4b5c6d7e8f9g0.jpg",
    "https://i.pinimg.com/736x/6f/7a/8b/6f7a8b9c0d1e2f3a4b5c6d7e8f9g0h1.jpg"
  ];

  

}