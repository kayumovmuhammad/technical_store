import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/functions/home_functions.dart';
import 'package:technical_store/widgets/main_drawer.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/data_provider.dart';
import 'package:technical_store/providers/home_provider.dart';
import 'package:technical_store/screens/basket_screen.dart';
import 'package:technical_store/widgets/search_line.dart';
import 'package:technical_store/widgets/static_items_list.dart';

Widget getWidgetForShowing(
  String status,
  List productsByCategory,
  List resultOfSearch,
  int selectedCategory,
  Function scrollToTop,
) {
  if (status == ShowStatus().showStatic) {
    return StaticItemsList(
      products: productsByCategory[selectedCategory],
      scroolToTop: scrollToTop,
    );
  } else if (status == ShowStatus().showingResult) {
    return StaticItemsList(products: resultOfSearch, scroolToTop: scrollToTop);
  } else if (status == ShowStatus().nothingToShow) {
    return Image.asset('assets/empty.jpg', height: 500);
  }
  return Center(child: Text("Поиск..."));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController scroolControllerCategories = ScrollController();
  final ScrollController scroolControllerItems = ScrollController();

  void scrollToTop() {
    scroolControllerItems.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final basketProvider = Provider.of<BasketProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final theme = Theme.of(context);
    final categories = getCategories(dataProvider.data);
    final productsByCategory = getProductsByCategory(dataProvider.data);
    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
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
                    backgroundColor: theme.primaryColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, color: kTextColor),
                        Text(
                          "${basketProvider.totalPrice.toString()} c.",
                          style: theme.textTheme.bodySmall,
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
              Text("Technical Store"),
            ],
          ),
        ),
        body: ListView(
          controller: scroolControllerItems,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                kDefaultPadding / 2,
                0,
                kDefaultPadding / 2,
                kDefaultPadding / 2,
              ),
              child: SearchLine(),
            ),
            SizedBox(
              height: 50,
              child: Scrollbar(
                controller: scroolControllerCategories,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: scroolControllerCategories,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        homeProvider.page = 0;
                        homeProvider.setStatus(ShowStatus().showStatic);
                        homeProvider.setSelectedCategory(index);
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
                                    (index == (homeProvider.selectedCategory) &&
                                            homeProvider.status ==
                                                ShowStatus().showStatic)
                                        ? kTextColor
                                        : kTextLightColor,
                                fontWeight:
                                    (index == (homeProvider.selectedCategory) &&
                                            homeProvider.status ==
                                                ShowStatus().showStatic)
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
                                    (index == (homeProvider.selectedCategory) &&
                                            homeProvider.status ==
                                                ShowStatus().showStatic)
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
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: getWidgetForShowing(
                homeProvider.status,
                productsByCategory,
                homeProvider.resultOfSearch,
                homeProvider.selectedCategory,
                scrollToTop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
