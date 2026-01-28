import 'package:extremify/home_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState?.validate() == true) {
      // TODO: Отправка данных на сервер или БД
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Регистрация успешна!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text('Создать учётку', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _nicknameController,
                label: 'БОЕВОЙ КЛИЧ',
                icon: Icons.account_circle_outlined,
                validator: (v) => v == null || v.isEmpty ? 'Введите никнейм' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _emailController,
                label: 'ПОЧТА',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
                validator: (v) => _validateEmail(v),
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _dobController,
                label: 'ДР В ФОРМАТЕ ДЕНЬ/ЧИСЛО/МЕСЯЦ',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.datetime,
                validator: (v) => _validateDOB(v),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000, 1, 1),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    _dobController.text = "${date.day}/${date.month}/${date.year}";
                  }
                },
                readOnly: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _passwordController,
                label: 'ПАРОЛЬ',
                icon: Icons.lock_outline,
                obscureText: true,
                validator: (v) => v != null && v.length < 8
                    ? 'Минимум 8 символов'
                    : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _confirmController,
                label: 'ЕЩЕ РАЗ',
                icon: Icons.lock_outline,
                obscureText: true,
                validator: (v) =>
                    v != _passwordController.text ? 'Пароли не совпадают' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _register,
                  child: const Text('Далее', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('или', style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 12),
              _buildSocialButton(
                text: 'Продолжить с Facebook',
                icon: Icons.facebook,
                color: Colors.blue,
                onPressed: () { /* TODO: Facebook Auth */ },
              ),
              const SizedBox(height: 10),
              _buildSocialButton(
                text: 'Продолжить с Google',
                icon: Icons.g_mobiledata,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () { /* TODO: Google Auth */ },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('Назад на Главную'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function()? onTap,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: Icon(icon, color: Colors.white54),
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required IconData icon,
    required Color color,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        icon: Icon(icon, color: color, size: 28),
        label: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  String? _validateEmail(String? value) {
    final emailReg = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) return 'Введите email';
    if (!emailReg.hasMatch(value)) return 'Некорректный email';
    return null;
  }

  String? _validateDOB(String? value) {
    if (value == null || value.isEmpty) return 'Введите дату рождения';
    // Можно добавить более строгую проверку, если нужно
    return null;
  }
}