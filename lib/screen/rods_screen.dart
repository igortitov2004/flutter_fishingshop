import 'package:fishingshop/model/rod.dart';

import 'package:fishingshop/rod_tile.dart';
import 'package:fishingshop/service/api_service.dart';
import 'package:flutter/material.dart';

class RodsScreen extends StatefulWidget {
  const RodsScreen({Key? key}) : super(key: key);

  @override
  _RodsScreenState createState() => _RodsScreenState();
}

class _RodsScreenState extends State<RodsScreen> {
  List<Rod>? rods;

  getRods() async {
    rods = await ApiService.getRods();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getRods();
  }

  @override
  Widget build(BuildContext context) {
    return rods == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'solo',
              ),
              centerTitle: true,
              backgroundColor: const Color(0xffffffff),
            ),
            body: Container(
              color: Color(0x1200CCFF),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Количество элементов в строке
                  childAspectRatio: 0.5, // Соотношение ширины и высоты
                  crossAxisSpacing:
                      1, // Расстояние между элементами по горизонтали
                  mainAxisSpacing:
                      1, // Расстояние между элементами по вертикали
                ),
                itemCount: rods!.length, // Используем rods напрямую
                itemBuilder: (context, index) {
                  Rod rod = rods![index]; // Получаем объект Rod
                  return RodTile(
                    rod: rod,
                    // Удаляем rodData, если он не нужен
                  );
                },
              ),
            ),
          );
  }
}
