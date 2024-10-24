import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '/routes/routes.dart';
import '/controllers/autenticacao_controle.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final AutenticacaoControle _autenticacaoControle = AutenticacaoControle();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final MaskedTextController _telefoneController = MaskedTextController(mask: '(00) 00000-0000');
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedPronome;
  double _passwordStrength = 0;

  final List<String> _pronomesOptions = ['Ele/Dele', 'Ela/Dela', 'Elu/Delu'];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F9),
      appBar: AppBar(
        title: const Text(
          'Zen Journey',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF193339),
          ),
        ),
        backgroundColor: const Color(0xFFF1F7F9),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 55),
                Container(
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 3.0),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Cadastro',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF193339),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Crie sua conta para começar sua jornada',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF448D9C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _telefoneController,
                        decoration: InputDecoration(
                          labelText: 'Telefone',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedPronome,
                        hint: const Text('Selecione seu pronome'),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedPronome = newValue;
                          });
                        },
                        items: _pronomesOptions.map((String pronome) {
                          return DropdownMenuItem<String>(
                            value: pronome,
                            child: Text(pronome),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _idadeController,
                        decoration: InputDecoration(
                          labelText: 'Idade',
                          prefixIcon: const Icon(Icons.cake),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _senhaController,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _passwordStrength = _calculatePasswordStrength(value);
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: _passwordStrength,
                        backgroundColor: Colors.grey[300],
                        color: _passwordStrength > 0.7
                            ? Colors.green
                            : _passwordStrength > 0.4
                                ? Colors.orange
                                : Colors.red,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _confirmarSenhaController,
                        decoration: InputDecoration(
                          labelText: 'Confirmar Senha',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      if (_isLoading)
                        const Center(child: CircularProgressIndicator())
                      else ...[
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_senhaController.text != _confirmarSenhaController.text) {
                                setState(() {
                                  _errorMessage = 'As senhas não coincidem';
                                });
                                return;
                              }
                              setState(() {
                                _isLoading = true;
                              });
                              String? errorMessage = await _autenticacaoControle.cadastrarUsuario(
                                nome: _nomeController.text,
                                email: _emailController.text,
                                telefone: _telefoneController.text,
                                pronomes: _selectedPronome ?? '',
                                idade: int.tryParse(_idadeController.text) ?? 0,
                                senha: _senhaController.text,
                              );
                              setState(() {
                                _isLoading = false;
                                _errorMessage = errorMessage;
                              });
                              if (errorMessage == null) {
                                Navigator.pushNamed(context, AppRoutes.trailPreference);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.2,
                                vertical: 15,
                              ),
                              backgroundColor: const Color(0xFF448D9C),
                            ),
                            child: const Text(
                              'Criar conta',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Ao criar uma conta, você pode manter seu progresso e personalizar sua jornada.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF448D9C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) {
      return 0;
    } else if (password.length < 6) {
      return 0.1;
    } else if (password.length < 8) {
      return 0.3;
    } else if (password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 1.0;
    } else {
      return 0.7;
    }
  }
}