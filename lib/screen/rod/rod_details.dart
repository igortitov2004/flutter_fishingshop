import 'dart:typed_data';
import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/screen/comment/rod_comment_screen.dart';
import 'package:fishingshop/screen/rod/rods_screen.dart';
import 'package:fishingshop/service/cart_repository.dart';
import 'package:fishingshop/service/rod_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RodDetails extends StatefulWidget {
  const RodDetails({Key? key}) : super(key: key);

  @override
  _RodDetailsState createState() => _RodDetailsState();
}

class _RodDetailsState extends State<RodDetails> {
  Rod? rod;
  Uint8List? imageBytes; // Для хранения байтов изображения
  String? role;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    rod = args['rod'] as Rod;
    imageBytes = args['imageBytes'] as Uint8List?;
    super.didChangeDependencies();
  }

  Future<void> _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  @override
  void initState() {
    super.initState();
    _getRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(rod?.name ?? 'Удилище'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0x1200CCFF),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Отображение изображения из байтов
                imageBytes != null
                    ? Image.memory(
                        imageBytes!,
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 350,
                        color: Colors.grey, // Заменитель, пока изображение загружается
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          '${rod!.price} BYN',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5), // Отступ между карточками
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RodCommentScreen(rod: rod!),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${rod!.rating}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  getReviewCountText(rod!.rodComments.length),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Card(
                  color: Colors.white,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Удилище ${rod!.type.type} / ${rod!.manufacturer.name} ${rod!.name}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  color: Colors.white,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Характеристики",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Производитель - ${rod!.manufacturer.name}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Длина, м. - ${rod!.length}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Тест до гр. - ${rod!.testLoad}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Вес (гр.) - ${rod!.weight}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100), // Отступ перед кнопкой
                if (role != 'USER' && role != null)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              RodRepository.deleteRod(rod!.id, context);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RodsScreen()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                const SizedBox(width: 8),
                                const Text(
                                  'Удалить',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/editRod',
                                  arguments: rod);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.white),
                                const SizedBox(width: 8),
                                const Text(
                                  'Изменить',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getReviewCountText(int? count) {
    if (count != null) {
      if (count % 10 == 1 && count % 100 != 11) {
        return '$count отзыв';
      } else if ((count % 10 >= 2 && count % 10 <= 4) &&
          (count % 100 < 10 || count % 100 >= 20)) {
        return '$count отзыва';
      } else {
        return '$count отзывов';
      }
    }
    return '0 отзывов';
  }
}