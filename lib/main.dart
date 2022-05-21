import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

var request = Uri.https('api.hgbrasil.com', '/finance', { 'key': '3d362842' });

void main() async {
  print(await pegarDados());
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String ibovespaNome = '';
  String ibovespaLocal = '';
  String ibovespaPontos = '';
  String ibovespaVariacao = '';

  String nasdaqNome = '';
  String nasdaqLocal = '';
  String nasdaqPontos = '';
  String nasdaqVariacao = '';

  String nikkeiNome = '';
  String nikkeiLocal = '';
  String nikkeiVariacao = '';

  String cacNome = '';
  String cacLocal = '';
  String cacVariacao = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bolsinha de Valorzinho"),
        backgroundColor: Colors.white,
        centerTitle:true ,
      ),

      body: FutureBuilder(
        future: pegarDados(),
        builder: (context, snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                    "Carregando dados",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25,
                    ),
                  )
              );  
            default:
              if(snapshot.hasError){

                return Center(
                  child: Text(
                      "Erro ao carregar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                      ),
                    )
                );
              }else{
                final data = snapshot.data! as Map<String, dynamic>;
                ibovespaNome = data['results']['stocks']['IBOVESPA']['name'].toString();
                ibovespaLocal = data['results']['stocks']['IBOVESPA']['location'].toString();
                ibovespaPontos = data['results']['stocks']['IBOVESPA']['points'].toString();
                ibovespaVariacao = data['results']['stocks']['IBOVESPA']['variation'].toString();

                nasdaqNome = data['results']['stocks']['NASDAQ']['name'].toString();
                nasdaqLocal = data['results']['stocks']['NASDAQ']['location'].toString();
                nasdaqPontos = data['results']['stocks']['NASDAQ']['points'].toString();
                nasdaqVariacao = data['results']['stocks']['NASDAQ']['variation'].toString();

                nikkeiNome = data['results']['stocks']['NIKKEI']['name'].toString();
                nikkeiLocal = data['results']['stocks']['NIKKEI']['location'].toString();
                nikkeiVariacao = data['results']['stocks']['NIKKEI']['variation'].toString();

                cacNome = data['results']['stocks']['CAC']['name'].toString();
                cacLocal = data['results']['stocks']['CAC']['location'].toString();
                cacVariacao = data['results']['stocks']['CAC']['variation'].toString();
              
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('images/bolsa.jpg',
                        fit: BoxFit.cover,
                        height: 200
                      ),
                      Divider(),
                      Text(
                        ibovespaNome, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        ibovespaLocal, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        ibovespaPontos, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        ibovespaVariacao, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Divider(),
                      Text(
                        nasdaqNome, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        nasdaqLocal, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        nasdaqPontos, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        nasdaqVariacao, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Divider(),
                      Text(
                        nikkeiNome, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        nikkeiLocal, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        nikkeiVariacao, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Divider(),
                      Text(
                        cacNome, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        cacLocal, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                      Text(
                        cacVariacao, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      )
      
    );
  }
}

Future<Map> pegarDados() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

