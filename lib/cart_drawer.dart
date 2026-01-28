import 'package:flutter/material.dart';

void showCartDrawer(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Cart",
    barrierColor: Colors.black54, // затемнение вне корзины
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox.shrink(); // не используется
    },
    transitionBuilder: (context, anim1, anim2, child) {
      final double slide = 1 - anim1.value;
      return Align(
        alignment: Alignment.centerRight,
        child: FractionalTranslation(
          translation: Offset(slide, 0),
          child: CartDrawer(),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 350),
  );
}

class CartDrawer extends StatelessWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.78; // ширина "столбиком"
    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        height: double.infinity,
        color: const Color(0xFF1C1D22),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Верхняя панель с заголовком и "Закрыть"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'КОРЗИНА (0)',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Закрыть корзину',
                ),
              ],
            ),
            const SizedBox(height: 36),
            // Содержимое корзины (пример - пуста)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_cart_outlined, size: 90, color: Colors.white24),
                    const SizedBox(height: 24),
                    const Text(
                      "КОРЗИНА ПОКА ПУСТА",
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w900,
                          fontSize: 22
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Добавь что-нибудь и пробуди хаос",
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // Кнопка "Continue shopping"
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('ПРОДОЛЖИТЬ ВООРУЖЕНИЕ'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}