class Product {
  final String type;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.type,
  });

  static List<Product> products = [
    Product(
      type: "bronzer",
      name: "Maybelline Face Studio Master Hi-Light Light Booster Bronzer",
      price: 14.99,
      imageUrl:
          "https://d3t32hsnjxo7q6.cloudfront.net/i/991799d3e70b8856686979f8ff6dcfe0_ra,w158,h184_pa,w158,h184.png",
    ),
    Product(
      type: "lip_liner",
      name: "Lippie Pencil",
      price: 5.0,
      imageUrl:
          "https://cdn.shopify.com/s/files/1/1338/0845/collections/lippie-pencil_grande.jpg?v=1512588769",
    ),
    Product(
      type: "lipstick",
      name: "Blotted Lip",
      price: 5.5,
      imageUrl:
          "https://cdn.shopify.com/s/files/1/1338/0845/products/brain-freeze_a_800x1200.jpg?v=1502255076",
    ),
    Product(
      type: "foundation",
      name: "Maybelline Superstay Better Skin Foundation",
      price: 14.99,
      imageUrl:
          "https://d3t32hsnjxo7q6.cloudfront.net/i/c7d967ef502ecd79ab7ab466c4952d82_ra,w158,h184_pa,w158,h184.png",
    ),
    Product(
      type: "foundation",
      name: "Maybelline Dream Wonder Liquid Touch Foundation",
      price: 14.99,
      imageUrl:
          "https://d3t32hsnjxo7q6.cloudfront.net/i/ccb99ad6ac7f31a2a73454bdbda01d99_ra,w158,h184_pa,w158,h184.jpeg",
    ),
    Product(
      type: "eyeshadow",
      name: "Maybelline Eye Studio Color Tattoo 24HR Cream Gel Shadow",
      price: 8.99,
      imageUrl:
          "https://d3t32hsnjxo7q6.cloudfront.net/i/c2ddacc79f4fdd3d23664581c76546bc_ra,w158,h184_pa,w158,h184.png",
    ),
    Product(
      type: "mascara",
      name: "Maybelline Great Lash Mascara",
      price: 7.79,
      imageUrl:
          "https://d3t32hsnjxo7q6.cloudfront.net/i/6b4d354890177a73b4d6630d723c2f21_ra,w158,h184_pa,w158,h184.jpeg",
    ),
    Product(
      type: "eyeshadow",
      name: "Maybelline The Nudes Eye Shadow Palette",
      price: 17.99,
      imageUrl:
          "https://d3t32hsnjxo7q6.cloudfront.net/i/201350fd3e173307ade44520dc87d8fb_ra,w158,h184_pa,w158,h184.png",
    ),
    Product(
      type: "mascara",
      name: "Maybelline Volum'Express the Falsies Mascara",
      price: 9.79,
      imageUrl:
          "https://d3t32hsnjxo7q6.cloudfront.net/i/af1f35f15ee64cc1003f1ccfc6451d71_ra,w158,h184_pa,w158,h184.jpeg",
    ),
    Product(
      type: "lipstick",
      name: "Maybelline Color Sensational Rebel Bloom Lipcolour",
      price: 9.99,
      imageUrl:
          "https://d3t32hsnjxo7q6.cloudfront.net/i/fb9e6485500135d94163577da4c3579b_ra,w158,h184_pa,w158,h184.png",
    ),
  ];
}
