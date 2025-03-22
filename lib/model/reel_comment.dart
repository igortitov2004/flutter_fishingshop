import 'package:fishingshop/model/user.dart';

class ReelComment{
  int id;
  String content;
  double rating;
  User user;

  ReelComment({
    required this.id,
    required this.content,
    required this.rating,
    required this.user
  });

    factory ReelComment.fromMap(Map reelContentMap){
    return ReelComment(
      id: reelContentMap['id'],
      content: reelContentMap['content'],
      rating: reelContentMap['rating'],
      user: User.fromMap(reelContentMap['user']),
      );
  }
}