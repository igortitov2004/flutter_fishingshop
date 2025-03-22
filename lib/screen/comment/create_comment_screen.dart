import 'package:flutter/material.dart';

class CreateCommentScreen extends StatefulWidget {
  final int productId; // ID товара
  final String productType; // Тип товара (reel или rod)

  const CreateCommentScreen({Key? key, required this.productId, required this.productType}) : super(key: key);

  @override
  _CreateCommentScreenState createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  int _rating = 0; // Переменная для хранения рейтинга
  final TextEditingController _textController = TextEditingController(); // Контроллер для текстового поля

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Оставить отзыв'),
      ),
      body: Container(
        color: const Color(0x1200CCFF),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Звёздочки для рейтинга
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1; // Устанавливаем рейтинг
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            // Поле для ввода текста отзыва
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ваш отзыв',
                filled: true, // Включаем заполнение
                fillColor: Colors.white, // Устанавливаем белый фон
              ),
              maxLines: 5, // Максимальное количество строк
            ),
            SizedBox(height: 20),
            // Кнопка для отправки отзыва
            ElevatedButton(
                    onPressed: () {
                      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}