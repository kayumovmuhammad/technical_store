import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/providers/home_provider.dart';
import 'package:technical_store/widgets/item_card.dart';

class StaticItemsList extends StatefulWidget {
  final List<ItemModel> products;
  final Function scrollToTop;
  final String category;
  final int pageCount;
  const StaticItemsList({
    super.key,
    required this.category,
    required this.pageCount,
    required this.products,
    required this.scrollToTop,
  });

  @override
  State<StaticItemsList> createState() => _StaticItemsListState();
}

class _StaticItemsListState extends State<StaticItemsList> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    int page = homeProvider.page;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisExtent: 500,
            mainAxisSpacing: kDefaultPadding / 2,
            crossAxisSpacing: kDefaultPadding / 2,
            childAspectRatio: 0.75,
          ),
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            ItemModel currentItem = widget.products[index];
            return ItemCard(currentItem: currentItem);
          },
        ),
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: ,
            children: [
              GestureDetector(
                onTap: () async {
                  if (page != 0) {
                    page -= 1;
                    homeProvider.page = page;
                    if (homeProvider.status == ShowStatus().showStatic) {
                      homeProvider.setStatus(ShowStatus().searching);

                      homeProvider.products = await getDataByCategory(
                        widget.category,
                        page,
                      );

                      homeProvider.setStatus(ShowStatus().showStatic);
                    } else {
                      homeProvider.setStatus(ShowStatus().searching);

                      List required = await getSearchableResult(
                        homeProvider.searchable,
                        page,
                      );
                      homeProvider.setStatus(ShowStatus().searching);
                      homeProvider.products = required[0];
                      homeProvider.searchPageCount = required[1];

                      homeProvider.setStatus(ShowStatus().showSearch);
                    }
                    widget.scrollToTop();
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
                onTap: () async {
                  if (page + 1 < widget.pageCount) {
                    page += 1;
                    homeProvider.page = page;

                    if (homeProvider.status == ShowStatus().showStatic) {
                      homeProvider.setStatus(ShowStatus().searching);
                      homeProvider.products = await getDataByCategory(
                        widget.category,
                        page,
                      );

                      homeProvider.setStatus(ShowStatus().showStatic);
                    } else {
                      homeProvider.setStatus(ShowStatus().searching);
                      List required = await getSearchableResult(
                        homeProvider.searchable,
                        page,
                      );
                      homeProvider.setStatus(ShowStatus().searching);
                      homeProvider.products = required[0];
                      homeProvider.searchPageCount = required[1];

                      homeProvider.setStatus(ShowStatus().showSearch);
                    }
                    widget.scrollToTop();
                  }
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color:
                      (page + 1 < widget.pageCount)
                          ? Colors.black
                          : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
