import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';

class ImagesWidget extends StatefulWidget {
  final double imageSide;
  final ItemModel currentItem;
  final Function getSelectedImage, setSelectedImage;
  const ImagesWidget({
    super.key,
    required this.imageSide,
    required this.currentItem,
    required this.getSelectedImage,
    required this.setSelectedImage,
  });

  @override
  State<ImagesWidget> createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          width: widget.imageSide,
          height: widget.imageSide,
          child: CachedNetworkImage(
            imageUrl: widget.currentItem.imageLinks[widget.getSelectedImage()],
            placeholder:
                (context, url) => Center(
                  child: CircularProgressIndicator(color: theme.primaryColor),
                ),
          ),
        ),
        SizedBox(
          width: widget.imageSide,
          height: 130,
          child: Scrollbar(
            controller: scrollController,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              itemCount: widget.currentItem.imageLinks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  child: GestureDetector(
                    onTap: () {
                      widget.setSelectedImage(index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(kDefaultPadding / 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color:
                              (widget.getSelectedImage() == index)
                                  ? Colors.black
                                  : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.currentItem.imageLinks[index],
                        placeholder:
                            (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: theme.primaryColor,
                              ),
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
