import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/data_provider.dart';
import 'package:technical_store/providers/settings_provider.dart';
import 'package:technical_store/screens/ordering_screen.dart';
import 'package:technical_store/widgets/yes_no_dialog.dart';

int getCurrentItemCounts(List data, Map basket) {
  int counts = 0;
  for (var item in data) {
    if (basket[item['id']] != null && basket[item['id']] != 0) {
      counts++;
    }
  }
  return counts;
}

List getCurrentItems(List data, Map basket) {
  List items = [];
  for (var item in data) {
    if (basket[item['id']] != null && basket[item['id']] != 0) {
      items.add(item);
    }
  }
  return items;
}

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    var basketProvider = Provider.of<BasketProvider>(context);
    var dataProvider = Provider.of<DataProvider>(context);
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            focusColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close),
          ),
          title: Text(
            "Корзина: ${basketProvider.totalPrice} с.",
            style: TextStyle(
              color: kTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: getCurrentItemCounts(
                  dataProvider.data,
                  basketProvider.basket,
                ),
                itemBuilder: (context, index) {
                  List items = getCurrentItems(
                    dataProvider.data,
                    basketProvider.basket,
                  );
                  return Card(
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: ListTile(
                              title: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  items[index]['imageLink'],
                                  alignment: Alignment.topLeft,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 210,
                                height: 50,
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        iconColor: kTextColor,
                                        fixedSize: Size(70, 50),
                                        backgroundColor: Colors.orange,
                                      ),
                                      onPressed: () {
                                        if (basketProvider
                                                .basket[items[index]['id']] <
                                            20) {
                                          setState(() {
                                            basketProvider.addToBasket(
                                              items[index]['id'],
                                              items[index]['price'],
                                              1,
                                            );
                                          });
                                        }
                                      },
                                      child: Icon(Icons.add),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 70,
                                      child: Center(
                                        child: Text(
                                          basketProvider
                                              .basket[items[index]['id']]
                                              .toString(),
                                          style: TextStyle(
                                            color: kTextColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        iconColor: kTextColor,
                                        fixedSize: Size(70, 50),
                                        backgroundColor: Colors.orange,
                                      ),
                                      onPressed: () {
                                        if (basketProvider
                                                .basket[items[index]['id']] >
                                            0) {
                                          setState(() {
                                            basketProvider.removeFormBasket(
                                              items[index]['id'],
                                              items[index]['price'],
                                            );

                                            if (getCurrentItemCounts(
                                                  dataProvider.data,
                                                  basketProvider.basket,
                                                ) ==
                                                0) {
                                              Navigator.of(context).pop();
                                            }
                                          });
                                        }
                                      },
                                      child: Icon(Icons.remove),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${items[index]['name']}: ${items[index]['price']} с.",
                            style: TextStyle(color: kTextColor, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  height: 80,
                  width: (MediaQuery.of(context).size.width) / 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return OrderingScreen(
                              number: settingsProvider.settings['number'],
                              address: settingsProvider.settings['address'],
                              name: settingsProvider.settings['name'],
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Заказать",
                      style: TextStyle(color: kTextColor, fontSize: 25),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  height: 80,
                  width: (MediaQuery.of(context).size.width) / 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 211, 211, 211),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return YesNoDialog(
                            answer: "Вы уверены?",
                            doIfYes: () {
                              basketProvider.clearBasket();
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      "Очистить",
                      style: TextStyle(color: kTextColor, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
