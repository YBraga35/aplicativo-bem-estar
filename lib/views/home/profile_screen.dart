import 'package:flutter/material.dart';
import '/routes/routes.dart'; // Certifique-se de que o AppRoutes está corretamente importado

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Lista de ícones para seleção de avatar
  final List<IconData> _avatarOptions = [
    Icons.person,
    Icons.person_outline,
    Icons.face,
    Icons.account_circle,
    Icons.accessibility_new,
  ];

  // Ícone selecionado como avatar
  IconData _selectedAvatar = Icons.person;

  // Lista de mensagens simuladas
  final List<Message> _messages = [
    Message(
      sender: 'Admin',
      content: 'Bem-vindo ao aplicativo!',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      isRead: true,
    ),
    Message(
      sender: 'Suporte',
      content: 'Como podemos ajudar você hoje?',
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      isRead: false,
    ),
    Message(
      sender: 'Promoções',
      content: 'Confira nossas novas ofertas exclusivas.',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      isRead: false,
    ),
  ];

  // Lista de conquistas do usuário
  final List<Achievement> _achievements = [
    Achievement(
      title: 'Primeiro Login',
      description: 'Você fez o primeiro login no aplicativo.',
      icon: Icons.login,
    ),
    Achievement(
      title: 'Conquistador',
      description: 'Completar todas as tarefas diárias por uma semana.',
      icon: Icons.star,
    ),
    Achievement(
      title: 'Explorer',
      description: 'Explorar todas as seções do aplicativo.',
      icon: Icons.explore,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe0e6ea),
      body: SingleChildScrollView( // Permite rolagem caso o conteúdo exceda a tela
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // Margin top maior
              Center(
                child: const Text(
                  'Meu Perfil',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF448D9C),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Aqui você pode ver e editar suas informações de perfil.',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF193339),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  _showAchievementsModal(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Abrir modal para selecionar avatar
                          _showAvatarSelectionModal(context);
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: const Color(0xFF448D9C),
                          child: Icon(
                            _selectedAvatar,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Nome do Usuário',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF193339),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Pronomes',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF193339),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.emoji_events,
                        color: Color(0xFF448D9C),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  _buildButton(context, 'Editar Perfil', () {
                    _showEditProfileModal(context);
                  }),
                  _buildButton(context, 'Configurações e Preferências', () {
                    _showSettingsModal(context);
                  }),
                  _buildButton(context, 'Inbox', () {
                    _showInboxModal(context);
                  }),
                  _buildButton(context, 'Sair', () {
                    Navigator.pushReplacementNamed(context, AppRoutes.authenticate);
                  }),
                  _buildButton(context, 'Excluir Conta', () {
                    _showDeleteAccountConfirmation(context);
                  }, isDelete: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir os botões
  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed, {bool isDelete = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity, // Centraliza os botões e utiliza toda a largura disponível
        height: 66,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDelete ? const Color(0xFFCE6868) : const Color(0xFFFFF9F9),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: isDelete ? 4 : 2,
            side: BorderSide.none, // Removido o contorno dos botões
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
              color: isDelete ? Colors.white : const Color(0xFF193339),
            ),
          ),
        ),
      ),
    );
  }

  // Modal para seleção de avatar
  void _showAvatarSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Selecione um Avatar',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF448D9C),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: _avatarOptions.map((iconData) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = iconData;
                      });
                      Navigator.pop(ctx);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: _selectedAvatar == iconData
                          ? const Color(0xFF448D9C)
                          : Colors.grey[200],
                      child: Icon(
                        iconData,
                        size: 30,
                        color: _selectedAvatar == iconData
                            ? Colors.white
                            : const Color(0xFF193339),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  // Modal para editar perfil
  void _showEditProfileModal(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _pronounsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Para que o modal ocupe mais espaço
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Editar Perfil',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF448D9C),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _pronounsController,
                  decoration: const InputDecoration(
                    labelText: 'Pronomes',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Implementar lógica para salvar as alterações
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Perfil atualizado com sucesso!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF448D9C),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // Modal para configurações e preferências
  void _showSettingsModal(BuildContext context) {
    bool _notificationsEnabled = true;
    String _selectedLanguage = 'Português';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Configurações e Preferências',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF448D9C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: const Text(
                      'Notificações',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Raleway',
                        color: Color(0xFF193339),
                      ),
                    ),
                    value: _notificationsEnabled,
                    activeColor: const Color(0xFF448D9C),
                    onChanged: (bool value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language, color: Color(0xFF193339)),
                    title: const Text(
                      'Idioma',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Raleway',
                        color: Color(0xFF193339),
                      ),
                    ),
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      items: <String>['Português', 'Inglês', 'Espanhol']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                color: Color(0xFF193339),
                              )),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Implementar lógica para salvar as configurações
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Configurações atualizadas!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF448D9C),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Modal para Inbox
  void _showInboxModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Inbox',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF448D9C),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _messages.isEmpty
                    ? const Text(
                        'Nenhuma mensagem nova.',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                          color: Color(0xFF193339),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: message.isRead
                                  ? const Color(0xFF448D9C)
                                  : const Color(0xFFFFA500),
                              child: Icon(
                                message.isRead ? Icons.mark_email_read : Icons.mark_email_unread,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              message.sender,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF193339),
                              ),
                            ),
                            subtitle: Text(
                              message.content,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                color: Color(0xFF193339),
                              ),
                            ),
                            trailing: Text(
                              _formatTimestamp(message.timestamp),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Raleway',
                                color: Color(0xFF193339),
                              ),
                            ),
                            onTap: () {
                              _openMessageDetail(context, message);
                            },
                          );
                        },
                      ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF448D9C),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Método para mostrar as conquistas do usuário
  void _showAchievementsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true, // Permite que o modal ocupe mais espaço se necessário
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Suas Conquistas',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF448D9C),
                ),
              ),
              const SizedBox(height: 20),
              _achievements.isEmpty
                  ? const Text(
                      'Você ainda não tem conquistas.',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Raleway',
                        color: Color(0xFF193339),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _achievements.length,
                      itemBuilder: (context, index) {
                        final achievement = _achievements[index];
                        return ListTile(
                          leading: Icon(
                            achievement.icon,
                            color: const Color(0xFF448D9C),
                            size: 30,
                          ),
                          title: Text(
                            achievement.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF193339),
                            ),
                          ),
                          subtitle: Text(
                            achievement.description,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Raleway',
                              color: Color(0xFF193339),
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF448D9C),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Modal de confirmação para excluir conta
  void _showDeleteAccountConfirmation(BuildContext context) {
    bool _isFirstConfirmation = true;

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                'Excluir Conta',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCE6868),
                ),
              ),
              content: _isFirstConfirmation
                  ? const Text(
                      'Tem certeza de que deseja excluir sua conta? Este processo não pode ser desfeito.',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Color(0xFF193339),
                      ),
                    )
                  : const Text(
                      'Por favor, confirme novamente que deseja excluir sua conta.',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Color(0xFF193339),
                      ),
                    ),
              actions: [
                TextButton(
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Color(0xFF193339),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                TextButton(
                  child: _isFirstConfirmation
                      ? const Text(
                          'Confirmar',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Color(0xFFCE6868),
                          ),
                        )
                      : const Text(
                          'Excluir',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Color(0xFFCE6868),
                          ),
                        ),
                  onPressed: () {
                    if (_isFirstConfirmation) {
                      setState(() {
                        _isFirstConfirmation = false;
                      });
                    } else {
                      Navigator.of(ctx).pop();
                      // TODO: Implementar funcionalidade de exclusão quando o banco estiver pronto
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Conta excluída (simulação).')),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Função para formatar timestamp
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  // Função para abrir detalhes da mensagem
  void _openMessageDetail(BuildContext context, Message message) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            message.sender,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Color(0xFF193339),
            ),
          ),
          content: Text(
            message.content,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Raleway',
              color: Color(0xFF193339),
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Fechar',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Color(0xFF448D9C),
                ),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );

    // Marcar mensagem como lida
    setState(() {
      message.isRead = true;
    });
  }
}

// Modelo de mensagem
class Message {
  final String sender;
  final String content;
  final DateTime timestamp;
  bool isRead;

  Message({
    required this.sender,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });
}

// Modelo de conquista
class Achievement {
  final String title;
  final String description;
  final IconData icon;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
  });
}