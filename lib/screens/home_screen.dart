import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/data_provider.dart';
import 'package:technical_store/screens/basket_screen.dart';
import 'package:technical_store/widgets/item_card.dart';

List getCategories(List items) {
  Set categories = {'Все'};

  for (var item in items) {
    categories.add(item["category"]);
  }

  return categories.toList();
}

List getProductsByCategory(List items) {
  Set categories = {'Все'};

  for (var item in items) {
    categories.add(item["category"]);
  }

  List<List> productsByCategory = [];

  for (var item in categories) {
    List products = [];
    for (var ind = 0; ind < items.length; ind++) {
      if (items[ind]['category'] == item || item == 'Все') {
        products.add(ind);
      }
    }
    productsByCategory.add(products);
  }

  return productsByCategory;
}

int getAxisCount(double width, double height) {
  if (width > height) {
    return 4;
  } else {
    return 2;
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [];
  List productsByCategory = [];
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final basketProvider = Provider.of<BasketProvider>(context);
    categories = getCategories(dataProvider.data);
    productsByCategory = getProductsByCategory(dataProvider.data);
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
            basketProvider.totalPrice == 0
                ? null
                : SizedBox(
                  height: 50,
                  width:
                      80 +
                      12 *
                          basketProvider.totalPrice
                              .toString()
                              .length
                              .toDouble(),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BasketScreen()),
                      );
                    },
                    backgroundColor: Colors.orange,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, color: kTextColor),
                        Text(
                          "${basketProvider.totalPrice.toString()} c.",
                          style: TextStyle(color: kTextColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.computer),
              SizedBox(width: kDefaultPadding / 5),
              Text(
                "Technical Store",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 2,
                      ),
                      child: Column(
                        children: [
                          Text(
                            categories[index],
                            style: TextStyle(
                              color:
                                  index == selectedCategory
                                      ? kTextColor
                                      : kTextLightColor,
                              fontWeight:
                                  index == selectedCategory
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          Container(
                            height: 2,
                            width: 30,
                            decoration: BoxDecoration(
                              color:
                                  index == selectedCategory
                                      ? kTextColor
                                      : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getAxisCount(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height,
                    ),
                    mainAxisSpacing: kDefaultPadding / 2,
                    crossAxisSpacing: kDefaultPadding / 2,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: productsByCategory[selectedCategory].length,
                  itemBuilder: (context, index) {
                    var currentProduct =
                        dataProvider
                            .data[productsByCategory[selectedCategory][index]];
                    return ItemCard(
                      currentProduct: currentProduct,
                      mainIndex: productsByCategory[selectedCategory][index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
