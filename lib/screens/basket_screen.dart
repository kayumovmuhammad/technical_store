import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/functions/n_push_and_remove_until.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/settings_provider.dart';
import 'package:technical_store/screens/home_screen.dart';
import 'package:technical_store/screens/ordering_screen.dart';
import 'package:technical_store/widgets/add_remove_btn.dart';
import 'package:technical_store/widgets/yes_no_dialog.dart';

String getNameWithLimit(String name, int limit) {
  if (name.length <= limit) {
    return name;
  }

  String newName = name.substring(0, limit - 3);
  newName += '...';

  return newName;
}

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final basket = basketProvider.basket;
    final ids = basket.keys.toList();

    final theme = Theme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (basket.isEmpty) {
        nPushAndRemoveUntil(context, Home());
      }
    });

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    var imageSide =
        (min(width, height) - kDefaultPadding - kDefaultPadding / 2) / 3 - 20;
    var textWith =
        2 * (min(width, height) - kDefaultPadding - kDefaultPadding / 2) / 3 -
        20;

    final isPhone = (height > width);
    if (!isPhone) {
      imageSide = imageSide / 2;
      textWith = textWith / 2;
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 212, 212, 212),
            shape: CircleBorder(),
            onPressed: () {
              Navigator.pop(context);
            },
            mini: true,
            child: Icon(Icons.close, color: Colors.black),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      fixedSize: Size(300, 50),
                    ),
                    onPressed: () {
                      nPushAndRemoveUntil(
                        context,
                        OrderingScreen(
                          number: settingsProvider.settings['number'],
                          address: settingsProvider.settings['address'],
                          name: settingsProvider.settings['name'],
                        ),
                      );
                    },
                    child: Text("Заказать", style: theme.textTheme.bodySmall),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return YesNoDialog(
                            answer:
                                'Вы уверены что хотите удалить все выбранные товары из корзины?',
                            doIfYes: () {
                              basketProvider.clearBasket();
                            },
                          );
                        },
                      );
                    },
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
                SizedBox(width: kDefaultPadding / 2),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isPhone ? 1 : 2,
                  mainAxisExtent: imageSide + kDefaultPadding + 50,
                  mainAxisSpacing: kDefaultPadding / 2,
                  crossAxisSpacing: kDefaultPadding / 2,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: basket.length,
                itemBuilder: (context, index) {
                  final currentItem = basket[ids[index]]!.item;
                  final count = basket[ids[index]]!.count;
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(kDefaultPadding / 2),
                              child: CachedNetworkImage(
                                placeholder:
                                    (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                height: imageSide,
                                width: imageSide,
                                imageUrl:
                                    basket[ids[index]]!.item.imageLinks[0],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: kDefaultPadding,
                            right: kDefaultPadding / 2,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: textWith,
                                // padding: EdgeInsets.only(top: kDefaultPadding),
                                child: Text(
                                  getNameWithLimit(
                                    basket[ids[index]]!.item.name,
                                    23,
                                  ),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text("${currentItem.price * count} с."),
                              AddRemoveBtn(currentItem: currentItem),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
