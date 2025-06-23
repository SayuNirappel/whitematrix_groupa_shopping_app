class DummyDb {
  static int selectedCategory = 0;
  static List<Map<String, String>> notificationList = [
    {
      "image":
          "https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg",
      "time": "Deal valid for 4hrs",
      "brand": "H&M",
      "offer": "Up to 60% Off on summer collection"
    },
    {
      "image":
          "https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg",
      "time": "Limited Time Offer",
      "brand": "Zara",
      "offer": "Flat ₹500 Off on all jeans"
    },
    {
      "image":
          "https://images.pexels.com/photos/2983460/pexels-photo-2983460.jpeg",
      "time": "Deal valid for 4hrs",
      "brand": "Nike",
      "offer": "Buy 1 Get 1 on select sneakers"
    }
  ];
  static List<Map<String, String>> categories = [
    {
      "title": "Fashion",
      "image":
          "https://images.pexels.com/photos/994234/pexels-photo-994234.jpeg",
    },
    {
      "title": "Beauty",
      "image":
          "https://images.pexels.com/photos/3373742/pexels-photo-3373742.jpeg",
    },
    {
      "title": "Home & Living",
      "image":
          "https://images.pexels.com/photos/8580762/pexels-photo-8580762.jpeg",
    },
    {
      "title": "Footwear",
      "image": "https://images.pexels.com/photos/19090/pexels-photo.jpg",
    },
    {
      "title": "Accessories",
      "image":
          "https://images.pexels.com/photos/157888/fashion-glasses-go-pro-female-157888.jpeg",
    },
  ];

  static List<String> carousel1ImgeUrl = [
    "https://images.pexels.com/photos/1204463/pexels-photo-1204463.jpeg",
    "https://images.pexels.com/photos/130855/pexels-photo-130855.jpeg",
    "https://images.pexels.com/photos/1639729/pexels-photo-1639729.jpeg"
  ];
  static List<Map> bestSellerCategory = [
    {
      "type": "Saree",
      "offer": "Under ₹999",
      "image":
          "https://images.pexels.com/photos/28943570/pexels-photo-28943570.jpeg"
    },
    {
      "type": "Jeans",
      "offer": "From ₹799",
      "image":
          "https://images.pexels.com/photos/2343661/pexels-photo-2343661.jpeg"
    },
    {
      "type": "Kurtas",
      "offer": "Under ₹699",
      "image":
          "https://images.pexels.com/photos/14683745/pexels-photo-14683745.jpeg"
    },
    {
      "type": "T-Shirts",
      "offer": "Min 50% Off",
      "image":
          "https://images.pexels.com/photos/1861907/pexels-photo-1861907.jpeg"
    },
    {
      "type": "Shoes",
      "offer": "From ₹999",
      "image":
          "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg"
    }
  ];

  static List<Map<String, String>> featuredBrandsList = [
    {
      "image":
          "https://images.pexels.com/photos/1227699/pexels-photo-1227699.jpeg",
      "brand": "AllenSolly",
      "title": "Up to 60% Off",
      "subt": "Holiday Picks"
    },
    {
      "image":
          "https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg",
      "brand": "Nike",
      "title": "Min 40% Off",
      "subt": "Activewear Deals"
    },
    {
      "image":
          "https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg",
      "brand": "Adidas",
      "title": "Flat 50% Off",
      "subt": "Trending Now"
    },
    {
      "image":
          "https://images.pexels.com/photos/2983465/pexels-photo-2983465.jpeg",
      "brand": "Puma",
      "title": "Up to 44% Off",
      "subt": "Explore"
    },
    {
      "image":
          "https://images.pexels.com/photos/6311393/pexels-photo-6311393.jpeg",
      "brand": "Levi's",
      "title": "Min 70% Off",
      "subt": "Summer"
    },
  ];
  static List<Map> featuredPicks = [
    {
      "image":
          "https://images.pexels.com/photos/1656684/pexels-photo-1656684.jpeg",
      "name": "Parx",
      "category": "Tshirt",
      "oP": "₹500",
      "nP": "₹400",
      "reduction": "20%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg",
      "name": "Levis",
      "category": "Jeans",
      "oP": "₹2000",
      "nP": "₹1499",
      "reduction": "25%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg",
      "name": "Nike",
      "category": "Shoes",
      "oP": "₹3999",
      "nP": "₹2999",
      "reduction": "25%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298864/pexels-photo-298864.jpeg",
      "name": "UCB",
      "category": "Shirt",
      "oP": "₹1800",
      "nP": "₹1200",
      "reduction": "33%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/6311393/pexels-photo-6311393.jpeg",
      "name": "H&M",
      "category": "Dress",
      "oP": "₹2500",
      "nP": "₹1750",
      "reduction": "30%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/1656684/pexels-photo-1656684.jpeg",
      "name": "Adidas",
      "category": "Sportswear",
      "oP": "₹2800",
      "nP": "₹2100",
      "reduction": "25%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/209136/pexels-photo-209136.jpeg",
      "name": "Zara",
      "category": "Top",
      "oP": "₹1200",
      "nP": "₹900",
      "reduction": "25%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298869/pexels-photo-298869.jpeg",
      "name": "Arrow",
      "category": "Formal",
      "oP": "₹2200",
      "nP": "₹1600",
      "reduction": "27%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/6311401/pexels-photo-6311401.jpeg",
      "name": "Biba",
      "category": "Kurti",
      "oP": "₹1800",
      "nP": "₹1300",
      "reduction": "28%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/9945174/pexels-photo-9945174.jpeg",
      "name": "Roadster",
      "category": "Jacket",
      "oP": "₹3500",
      "nP": "₹2450",
      "reduction": "30%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/9945196/pexels-photo-9945196.jpeg",
      "name": "Puma",
      "category": "Sneakers",
      "oP": "₹3200",
      "nP": "₹2560",
      "reduction": "20%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298870/pexels-photo-298870.jpeg",
      "name": "Hollister",
      "category": "Tshirt",
      "oP": "₹999",
      "nP": "₹749",
      "reduction": "25%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/1126994/pexels-photo-1126994.jpeg",
      "name": "Reebok",
      "category": "Trackpants",
      "oP": "₹2400",
      "nP": "₹1800",
      "reduction": "25%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298861/pexels-photo-298861.jpeg",
      "name": "Peter England",
      "category": "Shirt",
      "oP": "₹1600",
      "nP": "₹1200",
      "reduction": "25%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298862/pexels-photo-298862.jpeg",
      "name": "Allen Solly",
      "category": "Blazer",
      "oP": "₹5000",
      "nP": "₹3500",
      "reduction": "30%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/1124464/pexels-photo-1124464.jpeg",
      "name": "Jack & Jones",
      "category": "Denim",
      "oP": "₹2700",
      "nP": "₹2000",
      "reduction": "26%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298868/pexels-photo-298868.jpeg",
      "name": "Mufti",
      "category": "Shirt",
      "oP": "₹2100",
      "nP": "₹1500",
      "reduction": "28%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298860/pexels-photo-298860.jpeg",
      "name": "Van Heusen",
      "category": "Casual",
      "oP": "₹2300",
      "nP": "₹1800",
      "reduction": "22%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/6311381/pexels-photo-6311381.jpeg",
      "name": "Max",
      "category": "Ethnic",
      "oP": "₹1900",
      "nP": "₹1425",
      "reduction": "25%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/6311372/pexels-photo-6311372.jpeg",
      "name": "W",
      "category": "Kurta Set",
      "oP": "₹2700",
      "nP": "₹1890",
      "reduction": "30%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/9945175/pexels-photo-9945175.jpeg",
      "name": "ONLY",
      "category": "Crop Top",
      "oP": "₹1100",
      "nP": "₹880",
      "reduction": "20%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/1126995/pexels-photo-1126995.jpeg",
      "name": "Forever 21",
      "category": "Hoodie",
      "oP": "₹2500",
      "nP": "₹1750",
      "reduction": "30%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/9945195/pexels-photo-9945195.jpeg",
      "name": "DressBerry",
      "category": "Casual",
      "oP": "₹1300",
      "nP": "₹999",
      "reduction": "23%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298865/pexels-photo-298865.jpeg",
      "name": "FabIndia",
      "category": "Ethnic",
      "oP": "₹2800",
      "nP": "₹2100",
      "reduction": "25%OFF"
    },
    {
      "image":
          "https://images.pexels.com/photos/298866/pexels-photo-298866.jpeg",
      "name": "Mango",
      "category": "Skirt",
      "oP": "₹2200",
      "nP": "₹1650",
      "reduction": "25%OFF"
    },
  ];

  static List<Map> hiddenGems = [
    {
      "type": "Handbag",
      "offer": "From ₹499",
      "image":
          "https://images.pexels.com/photos/1381553/pexels-photo-1381553.jpeg"
    },
    {
      "type": "Lipstick",
      "offer": "Min 30% Off",
      "image":
          "https://images.pexels.com/photos/1192036/pexels-photo-1192036.jpeg"
    },
    {
      "type": "Watch",
      "offer": "Under ₹1499",
      "image":
          "https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg"
    },
    {
      "type": "Sunglasses",
      "offer": "From ₹799",
      "image": "https://images.pexels.com/photos/46710/pexels-photo-46710.jpeg"
    },
    {
      "type": "Perfume",
      "offer": "Flat 40% Off",
      "image":
          "https://images.pexels.com/photos/965989/pexels-photo-965989.jpeg"
    }
  ];

  static List<Map<String, String>> seasonsBrandsList = [
    {
      "image": "https://images.pexels.com/photos/19090/pexels-photo.jpg",
      "brand": "H&M",
      "title": "Spring Essentials",
      "subt": "Up to 50% Off"
    },
    {
      "image":
          "https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg",
      "brand": "Zara",
      "title": "Summer Collection",
      "subt": "Min 40% Off"
    },
    {
      "image":
          "https://images.pexels.com/photos/974911/pexels-photo-974911.jpeg",
      "brand": "Uniqlo",
      "title": "Winter Warmers",
      "subt": "Flat 30% Off"
    },
    {
      "image":
          "https://images.pexels.com/photos/1394882/pexels-photo-1394882.jpeg",
      "brand": "Jack & Jones",
      "title": "Autumn Vibes",
      "subt": "Min 55% Off"
    },
    {
      "image":
          "https://images.pexels.com/photos/2155319/pexels-photo-2155319.jpeg",
      "brand": "Forever 21",
      "title": "Festive Picks",
      "subt": "Buy 1 Get 1"
    },
  ];
  static List<Map<String, String>> trendingNearby = [
    {
      "image":
          "https://images.pexels.com/photos/1204459/pexels-photo-1204459.jpeg"
    },
    {
      "image":
          "https://images.pexels.com/photos/28943570/pexels-photo-28943570.jpeg"
    },
    {
      "image":
          "https://images.pexels.com/photos/15748627/pexels-photo-15748627.jpeg"
    },
  ];
}
