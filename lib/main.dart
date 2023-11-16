import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

   GlobalKey<FormState> _formKey = GlobalKey();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal \n IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText =
            "Levemente acima do peso \n IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I \n IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II \n IMC = ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III \n IMC = ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
                onPressed: _resetFields, icon: const Icon(Icons.refresh)),
          ],
        ),
        backgroundColor: const Color(0xFFFCFCFC),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Peso (Kg)',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green, fontSize: 25),
                    controller: weightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe seu peso";
                      }
                      return null; // Retorna null se a validação passar
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green, fontSize: 25),
                    controller: heightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe sua altura";
                      }
                      return null; // Retorna null se a validação passar
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                            _calculate();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          foregroundColor: MaterialStateProperty.all(
                              const Color(0xFFFCFCFC)),
                        ),
                        child: const Text(
                          'Calcular',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: _infoText != 'Informe seus dados'
                        ? const TextStyle(color: Colors.red, fontSize: 25)
                        : const TextStyle(color: Colors.green, fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
