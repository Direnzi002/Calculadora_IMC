import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginaCalculadoraIMC(),
    );
  }
}

class PaginaCalculadoraIMC extends StatefulWidget {
  @override
  _PaginaCalculadoraIMCState createState() => _PaginaCalculadoraIMCState();
}

class _PaginaCalculadoraIMCState extends State<PaginaCalculadoraIMC> {
  final TextEditingController _controladorPeso = TextEditingController();
  final TextEditingController _controladorAltura = TextEditingController();
  bool _campoSelecionadoPeso = true; // Controla qual campo está selecionado
  String _resultadoIMC = ''; // Armazena o resultado do IMC

  void _atualizarCampo(String valor) {
    setState(() {
      if (_campoSelecionadoPeso) {
        _controladorPeso.text += valor;
      } else {
        _controladorAltura.text += valor;
      }
    });
  }

  void _alternarCampo() {
    setState(() {
      _campoSelecionadoPeso = !_campoSelecionadoPeso; // Alterna entre Peso e Altura
    });
  }

  void _calcularIMC() {
    final textoPeso = _controladorPeso.text;
    final textoAltura = _controladorAltura.text;

    if (textoPeso.isNotEmpty && textoAltura.isNotEmpty) {
      final peso = double.tryParse(textoPeso);
      final altura = double.tryParse(textoAltura);

      if (peso != null && altura != null && altura != 0) {
        final imc = peso / (altura * altura);
        String classificacao;

        // Classificação de acordo com a tabela fornecida
        if (imc < 16) {
          classificacao = 'Magreza grau III';
        } else if (imc >= 16 && imc <= 16.9) {
          classificacao = 'Magreza grau II';
          
        } else if (imc >= 17 && imc <= 18.4) {
          classificacao = 'Magreza grau I';
        } else if (imc >= 18.5 && imc <= 24.9) {
          classificacao = 'Eutrofia';
        } else if (imc >= 25 && imc <= 29.9) {
          classificacao = 'Pré-obesidade';
        } else if (imc >= 30 && imc <= 34.9) {
          classificacao = 'Obesidade moderada (grau I)';
        } else if (imc >= 35 && imc <= 39.9) {
          classificacao = 'Obesidade severa (grau II)';
        } else if (imc >= 40) {
          classificacao = 'Obesidade muito severa (grau III)';
        } else {
          classificacao = 'Erro';
        }

        setState(() {
          _resultadoIMC = '${imc.toStringAsFixed(2)} - $classificacao'; // Exibe o IMC com a classificação
        });
      } else {
        setState(() {
          _resultadoIMC = 'Erro'; // Exibe 'Erro' se os valores não forem válidos
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth / 5; // Ajusta o tamanho dos botões com base na largura da tela

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 29, 29),
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        backgroundColor: Color.fromARGB(255, 83, 8, 126),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  'https://static4.depositphotos.com/1011434/506/i/950/depositphotos_5063077-stock-photo-sun-position.jpg',
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _controladorPeso,
                decoration: InputDecoration(
                  labelText: 'Peso',
                  hintText: 'Digite o Peso:',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 203, 146, 236), fontSize: 18),
                  hintStyle: TextStyle(color: Color.fromARGB(255, 219, 214, 214)),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Color.fromARGB(255, 219, 214, 214)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: TextField(
                controller: _controladorAltura,
                decoration: InputDecoration(
                  labelText: 'Altura',
                  hintText: 'Digite a Altura:',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 203, 146, 236), fontSize: 18),
                  hintStyle: TextStyle(color: Color.fromARGB(255, 219, 214, 214)),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Color.fromARGB(255, 219, 214, 214)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _alternarCampo,
                child: Text(_campoSelecionadoPeso ? 'Mudar para Altura' : 'Mudar para Peso'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Color.fromARGB(255, 45, 47, 48),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'IMC: $_resultadoIMC',
                style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 219, 214, 214)),
              ),
            ),
            SizedBox(
              height: 400,
              child: GridView.count(
                crossAxisCount: 4,
                padding: EdgeInsets.all(16.0),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: [
                  for (var i = 1; i <= 9; i++)
                    ElevatedButton(
                      onPressed: () => _atualizarCampo('$i'),
                      child: Text('$i'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(buttonSize / 4), // Ajusta o padding dos botões
                        textStyle: TextStyle(fontSize: buttonSize / 4), // Ajusta o tamanho do texto
                        backgroundColor: Color.fromARGB(255, 45, 47, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () => _atualizarCampo('.'),
                    child: Text('.'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(buttonSize / 4), // Ajusta o padding dos botões
                      textStyle: TextStyle(fontSize: buttonSize / 4), // Ajusta o tamanho do texto
                      backgroundColor: Color.fromARGB(255, 45, 47, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _atualizarCampo('0'),
                    child: Text('0'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(buttonSize / 4), // Ajusta o padding dos botões
                      textStyle: TextStyle(fontSize: buttonSize / 4), // Ajusta o tamanho do texto
                      backgroundColor: Color.fromARGB(255, 45, 47, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _calcularIMC, // Calcula o IMC quando o botão "=" é pressionado
                    child: Text('='),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(buttonSize / 4), // Ajusta o padding dos botões
                      textStyle: TextStyle(fontSize: buttonSize / 2), // Ajusta o tamanho do texto
                      backgroundColor: Color.fromARGB(255, 45, 47, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
