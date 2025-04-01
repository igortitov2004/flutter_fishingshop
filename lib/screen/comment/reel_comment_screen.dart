import 'package:flutter/material.dart';
import 'package:fishingshop/model/reel.dart';

class ReelCommentScreen extends StatelessWidget {
  final Reel reel;

  const ReelCommentScreen({Key? key, required this.reel}) : super(key: key);

  String _getStars(int rating) {
    return '★' * rating + '☆' * (5 - rating); // Звёздочки для рейтинга
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отзывы'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Color(0x1200CCFF),
        padding: const EdgeInsets.all(10), // Паддинг для контейнера
        child: ListView.builder(
          itemCount: reel.reelComments.length,
          itemBuilder: (context, index) {
            final comment = reel.reelComments[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white, // Белый фон карточки
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: Text(
                            comment.user.firstName[0], // Первая буква имени
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${comment.user.firstName} ${comment.user.surname}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _getStars(comment.rating
                              .toInt()), // Звёздочки вместо текста
                          style: const TextStyle(
                            fontSize:
                                24, // Увеличенный размер шрифта для звёздочек
                            color: Colors.yellow, // Цвет звёздочек
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Комментарий: ',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold, // Жирный шрифт
                        color: Colors.grey, // Серый цвет
                      ),
                    ),
                    Text(
                      '${comment.content}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
