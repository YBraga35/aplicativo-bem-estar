import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '/routes/routes.dart';
import '../../controllers/authenticate_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final AuthenticateController _autenticacaoControle = AuthenticateController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final MaskedTextController _telefoneController = MaskedTextController(mask: '(00) 00000-0000');
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedPronome;
  double _passwordStrength = 0;

  final List<String> _pronomesOptions = ['Ele/Dele', 'Ela/Dela', 'Elu/Delu'];

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _idadeController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
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

  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (_senhaController.text != _confirmarSenhaController.text) {
        setState(() {
          _errorMessage = 'As senhas não coincidem';
        });
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        String? errorMessage = await _autenticacaoControle.signUpUsers(
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
      } catch (error) {
        setState(() {
          _errorMessage = 'Erro ao criar conta. Tente novamente.';
          _isLoading = false;
        });
      }
    }
  }

  void _showTermsOfUse() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Termos de Uso'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Bem-vindo ao Zenjourney, um aplicativo dedicado ao bem-estar e saúde mental. '
                'Ao utilizar nosso aplicativo, você concorda com os seguintes termos de uso:\n\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '1. Uso do Aplicativo\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'O Zenjourney é destinado a fornecer ferramentas e recursos para ajudar no bem-estar mental. '
                'Não substitui o aconselhamento profissional ou tratamento médico. Sempre consulte um profissional de saúde qualificado para quaisquer questões de saúde.\n\n',
              ),
              Text(
                '2. Conta de Usuário\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Você deve fornecer informações precisas e completas ao criar uma conta. Você é responsável por manter a confidencialidade de sua senha e por todas as atividades que ocorrem sob sua conta.\n\n',
              ),
              Text(
                '3. Privacidade\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Respeitamos sua privacidade e estamos comprometidos em proteger suas informações pessoais. Consulte nossa Política de Privacidade para obter mais detalhes sobre como coletamos, usamos e protegemos suas informações.\n\n',
              ),
              Text(
                '4. Conteúdo do Usuário\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Você é responsável pelo conteúdo que publica no Zenjourney. Não publique conteúdo que seja ofensivo, ilegal ou que viole os direitos de terceiros.\n\n',
              ),
              Text(
                '5. Limitação de Responsabilidade\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'O Zenjourney não se responsabiliza por quaisquer danos diretos, indiretos, incidentais ou consequenciais resultantes do uso ou da incapacidade de usar o aplicativo.\n\n',
              ),
              Text(
                '6. Modificações nos Termos\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Podemos modificar estes termos de uso a qualquer momento. Notificaremos você sobre quaisquer alterações significativas. O uso continuado do aplicativo após tais alterações constitui sua aceitação dos novos termos.\n\n',
              ),
              Text(
                '7. Encerramento\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Podemos encerrar ou suspender sua conta a qualquer momento, sem aviso prévio, se você violar estes termos de uso.\n\n',
              ),
              Text(
                '8. Contato\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Se você tiver alguma dúvida sobre estes termos de uso, entre em contato conosco através do suporte@zenjourney.com.\n\n',
              ),
              Text(
                'Obrigado por usar o Zenjourney. Esperamos que nosso aplicativo ajude você a alcançar um maior bem-estar mental.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F9),
      appBar: AppBar(
        title: const Text(
          'Zenjourney',
          style: TextStyle(
            fontSize: 36,
            fontFamily: 'Tangerine',
            fontWeight: FontWeight.bold,
            color: Color(0xFF193339),
          ),
        ),
        backgroundColor: const Color(0xFFF1F7F9),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              width: screenWidth * 0.95, // Aumentando a largura da caixa
              height: screenHeight * 0.95, // Aumentando a altura da caixa
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Cadastro',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF448D9C),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Crie sua conta para começar sua jornada',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF193339),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: const TextStyle(fontFamily: 'Raleway', color: Color(0xFF193339)),
                        prefixIcon: const Icon(Icons.person, color: Color(0xFF193339)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu nome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: const TextStyle(fontFamily: 'Raleway', color: Color(0xFF193339)),
                        prefixIcon: const Icon(Icons.email, color: Color(0xFF193339)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu e-mail';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _telefoneController,
                      decoration: InputDecoration(
                        labelText: 'Telefone',
                        labelStyle: const TextStyle(fontFamily: 'Raleway', color: Color(0xFF193339)),
                        prefixIcon: const Icon(Icons.phone, color: Color(0xFF193339)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu telefone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
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
                        prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF193339)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione seu pronome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _idadeController,
                      decoration: InputDecoration(
                        labelText: 'Idade',
                        labelStyle: const TextStyle(fontFamily: 'Raleway', color: Color(0xFF193339)),
                        prefixIcon: const Icon(Icons.cake, color: Color(0xFF193339)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua idade';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _senhaController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: const TextStyle(fontFamily: 'Raleway', color: Color(0xFF193339)),
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFF193339)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _passwordStrength = _calculatePasswordStrength(value);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _passwordStrength,
                      backgroundColor: Colors.grey[300],
                      color: _passwordStrength > 0.7
                          ? Colors.green
                          : _passwordStrength > 0.4
                              ? Colors.orange
                              : Colors.red,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmarSenhaController,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Senha',
                        labelStyle: const TextStyle(fontFamily: 'Raleway', color: Color(0xFF193339)),
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFF193339)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, confirme sua senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      SizedBox(
                        width: 310,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF448D9C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Ao criar sua conta você concorda com os ',
                              style: TextStyle(
                                fontSize: 14, // Reduzindo o tamanho da fonte
                                color: Color(0xFF448D9C),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              onTap: _showTermsOfUse,
                              child: const Text(
                                'termos de uso',
                                style: TextStyle(
                                  fontSize: 14, // Reduzindo o tamanho da fonte
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF448D9C),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}