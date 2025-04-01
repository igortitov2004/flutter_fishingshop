import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/service/cart_repository.dart';
import 'package:flutter/material.dart';

class ReelTile extends StatelessWidget {
  final Reel reel;
  final String? role; // Передаем роль как параметр

  const ReelTile({Key? key, required this.reel, this.role}) : super(key: key);

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
          Navigator.pushNamed(context, '/reelsDetails', arguments: reel);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Изображение
              Image.network(
                reel.link,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),
              // Цена и рейтинг
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${reel.price} BYN',
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
                      SizedBox(width: 4),
                      Text(
                        '${reel.rating}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 2),
              // Название катушки
              Text(
                'Катушка ${reel.manufacturer.name} ${reel.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1, // Ограничиваем количество линий до 1
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              // Кнопка "Купить"
              if (role == 'USER')
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      CartRepository.addReelCart(reel.id, context);
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