import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/dummydb.dart';
import 'package:whitematrix_groupa_shopping_app/models/category_model.dart';

class HorizontalSectionList extends StatelessWidget {
  final List<Category> categories;
  final String title;

  const HorizontalSectionList({super.key, required this.categories, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index) {
         List<String> imageList = [];
      List<String> nameList = [];

  switch (title.toLowerCase()) {
    case "tshirt":
      imageList = DummyDb.tshirtList;
      nameList = DummyDb.tshirtTypes;
      break;
    case "shirt":
      imageList = DummyDb.shirtList;
      nameList = DummyDb.shirtTypes;
      break;
    case "trousers":
      imageList = DummyDb.trousersList;
      nameList = DummyDb.trousersTypes;
      break;
    case "shorts":
      imageList = DummyDb.shortsList;
      nameList = DummyDb.shortsTypes;
      break;
    case "pants":
      imageList = DummyDb.pantsList;
      nameList = DummyDb.pantsTypes;
      break;
    case "jeans":
      imageList = DummyDb.jeansList;
      nameList = DummyDb.jeansTypes;
      break;
    default:
      imageList = [];
      nameList = [];
  }
        final category = categories[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(category.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.products.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, productIndex) {
                    final product = category.products[productIndex];
                    return Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                     width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(imageList[index % imageList.length]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                    
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.brand, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text("₹${product.price}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 6),
                                    Text(
                                      "₹${product.originalPrice}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text("VIEW PRODUCTS >", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
