class RatingModel {
  static const userName = "name";
  static const userIdConst = "user_id";
  static const productID = "product_id";
  static const reviewID = "review_id";
  static const userImage = "user_image";
  static const ratingDATE = "reviewer_date";
  static const ratingPercent = "rating";
  static const ratingDesc = "rating_description";

  String? reviewerName;
  String? reviewerImage;
  String? reviewId;
  String? userId;
  DateTime? date;
  String? productId;
  double? rating;
  String? description;

  RatingModel(
      {this.reviewerName,
        this.reviewerImage,
        this.productId,
        this.reviewId,
        this.userId,
        this.date,
        this.rating,
        this.description});

  RatingModel.fromMap(Map<String, dynamic> data){
    productId = data[productID];
    userId = data[userIdConst];
    reviewId = data[reviewID];
    reviewerName = data[userName];
    reviewerImage = data[userImage];
    date = data[ratingDATE].toDate();
    rating = data[ratingPercent];
    description = data[ratingDesc];
  }
}