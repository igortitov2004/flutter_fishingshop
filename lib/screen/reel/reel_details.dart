import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/service/cart_repository.dart';
import 'package:fishingshop/service/reel_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReelDetails extends StatefulWidget {
  const ReelDetails({Key? key}) : super(key: key);

  @override
  _ReelDetailsState createState() => _ReelDetailsState();
}

class _ReelDetailsState extends State<ReelDetails> {
  Reel? reel;

  String? role;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    reel = args as Reel;
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
          title: Text(reel!.name),
          backgroundColor: Colors.white,
          /*automaticallyImplyLeading: false,
          leading: IconButton(
            
            icon: Icon(Icons.keyboard_arrow_left), // Иконка кнопки
            onPressed: () {
              Navigator.pushNamed(context,'/reels');
              print('Кнопка нажата');
            },
          ),*/
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  reel!.link,
                  height: 350, // Увеличенная высота изображения
                  width: 350,
                ),
                const SizedBox(height: 15), // Увеличенный отступ
                // Текст

                Text(
                  "Катушка " +
                      reel!.type.type +
                      " " +
                      reel!.manufacturer.name +
                      " " +
                      reel!.name +
                      " \n",
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
                  "Производитель - " + reel!.manufacturer.name + "\n",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10), // От
                if (role != 'USER' && role != null)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      // Указание высоты контейнера
                      padding:
                          const EdgeInsets.all(5), // Отступы внутри карточки
                      child: Column(
                        // Распределение элементов
                        children: <Widget>[
                          const SizedBox(height: 2), // От
                          Container(
                              width:
                                  double.infinity, // Установите нужную ширину
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        ReelRepository.deleteReel(reel!.id);
                                        Navigator.pushNamed(context, '/reels');
                                  
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // Выравнивание по левому краю
                                        children: [
                                          Icon(Icons.delete,
                                              color:
                                                  Colors.white), // Иконка слева
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
                                        Navigator.pushNamed(
                                            context, '/editReel',
                                            arguments: reel as Reel);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // Выравнивание по левому краю
                                        children: [
                                          Icon(Icons.edit,
                                              color:
                                                  Colors.white), // Иконка слева
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
                if (role == 'USER' && role != null)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: Container(
                      height: 90,
                      width: double.infinity,
                      // Указание высоты контейнера
                      padding:
                          const EdgeInsets.all(5), // Отступы внутри карточки
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
                                  '${reel!.price} BYN', // Интерполяция строки
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
                                CartRepository.addReelCart(reel!.id, context);
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
