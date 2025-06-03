import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/functions/n_push_and_remove_until.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/screens/home_screen.dart';
import 'package:technical_store/widgets/add_remove_btn.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    final basket = basketProvider.basket;
    final ids = basket.keys.toList();

    final theme = Theme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (basket.isEmpty) {
        nPushAndRemoveUntil(context, Home());
      }
    });

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
            SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 1000,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 220,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: basket.length,
                itemBuilder: (context, index) {
                  final currentItem = basket[ids[index]]!.item;
                  final count = basket[ids[index]]!.count;
                  return Container(
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
                                height: 200,
                                width: 200,
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
                              Container(
                                width: 200,
                                // padding: EdgeInsets.only(top: kDefaultPadding),
                                child: Text(
                                  basket[ids[index]]!.item.name,
                                  style: theme.textTheme.bodyMedium,
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
