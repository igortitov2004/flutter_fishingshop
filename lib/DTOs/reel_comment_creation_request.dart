class ReelCommentCreationRequest {
  final int reelId;
  final String content;
  final int rating;

  ReelCommentCreationRequest({
    required this.reelId,
    required this.content,
    required this.rating,
  });

  Map<String, dynamic> toMap(ReelCommentCreationRequest request) {
    return {
      'reelId': reelId,
      'content': content,
      'rating': rating,
    };
  }
}