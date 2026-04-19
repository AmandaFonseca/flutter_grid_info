import 'dart:convert';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/feature_home/data/datasources/home_local_data_source/home_local_data_source.dart';
import 'package:flutter_grid_info/features/feature_home/data/models/informacao_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String key = 'LISTA_INFORMACOES';

  HomeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> salvarInformacao(InformacaoModel info) async {
    try {
      final listaExistente = await recuperarInformacoes();

      listaExistente.add(info);

      final String data = jsonEncode(
        listaExistente.map((m) => m.toMap()).toList(),
      );

      return await sharedPreferences.setString(key, data);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<InformacaoModel>> recuperarInformacoes() async {
    final String? jsonString = sharedPreferences.getString(key);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => InformacaoModel.fromMap(item)).toList();
  }

  @override
  Future<void> removeItem(String id) async {
    try {
      final String? jsonString = sharedPreferences.getString(key);

      if (jsonString == null) return;
      List<dynamic> jsonList = jsonDecode(jsonString);

      jsonList.removeWhere((item) => item['idInfo'] == id);
      await sharedPreferences.setString(key, jsonEncode(jsonList));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> editarItem(InformacaoModel info) async {
    try {
      final String? jsonString = sharedPreferences.getString(key);
      if (jsonString == null) return false;

      List<dynamic> jsonList = jsonDecode(jsonString);
      List<InformacaoModel> lista = jsonList
          .map((item) => InformacaoModel.fromMap(item))
          .toList();

      final index = lista.indexWhere((item) => item.idInfo == info.idInfo);
      if (index != -1) {
        lista[index] = info;
        await sharedPreferences.setString(
          key,
          jsonEncode(lista.map((e) => e.toMap()).toList()),
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
