
class ProductVariantMedia
{
  String MediaId;

  ProductVariantMedia({
    this.MediaId,
  });

  factory ProductVariantMedia.fromJson(Map<String, dynamic> parsedData) {
    return ProductVariantMedia(
      MediaId: parsedData['MediaId']
    );
  }

  static List<ProductVariantMedia> parseList(listData) {
    var list = listData as List;
    List<ProductVariantMedia> jobList =
    list.map((data) => ProductVariantMedia.fromJson(data)).toList();
    return jobList;
  }
}