class PublicApiModel {
  int? id;
  String? brand;
  String? name;
  String? price;
  String? priceSign;
  String? currency;
  String? imageLink;
  String? productLink;
  String? websiteLink;
  String? description;
  String? category;
  String? productType;
  List<String>? tagList;
  String? createdAt;
  String? updatedAt;
  String? productApiUrl;
  String? apiFeaturedImage;
  List<ProductColors>? productColors;

  PublicApiModel(
      {this.id,
      this.brand,
      this.name,
      this.price,
      this.priceSign,
      this.currency,
      this.imageLink,
      this.productLink,
      this.websiteLink,
      this.description,
      this.category,
      this.productType,
      this.tagList,
      this.createdAt,
      this.updatedAt,
      this.productApiUrl,
      this.apiFeaturedImage,
      this.productColors});

  PublicApiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    name = json['name'];
    price = json['price'];
    priceSign = json['price_sign'];
    currency = json['currency'];
    imageLink = json['image_link'];
    productLink = json['product_link'];
    websiteLink = json['website_link'];
    description = json['description'];
    category = json['category'];
    productType = json['product_type'];
    tagList = json['tag_list'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productApiUrl = json['product_api_url'];
    apiFeaturedImage = json['api_featured_image'];
    if (json['product_colors'] != null) {
      productColors = <ProductColors>[];
      json['product_colors'].forEach((v) {
        productColors!.add(ProductColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand'] = brand;
    data['name'] = name;
    data['price'] = price;
    data['price_sign'] = priceSign;
    data['currency'] = currency;
    data['image_link'] = imageLink;
    data['product_link'] = productLink;
    data['website_link'] = websiteLink;
    data['description'] = description;
    data['category'] = category;
    data['product_type'] = productType;
    data['tag_list'] = tagList;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product_api_url'] = productApiUrl;
    data['api_featured_image'] = apiFeaturedImage;
    if (productColors != null) {
      data['product_colors'] = productColors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductColors {
  String? hexValue;
  String? colourName;

  ProductColors({this.hexValue, this.colourName});

  ProductColors.fromJson(Map<String, dynamic> json) {
    hexValue = json['hex_value'];
    colourName = json['colour_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hex_value'] = hexValue;
    data['colour_name'] = colourName;
    return data;
  }
}
