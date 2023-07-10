import 'package:e_mart/consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: "Cart is Empty My boy!".text.fontFamily(semibold).color(darkFontGrey).makeCentered(),
    );
  }
}
