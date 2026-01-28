import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final tabs = ['ВСЁ', 'ФУТБОЛКИ', 'ХУДИ', 'АКСЕССУАРЫ', 'НАШИВКИ'];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildLogoSection(),
            const SizedBox(height: 12),
            _buildTabBar(),
            Expanded(child: _buildTabViews()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.menu, color: Colors.white),
          const Spacer(),
          Icon(Icons.shopping_cart_checkout, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Image.asset('assets/extremify_logo.png', height: 64), // Вы свой путь иконки используете!
        const SizedBox(height: 12),
        const Text(
          'Премиум-мерч под экстремальный метал. Кастомные дизайны. Брутальное качество. Снарядись для апокалипсиса.',
          style: TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _redButton('ЗАКУПИТЬСЯ', onTap: () {
              // TODO: Навигация/фильтр
            }),
            const SizedBox(width: 10),
            _redButton('КАСТОМИЗАЦИЯ', onTap: () {
              // TODO: Навигация/фильтр
            }),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  Widget _redButton(String text, {required VoidCallback onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      child: Text(text),
    );
  }

  Widget _buildTabBar() {
    return Material(
      color: Colors.transparent,
      child: TabBar(
        controller: _tabController,
        tabs: tabs.map((label) => Tab(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)))).toList(),
        indicatorColor: Colors.red,
        indicatorWeight: 3,
        labelColor: Colors.red,
        unselectedLabelColor: Colors.white,
        isScrollable: true,
      ),
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      controller: _tabController,
      children: tabs.map((String category) {
        return _buildProductGrid(category);
      }).toList(),
    );
  }

  Widget _buildProductGrid(String category) {
    // Здесь можно фильтровать товары по категории, сейчас для примера карточки одинаковые
    final products = [
      {
        'title': 'DEATH METAL LOGO TEE',
        'price': '29.99',
        'image': 'assets/p1.png',
        'type': 'T-SHIRTS',
        'customizable': true,
      },
      {
        'title': 'BRUTAL HOODIE',
        'price': '59.99',
        'image': 'assets/p2.png',
        'type': 'HOODIES',
        'customizable': true,
      },
      {
        'title': 'SKULL CHAIN NECKLACE',
        'price': '34.99',
        'image': 'assets/p3.png',
        'type': 'ACCESSORIES',
        'customizable': false,
      },
      {
        'title': 'METAL BAND PATCH',
        'price': '12.99',
        'image': 'assets/p4.png',
        'type': 'PATCHES',
        'customizable': true,
      },
    ];
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    child: Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.64,
          ),
          itemBuilder: (context, i) => _buildProductCard(products[i]),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onPressed: () {/* TODO: подгрузка новых товаров */},
            child: const Text('LOAD MORE MERCH'),
          ),
        ),
      ],
    ),
  );
  }
  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF181A20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(product['image'], height: 110, fit: BoxFit.cover),
              ),
              if (product['customizable'])
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('CUSTOM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product['title'],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 2,
                ),
                const SizedBox(height: 3),
                Text(
                  '\$${product['price']}',
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w900, fontSize: 16),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () { /* TODO: В корзину */ },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          minimumSize: const Size(0, 33),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                        ),
                        child: const Text('ADD TO CART', style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    const SizedBox(width: 7),
                    if (product['customizable'])
                      ElevatedButton(
                        onPressed: () { /* TODO: Кастомизация */ },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white12,
                          minimumSize: const Size(0, 33),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                        ),
                        child: const Text('CUSTOM', style: TextStyle(fontSize: 11, color: Colors.white)),
                      ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EventsSection extends StatelessWidget {
  const EventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: 'МЕТАЛ ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26, letterSpacing: 0.5)),
              TextSpan(text: 'ИВЕНТЫ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 26, letterSpacing: 0.5)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Увидь повелителей хаоса. Прочувствуй эту мощь',
          style: TextStyle(color: Colors.white70, fontSize: 13),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Список/сетка событий
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _EventCard(
                name: 'DEATH STORM FESTIVAL',
                subtitle: 'Разные коллективы',
                date: '15.03.2025, СБ',
                place: 'Metal Arena, Los Angeles, CA',
                time: '18:00',
                price: '\$89.99',
                tag: 'ДЭТ-МЕТАЛ',
                tagColor: Colors.red,
                available: true,
              ),
              const SizedBox(width: 14),
              _EventCard(
                name: 'BLACKENED SOULS TOUR',
                subtitle: 'Darknight Legion',
                date: '02.04.2025, СР',
                place: 'Underground Club, Chicago, IL',
                time: '20:00',
                price: '\$45',
                tag: 'БЛЭК-МЕТАЛ',
                tagColor: Colors.green,
                available: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 34),
          ),
          onPressed: () { /* TODO: переход к списку событий */ },
          child: const Text('ВСЕ ИВЕНТЫ', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  final String name, subtitle, date, place, time, price, tag;
  final Color tagColor;
  final bool available;

  const _EventCard({
    required this.name,
    required this.subtitle,
    required this.date,
    required this.place,
    required this.time,
    required this.price,
    required this.tag,
    required this.tagColor,
    this.available = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 265,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF22232A),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 15, 13, 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: tagColor,
              ),
              child: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 9),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.white54, size: 15),
                const SizedBox(width: 8),
                Text(date, style: const TextStyle(color: Colors.white54, fontSize: 13)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.place, color: Colors.white54, size: 15),
                const SizedBox(width: 8),
                Text(place, style: const TextStyle(color: Colors.white54, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 8),
            Text('От $price', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 3),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: available ? Colors.red : Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                ),
                onPressed: available ? () {} : null,
                child: Text(available ? 'БИЛЕТЫ' : 'ПРОДАНО', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Divider(color: Colors.white12),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Лого и копирайт
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Логотип
                    Text(
                      'Extremify',
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        fontFamily: 'monospace',
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Качество, которое переживёт апокалипсис',
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(Icons.facebook, color: Colors.white54, size: 20),
                        const SizedBox(width: 7),
                        Icon(FontAwesomeIcons.instagram, color: Colors.white54, size: 20),
                        const SizedBox(width: 7),
                        Icon(Icons.mail_outline, color: Colors.white54, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
              // Быстрые ссылки
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('БЫСТРЫЕ ССЫЛКИ', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                    SizedBox(height: 6),
                    Text('Shop Merch\nCustomize Gear\nEvents & Shows\nFeatured Bands\nAbout Us',
                      style: TextStyle(color: Colors.white54, fontSize: 11)),
                  ],
                ),
              ),
              // Поддержка
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('ПОДДЕРЖКА', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                    SizedBox(height: 6),
                    Text('Гайд по размерам\nПо доставке\nВозврат и обмен\nИнструкции по уходу\nНаписать поддержке',
                      style: TextStyle(color: Colors.white54, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Форма подписки
          const SubscribeSection(),
          const SizedBox(height: 11),
          const Text(
            '© 2026 Extremify. Все права защищены.',
            style: TextStyle(color: Colors.white24, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SubscribeSection extends StatelessWidget {
  const SubscribeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'СТАНЬ ТРУЩНЕЕ',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900, fontSize: 15),
        ),
        const SizedBox(height: 3),
        const Text(
          'Ограниченные серии, скидки и\nуведомления о концертах',
          style: TextStyle(color: Colors.white54, fontSize: 11),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Твой e-mail',
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 13),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 7),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(50, 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
              ),
              onPressed: () {}, // TODO: обработка подписки
              child: const Text('ПОДПИСАТЬСЯ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
            )
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Уведомления в любое время, конфиденциальность уважаем',
          style: TextStyle(color: Colors.white30, fontSize: 9),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}