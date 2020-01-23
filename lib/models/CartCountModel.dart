
class CartCountModel
{
  int count;

  CartCountModel({
    this.count
  });

  factory CartCountModel.fromJson(Map<String, dynamic> parsedData) {
    return CartCountModel(
      count: parsedData['count'],
    );
  }
}