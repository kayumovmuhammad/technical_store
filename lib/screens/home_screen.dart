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
) {
  if (status == ShowStatus().showStatic) {
    return StaticItemsList(productsByCategory: productsByCategory);
  } else if (status == ShowStatus().showingResult) {
    return StaticItemsList(productsByCategory: [resultOfSearch]);
  }
  return Center(child: Text("Поиск..."));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int page = 0;
  List categories = [];
  List productsByCategory = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scroolbarController = ScrollController();
    final dataProvider = Provider.of<DataProvider>(context);
    final basketProvider = Provider.of<BasketProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final theme = Theme.of(context);
    categories = getCategories(dataProvider.data);
    productsByCategory = getProductsByCategory(dataProvider.data);
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
                controller: scroolbarController,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: scroolbarController,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
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
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: ,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (page != 0) {
                        setState(() {
                          page--;
                        });
                      }
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: page != 0 ? Colors.black : Colors.transparent,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('${page + 1}', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        page++;
                      });
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
