import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/widgets/main_drawer.dart';

class ProfileScreen extends StatefulWidget {
  final String number, address, name;
  const ProfileScreen({
    super.key,
    required this.number,
    required this.address,
    required this.name,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isRename = false;
  bool isReaddress = false;
  bool isRenumber = false;
  late FocusNode nameFocus, addressFocus, numberFocus;
  late TextEditingController nameController,
      addressController,
      numberController;
  String number = '', address = '', name = '', description = '';

  @override
  void initState() {
    number = widget.number;
    address = widget.address;
    name = widget.name;
    nameFocus = FocusNode();
    addressFocus = FocusNode();
    numberFocus = FocusNode();
    nameController = TextEditingController(text: name);
    addressController = TextEditingController(text: address);
    numberController = TextEditingController(text: number);

    nameFocus.addListener(() {
      if (!nameFocus.hasFocus) {
        setState(() {
          isRename = false;
        });
      }
    });
    addressFocus.addListener(() {
      if (!addressFocus.hasFocus) {
        setState(() {
          isReaddress = false;
        });
      }
    });
    numberFocus.addListener(() {
      if (!numberFocus.hasFocus) {
        setState(() {
          isRenumber = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    nameFocus.dispose();
    addressFocus.dispose();
    numberFocus.dispose();
    nameController.dispose();
    addressController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text('Профиль')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Имя:", style: theme.textTheme.headlineSmall),
            SizedBox(height: 5),
            (isRename
                ? TextField(
                  controller: nameController,
                  focusNode: nameFocus,
                  onChanged: (value) {
                    name = value;
                  },
                  onSubmitted: (value) {
                    setState(() {
                      isRename = false;
                    });
                  },
                  style: theme.textTheme.bodySmall,
                )
                : ListTile(
                  title: Text(name, style: theme.textTheme.bodySmall),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        nameFocus.requestFocus();
                        isRename = true;
                        isReaddress = false;
                        isRenumber = false;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      nameFocus.requestFocus();
                      isRename = true;
                      isReaddress = false;
                      isRenumber = false;
                    });
                  },
                )),

            Text("Адрес:", style: theme.textTheme.headlineSmall),
            SizedBox(height: 5),
            (isReaddress
                ? TextField(
                  controller: addressController,
                  focusNode: addressFocus,
                  onChanged: (value) {
                    address = value;
                  },
                  onSubmitted: (value) {
                    setState(() {
                      isReaddress = false;
                    });
                  },
                  style: theme.textTheme.bodySmall,
                )
                : ListTile(
                  title: Text(address, style: theme.textTheme.bodySmall),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        addressFocus.requestFocus();
                        isReaddress = true;
                        isRename = false;
                        isRenumber = false;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      addressFocus.requestFocus();
                      isReaddress = true;
                      isRename = false;
                      isRenumber = false;
                    });
                  },
                )),

            Text("Номер телефона:", style: theme.textTheme.headlineSmall),
            SizedBox(height: 5),
            (isRenumber
                ? TextField(
                  controller: numberController,
                  focusNode: numberFocus,
                  onChanged: (value) {
                    number = value;
                  },
                  onSubmitted: (value) {
                    setState(() {
                      isRenumber = false;
                    });
                  },
                  style: theme.textTheme.bodySmall,
                )
                : ListTile(
                  title: Text(number, style: theme.textTheme.bodySmall),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        numberFocus.requestFocus();
                        isRenumber = true;
                        isReaddress = false;
                        isRename = false;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      numberFocus.requestFocus();
                      isRenumber = true;
                      isReaddress = false;
                      isRename = false;
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}
