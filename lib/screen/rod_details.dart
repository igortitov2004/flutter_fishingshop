import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/service/api_service.dart';
import 'package:flutter/material.dart';

class RodDetails extends StatefulWidget {
  const RodDetails({Key? key}) : super(key: key);

  @override
  _RodDetailsState createState() => _RodDetailsState();
}

class _RodDetailsState extends State<RodDetails> {
  Rod? rod;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    rod = args as Rod;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Text(rod!.name),
           backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  rod!.link,
                  height: 350, // Увеличенная высота изображения
                  width: 350,
                ),
                const SizedBox(height: 15), // Увеличенный отступ
                // Текст

                Text(
                  "Удилище " +
                      rod!.type.type +
                      " " +
                      rod!.manufacturer.name +
                      " " +
                      rod!.name +
                      " \n" +
                      rod!.length.toString() +
                      " м, " +
                      rod!.testLoad.toString() +
                      " г",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 5), // От
                Text(
                  "Характеристики",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 5), // От
                Text(
                  "Производитель - " +
                      rod!.manufacturer.name +
                      "\n" +
                      "Длина, м. - " +
                      rod!.length.toString() +
                      "\n" +
                      "Тест до гр. " +
                      rod!.testLoad.toString() +
                      "\n" +
                      "Вес (гр.) - " +
                      rod!.weight.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10), // От
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    // Указание высоты контейнера
                    padding: const EdgeInsets.all(5), // Отступы внутри карточки
                    child: Column(
                      // Распределение элементов
                      children: <Widget>[
                        const SizedBox(height: 2), // От
                        Container(
                            width: double.infinity, // Установите нужную ширину
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      ApiService.deleteRod(rod!.id);
                                      Navigator.pushNamed(context, '/rods');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      // Выравнивание по левому краю
                                      children: [
                                        Icon(Icons.delete,
                                            color: Colors.white), // Иконка слева
                                        SizedBox(
                                            width:
                                                8), // Отступ между иконкой и текстом
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
                                       Navigator.pushNamed(context, '/editRod', arguments: rod as Rod);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      // Выравнивание по левому краю
                                      children: [
                                        Icon(Icons.edit,
                                            color: Colors.white
                                          ), // Иконка слева
                                        SizedBox(
                                            width:
                                                8), // Отступ между иконкой и текстом
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
                                ]))
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: Container(
                    height: 90,
                    width: double.infinity,
                    // Указание высоты контейнера
                    padding: const EdgeInsets.all(5), // Отступы внутри карточки
                    child: Column(
                      // Распределение элементов
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Выравнивание текста слева
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10), // Отступ слева
                              child: Text(
                                '${rod!.price} BYN', // Интерполяция строки
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20, // Увеличенный размер шрифта
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2), // От
                        Container(
                          width: 320, // Установите нужную ширину
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
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
