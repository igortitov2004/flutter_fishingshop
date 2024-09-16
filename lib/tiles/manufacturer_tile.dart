import 'package:fishingshop/model/manufacturer.dart';

import 'package:flutter/material.dart';

class ManufacturerTile extends StatelessWidget {
  final Manufacturer manufacturer;

  const ManufacturerTile({Key? key, required this.manufacturer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          manufacturer.name,
          style: const TextStyle(
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
