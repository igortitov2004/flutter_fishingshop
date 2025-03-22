import 'package:fishingshop/model/user.dart';

class RodComment{
  int id;
  String content;
  double rating;
  User user;

  RodComment({
    required this.id,
    required this.content,
    required this.rating,
    required this.user
  });

    factory RodComment.fromMap(Map rodContentMap){
    return RodComment(
      id: rodContentMap['id'],
      content: rodContentMap['content'],
      rating: rodContentMap['rating'],
      user: User.fromMap(rodContentMap['user']),
      );
  }
}