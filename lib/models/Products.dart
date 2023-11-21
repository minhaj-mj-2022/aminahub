class Product {
  final int id;
  final String title, description, contactInfo;
  final List<String> images;
  final double rating, price;
  final bool isFavourite, isPopular;


  Product({
    required this.id,
    required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.contactInfo,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/car_rental_2.png",
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: "Introducing our cutting-edge Wireless Controller for PS4 - the ultimate gaming accessory "
        "for an immersive and responsive gaming experience.Key Features:Seamless Connectivity: Our wireless "
        "controller pairs effortlessly with your PS4 console, ensuring lag-free gaming sessions.Ergonomic Design: Designed with gamers in mind, our controller offers a comfortable grip, making it ideal for extended gaming sessions.Precision Control: Experience precise control and accuracy with the responsive analog sticks and trigger buttons.Built-in Motion Sensors: Enjoy an enhanced gaming experience with the built-in motion sensors, offering a new dimension of interaction in compatible games.Touchpad Integration: The integrated touchpad allows for quick and intuitive in-game navigation and control.Rechargeable Battery: Say goodbye to constantly replacing batteries. Our controller features a rechargeable battery, keeping you in the game for hours on end.Customizable LED Light Bar: Personalize your gaming experience with the customizable LED light bar, adding a touch of uniqueness to your controller.Immersive Audio: Plug in your headset and enjoy in-game audio like never before with the built-in 3.5mm audio jack.",
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
    contactInfo: contactInfo,

  ),
  Product(
    id: 2,
    images: [
      "assets/images/car_rental.png",
      "assets/images/Image Popular Product 2.png",
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: "fdsdf",
    rating: 4.1,
    isPopular: true,
    contactInfo: contactInfo,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/car_rental.png",
      "assets/images/glap.png",
    ],
    title: "Gloves XC Omega - Polygon Gloves XC Omega - PolygonGloves XC Omega - PolygonGloves XC Omega - PolygonGloves XC Omega - Polygon",
    price: 36.55,
    description: "dfsf",
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
    contactInfo: contactInfo,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/wireless headset.png",
    ],
    title: "Logitech Head",
    price: 20.20,
    description: "fdfs",
    rating: 4.1,
    isFavourite: true,
    contactInfo: contactInfo,
  ),
];

const String contactInfo = "Shop Name: Tech Haven Electronics Phone Number: +1 (555) 123-4567 Street Address: 123 Main Street City: Anytown State: CA Country: United States";
