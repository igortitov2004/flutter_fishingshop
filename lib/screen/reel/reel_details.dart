import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/screen/cart/cart_screen.dart';
import 'package:fishingshop/screen/comment/reel_comment_screen.dart';
import 'package:fishingshop/screen/reel/reel_screen.dart';
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
        centerTitle: true,
      ),
      body: Container(
        // Обернули в Container
        color: const Color(0x1200CCFF),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10), // Общий отступ
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  reel!.link,
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover, // Масштабирование изображения
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          '${reel!.price} BYN',
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
                              builder: (context) => ReelCommentScreen(
                                  reel: reel!), // Переход на экран отзывов
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Распределение элементов по краям
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Выравнивание текста по левому краю
                                  children: [
                                    Row(
                                      children: [
                                        // Желтая звездочка
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20,
                                        ),

                                        const SizedBox(
                                            width:
                                                5), // Отступ между звездочкой и текстом
                                        Text(
                                          '${reel!.rating}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 5), // Отступ между строками
                                    Text(
                                      getReviewCountText(reel!.reelComments.length),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(Icons.chevron_right,
                                    color: Colors.grey), // Стрелка вправо
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
                    width: double.infinity, // Занять всю ширину
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Катушка " +
                          reel!.type.type +
                          " /" +
                          "\n" +
                          reel!.manufacturer.name +
                          " " +
                          reel!.name,
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
                    width: double.infinity, // Занять всю ширину
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Выравнивание текста по левому краю
                      children: [
                        Text(
                          "Характеристики",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(
                            height: 5), // Отступ между заголовком и текстом
                        Text(
                          "Производитель - " + reel!.manufacturer.name,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
