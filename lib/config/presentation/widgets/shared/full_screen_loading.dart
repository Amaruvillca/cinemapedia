import 'package:flutter/material.dart';

class FullScreenLoading extends StatelessWidget {
  const FullScreenLoading({super.key});

  

  Stream <String> getMessagesStream()  {
    final List<String> messages=[
    "Espere Por favor",
    "Cargando",
    "Un momento por favor",
    "Estamos trabajando en ello",
    "Cargando datos",
    "Por favor espere un momento",
    "Estamos preparando todo para ti",
    "Cargando información",
    "Un momento, estamos trabajando en ello",
    "Por favor, tenga paciencia mientras cargamos los datos"

  ];
    return Stream.periodic(const Duration(milliseconds: 1500), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Espere Por favor"),
        const SizedBox(height: 20,),
        const CircularProgressIndicator(
          color: Color.fromARGB(255, 54, 143, 244),
          strokeWidth: 2,
        ),
        const SizedBox(height: 20,),
        StreamBuilder(
          stream: getMessagesStream(),
          builder: (context,snapshot){
            if(!snapshot.hasData) return const Text("Cargando...");
            return Text(snapshot.data!);
          }
          
          
          )
      ],
    ),);
  }
}