// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:technical_store/constants.dart';
// import 'package:technical_store/models/item_model.dart';
// import 'package:technical_store/providers/basket_provider.dart';
// import 'package:technical_store/providers/data_provider.dart';
// import 'package:technical_store/providers/settings_provider.dart';
// import 'package:technical_store/screens/ordering_screen.dart';
// import 'package:technical_store/widgets/yes_no_dialog.dart';

// int getCurrentItemCounts(Map basket) {
//   int counts = 0;
//   for (ItemModel id in basket.keys.toList()) {
//     if (basket[id] != null && basket[id] != 0) {
//       counts++;
//     }
//   }
//   return counts;
// }

// List<ItemModel> getCurrentItems(List data, Map basket) {
//   List<ItemModel> items = [];
//   for (ItemModel id in basket.keys.toList()) {
//     if (basket[id] != null && basket[id] != 0) {
//       items.add(item);
//     }
//   }
//   return items;
// }

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    // final basketProvider = Provider.of<BasketProvider>(context);
    // final dataProvider = Provider.of<DataProvider>(context);
    // final settingsProvider = Provider.of<SettingsProvider>(context);
    // final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        //   appBar: AppBar(
        //     leading: IconButton(
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //       icon: Icon(Icons.close),
        //     ),
        //     title: Text("Корзина: ${basketProvider.totalPrice} с."),
        //     centerTitle: true,
        //   ),
        //   body: Column(
        //     children: [
        //       Expanded(
        //         child: ListView.builder(
        //           itemCount: getCurrentItemCounts(
        //             basketProvider.basket,
        //           ),
        //           itemBuilder: (context, index) {
        //             List<ItemModel> items = getCurrentItems(
        //               dataProvider.data,
        //               basketProvider.basket,
        //             );
        //             return Card(
        //               child: Padding(
        //                 padding: EdgeInsets.symmetric(
        //                   vertical: kDefaultPadding / 2,
        //                 ),
        //                 child: Column(
        //                   children: [
        //                     Center(
        //                       child: ListTile(
        //                         title: SizedBox(
        //                           height: 100,
        //                           width: 100,
        //                           child: CachedNetworkImage(
        //                             alignment: Alignment.bottomLeft,
        //                             imageUrl: items[index].imageLinks[0],
        //                             placeholder:
        //                                 (context, url) => Center(
        //                                   child: CircularProgressIndicator(
        //                                     color: theme.primaryColor,
        //                                   ),
        //                                 ),
        //                           ),
        //                         ),
        //                         trailing: SizedBox(
        //                           width: 210,
        //                           height: 50,
        //                           child: Row(
        //                             children: [
        //                               ElevatedButton(
        //                                 style: ElevatedButton.styleFrom(
        //                                   iconColor: kTextColor,
        //                                   fixedSize: Size(70, 50),
        //                                   backgroundColor: theme.primaryColor,
        //                                 ),
        //                                 onPressed: () {
        //                                   if (basketProvider.basket[items[index]
        //                                           .id] <
        //                                       20) {
        //                                     setState(() {
        //                                       basketProvider.addToBasket(
        //                                         items[index].id,
        //                                         items[index].price,
        //                                         1,
        //                                       );
        //                                     });
        //                                   }
        //                                 },
        //                                 child: Icon(Icons.add),
        //                               ),
        //                               SizedBox(
        //                                 height: 50,
        //                                 width: 70,
        //                                 child: Center(
        //                                   child: Text(
        //                                     basketProvider.basket[items[index].id]
        //                                         .toString(),
        //                                     style: TextStyle(
        //                                       color: kTextColor,
        //                                       fontSize: 20,
        //                                       fontWeight: FontWeight.bold,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                               ElevatedButton(
        //                                 style: ElevatedButton.styleFrom(
        //                                   iconColor: kTextColor,
        //                                   fixedSize: Size(70, 50),
        //                                   backgroundColor: theme.primaryColor,
        //                                 ),
        //                                 onPressed: () {
        //                                   if (basketProvider.basket[items[index]
        //                                           .id] >
        //                                       0) {
        //                                     setState(() {
        //                                       basketProvider.removeFormBasket(
        //                                         items[index].id,
        //                                         items[index].price,
        //                                       );

        //                                       if (getCurrentItemCounts(
        //                                             dataProvider.data,
        //                                             basketProvider.basket,
        //                                           ) ==
        //                                           0) {
        //                                         Navigator.of(context).pop();
        //                                       }
        //                                     });
        //                                   }
        //                                 },
        //                                 child: Icon(Icons.remove),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     Text(
        //                       "${items[index].name}: ${items[index].price} с.",
        //                       style: theme.textTheme.bodySmall,
        //                       textAlign: TextAlign.start,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //       Row(
        //         children: [
        //           Container(
        //             padding: EdgeInsets.all(kDefaultPadding / 2),
        //             height: 80,
        //             width: (MediaQuery.of(context).size.width) / 2,
        //             child: ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 backgroundColor: theme.primaryColor,
        //               ),
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) {
        //                       return OrderingScreen(
        //                         number: settingsProvider.settings['number'],
        //                         address: settingsProvider.settings['address'],
        //                         name: settingsProvider.settings['name'],
        //                       );
        //                     },
        //                   ),
        //                 );
        //               },
        //               child: Text("Заказать", style: theme.textTheme.bodyMedium),
        //             ),
        //           ),
        //           Container(
        //             padding: EdgeInsets.all(kDefaultPadding / 2),
        //             height: 80,
        //             width: (MediaQuery.of(context).size.width) / 2,
        //             child: ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 backgroundColor: kCancelButton,
        //               ),
        //               onPressed: () {
        //                 showDialog(
        //                   context: context,
        //                   builder: (context) {
        //                     return YesNoDialog(
        //                       answer: "Вы уверены?",
        //                       doIfYes: () {
        //                         basketProvider.clearBasket();
        //                         Navigator.of(context).pop();
        //                       },
        //                     );
        //                   },
        //                 );
        //               },
        //               child: Text("Очистить", style: theme.textTheme.bodyMedium),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        // );
      ),
    );
  }
}
