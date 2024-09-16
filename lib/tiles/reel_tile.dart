import 'package:fishingshop/model/reel.dart';
import 'package:flutter/material.dart';

class ReelTile extends StatelessWidget {
  final Reel reel;

  const ReelTile({Key? key, required this.reel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return Card(
      child: ListTile(
        title: Text(
          "Название ${rod.name} Производитель ${rod.manufacturer.name}" ,
          style: const TextStyle(
            decoration:
                TextDecoration.none,
          ),
        ),
        
      ),
    );*/
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
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Распределение пространства
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Изображение
              Image.network(
                reel.link,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5), // Увеличенный отступ
              // Текст
              Text(
                reel.price.toString() + " BYN",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 2), // Отступ
              Text(
                "Катушка " + reel.manufacturer.name + " " + reel.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10), // Отступ перед кнопкой
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
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