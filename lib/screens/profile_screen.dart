import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/providers/settings_provider.dart';
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
  String number = '', address = '', name = '';
  String oNumber = '', oAddress = '', oName = '';

  @override
  void initState() {
    number = widget.number;
    address = widget.address;
    name = widget.name;
    oNumber = number;
    oName = name;
    oAddress = address;
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
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Профиль'),
        actions: [
          (name != oName || number != oNumber || address != oAddress
              ? Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    settingsProvider.updateSettings({
                      'number': number,
                      'address': address,
                      'name': name,
                    });
                    oName = name;
                    oAddress = address;
                    oNumber = number;
                  },
                  child: Text("Сохранить", style: theme.textTheme.bodySmall),
                ),
              )
              : SizedBox()),
        ],
      ),
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
                    setState(() {
                      name = value;
                    });
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
                    setState(() {
                      address = value;
                    });
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
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
                  ],
                  controller: numberController,
                  focusNode: numberFocus,
                  onChanged: (value) {
                    setState(() {
                      number = value;
                    });
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
