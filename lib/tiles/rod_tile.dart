import 'dart:typed_data';
import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/service/cart_repository.dart';
import 'package:fishingshop/service/image_repository.dart';
import 'package:flutter/material.dart';

class RodTile extends StatefulWidget {
  final Rod rod;
  final String? role; // Передаем роль как параметр

  const RodTile({Key? key, required this.rod, this.role}) : super(key: key);

  @override
  _RodTileState createState() => _RodTileState();
}

class _RodTileState extends State<RodTile> {
  Uint8List? imageBytes; // Для хранения байтов изображения
  static final Map<int, Uint8List?> imageCache = {}; // Кэш для изображений

  @override
  void initState() {
    super.initState();
    _loadImage(); // Загружаем изображение при инициализации
  }

  Future<void> _loadImage() async {
    // Проверяем, есть ли изображение в кэше
    if (imageCache.containsKey(widget.rod.id)) {
      setState(() {
        imageBytes = imageCache[widget.rod.id]; // Загружаем из кэша
      });
    } else {
      // Если нет в кэше, загружаем из сети
      Uint8List? bytes = await ImageRepository.fetchImage(widget.rod.id);
      if (bytes != null) {
        setState(() {
          imageBytes = bytes; // Устанавливаем байты изображения
          imageCache[widget.rod.id] = bytes; // Сохраняем в кэше
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/rodsDetails', arguments: {
            'rod': widget.rod,
            'imageBytes': imageBytes,
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Изображение
              imageBytes != null
                  ? Image.memory(
                      imageBytes!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 160,
                      width: double.infinity,
                      color: Colors
                          .grey, // Заменитель, пока изображение загружается
                      child: const Center(child: CircularProgressIndicator()),
                    ),
              const SizedBox(height: 5),
              // Цена
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.rod.price} BYN',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.rod.rating}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 2),
              // Название удилища
              Text(
                'Удилище ${widget.rod.manufacturer.name} ${widget.rod.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1, // Ограничиваем количество линий до 1
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              // Длина и тест
              Text(
                '${widget.rod.length} м, тест ${widget.rod.testLoad} г',
                maxLines: 2,
              ),
              const SizedBox(height: 2),
              if (widget.rod.amount > 0)
                Text('В наличии',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 67, 215, 119),
                      fontSize: 15,
                    )),
              if (widget.rod.amount <= 0)
                Text('Нет на складе',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 225, 92, 92),
                      fontSize: 15,
                    )),
              
              // Кнопка "Купить"
              if (widget.role == 'USER')
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      CartRepository.addRodCart(widget.rod.id, context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Купить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
