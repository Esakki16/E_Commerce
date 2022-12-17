import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  Widget buildProductPhoto() {
    return SizedBox(
      // height: 400,
      width: double.infinity,
      child: Image.asset(
        'assets/Rectangle.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildShareHeartIcon() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset: Offset(0, 1))
                ]),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/Icon ionic-ios-heart.png',
              ),
              iconSize: 28,
            )),
        Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset: Offset(0, 1))
                ]),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/Icon awesome-share.png',
              ),
              iconSize: 28,
            )),
      ],
    );
  }

  Widget buildDetailText() {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Eyevy',
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            'Full Rim Round,Cat-eyed Anti Glare Frame(48mm)',
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: '₹219  ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34)),
            TextSpan(
                text: '₹999',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough)),
            TextSpan(
                text: '  78% off ',
                style: TextStyle(color: Colors.green, fontSize: 28))
          ]))
        ],
      ),
    );
  }

  Widget buildBottomButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            color: Color.fromARGB(255, 214, 214, 214).withOpacity(0.3),
            child: const Center(
                child: Text(
              'ADD TO CART',
            )),
          ),
        ),
        Expanded(
          child: Container(
            height: 70,
            color: Colors.orange,
            child: const Center(
                child: Text(
              'BUY NOW',
              style: TextStyle(color: Colors.black),
            )),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                buildProductPhoto(),
                buildShareHeartIcon(),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          buildDetailText(),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildBottomButton(),
          ),
        ],
      ),
    );
  }
}
