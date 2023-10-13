class ProductModel {
  String? id;
  String? sku;
  String? name;
  String? brandName;
  String? mainImage;
  PriceModel? price;
  List<dynamic>? sizes;
  String? stockStatus;
  String? colour;
  String? description;

  ProductModel({
    this.id,
    this.sku,
    this.name,
    this.brandName,
    this.mainImage,
    this.price,
    this.sizes,
    this.stockStatus,
    this.colour,
    this.description
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['SKU'];
    name = json['name'];
    brandName = json['brandName'];
    mainImage = json['mainImage'];
    price = PriceModel.fromJson(json['price']);
    sizes = json['sizes'].cast<String>();
    stockStatus = json['stockStatus'];
    colour = json['colour'];
    description = json['description'];
  }
}

class PriceModel {
  String? amount;
  String? currency;

  PriceModel({this.amount, this.currency});

  PriceModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }
}