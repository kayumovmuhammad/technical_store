import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constans.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/data_provider.dart';
import 'package:technical_store/widgets/item_card.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

List getCatigories(List items) {
  Set catigories = {'Все'};

  for (var item in items) {
    catigories.add(item["category"]);
  }

  return catigories.toList();
}

int getAxisCount(double width, double height) {
  if (width > height) {
    return 4;
  } else {
    return 2;
  }
}

List getProductsByCategory(List items) {
  Set catigories = {'Все'};

  for (var item in items) {
    catigories.add(item["category"]);
  }

  List<List> productsByCategory = [];

  for (var item in catigories) {
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

class _MyAppState extends State<MyApp> {
  List categories = [];
  List productsByCategory = [];
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final basketPrivider = Provider.of<BasketProvider>(context);
    categories = getCatigories(dataProvider.data);
    productsByCategory = getProductsByCategory(dataProvider.data);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
      ),
      home: SafeArea(
        child: Scaffold(
          floatingActionButton:
              basketPrivider.totalPrice == 0
                  ? null
                  : SizedBox(
                    height: 50,
                    width:
                        80 +
                        12 *
                            basketPrivider.totalPrice
                                .toString()
                                .length
                                .toDouble(),
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.orange,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, color: kTextColor),
                          Text(
                            "${basketPrivider.totalPrice.toString()} c.",
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
                SizedBox(width: kDefauldPaddin / 5),
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
                          horizontal: kDefauldPaddin / 2,
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
                            SizedBox(height: kDefauldPaddin / 4),
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
                  padding: EdgeInsets.symmetric(horizontal: kDefauldPaddin / 2),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: getAxisCount(
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height,
                      ),
                      mainAxisSpacing: kDefauldPaddin / 2,
                      crossAxisSpacing: kDefauldPaddin / 2,
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
      ),
    );
  }
}
