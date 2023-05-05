class CategoryModel{
  static const cateName = "category_name";
  static const cateId = "category_id";
  static const uId = "user_id";
  String? categoryName;
  String? categoryId;
  String? userId;
  CategoryModel({
    this.categoryName,
    this.categoryId,
    this.userId
  });

  CategoryModel.fromMap(Map<String, dynamic> data){
    categoryName = data[cateName];
    categoryId = data[cateId];
    userId = data[uId];
  }
  toJson() {
    return {
      cateId:categoryId,
      cateName:categoryName,
    };
  }
}