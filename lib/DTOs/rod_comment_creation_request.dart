class RodCommentCreationRequest {
  final int rodId;
  final String content;
  final int rating;

  RodCommentCreationRequest({
    required this.rodId,
    required this.content,
    required this.rating,
  });

  Map<String, dynamic> toMap(RodCommentCreationRequest request) {
    return {
      'rodId': rodId,
      'content': content,
      'rating': rating,
    };
  }
}