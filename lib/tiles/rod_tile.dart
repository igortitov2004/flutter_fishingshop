import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/service/cart_repository.dart';
import 'package:flutter/material.dart';


class RodTile extends StatelessWidget {
  final Rod rod;
  final String? role; // Передаем роль как параметр

  const RodTile({Key? key, required this.rod, this.role}) : super(key: key);

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
          Navigator.pushNamed(context, '/rodsDetails', arguments: rod);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Изображение
              Image.network(
                rod.link,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),
              // Цена
              Text(
                '${rod.price} BYN',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 2),
              // Название удилища
              Text(
                'Удилище ${rod.manufacturer.name} ${rod.name}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              // Длина и тест
              Text(
                '${rod.length} м, тест ${rod.testLoad} г',
                maxLines: 2,
              ),
              if (role == 'USER')
              const SizedBox(height: 10),
              // Кнопка "Купить"
              if (role == 'USER')
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      CartRepository.addRodCart(rod.id, context);
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