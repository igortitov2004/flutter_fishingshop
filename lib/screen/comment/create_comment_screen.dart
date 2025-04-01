import 'package:fishingshop/DTOs/reel_comment_creation_request.dart';
import 'package:fishingshop/screen/comment/rod_comment_screen.dart';
import 'package:fishingshop/screen/order/order_history_screen.dart';
import 'package:fishingshop/service/comment_repository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fishingshop/DTOs/rod_comment_creation_request.dart';
import 'package:fishingshop/service/globals.dart';

class CreateCommentScreen extends StatefulWidget {
  final int productId; // ID товара
  final String productType; // Тип товара (reel или rod)

  const CreateCommentScreen(
      {Key? key, required this.productId, required this.productType})
      : super(key: key);

  @override
  _CreateCommentScreenState createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  int _rating = 0; // Переменная для хранения рейтинга
  final TextEditingController _textController =
      TextEditingController(); // Контроллер для текстового поля

  Future<void> _saveComment() async {
    if (_rating == 0 || _textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Пожалуйста, оцените товар и напишите отзыв."),
      ));
      return;
    }
    if (widget.productType == "rod") {
      RodCommentCreationRequest request = RodCommentCreationRequest(
        rodId: widget.productId,
        rating: _rating,
        content: _textController.text,
      );
      await CommentRepository.addRodComment(request, context);
    } else if (widget.productType == "reel") {
      ReelCommentCreationRequest request = ReelCommentCreationRequest(
        reelId: widget.productId,
        rating: _rating,
        content: _textController.text,
      );
      await CommentRepository.addReelComment(request, context);
    }
  
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrderHistoryScreen(), // Переход на экран комментариев
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Оставить отзыв'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
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
              onPressed: () async {
                await _saveComment(); // Ждем завершения сохранения комментария
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
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
