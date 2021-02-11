import 'package:crud/src/shared/constants.dart';

import 'home_repository.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HomeRepositoryImpl implements HomeRepository {
  final _client = HasuraConnect(HASURA_URL);

  @override
  Future<List<Map>> getCharacters() async {
    final response = await _client.query('''
      query {
  characters(order_by: {name: asc}) {
    id
    name
    age
  }
}
    ''');

    return (response['data']['characters'] as List)
        .map((e) => {
              "name": e['name'],
              "age": e['age'],
            })
        .toList();
  }

  @override
  Future<void> createCharacters(String name, int age) async {
    return await _client.mutation('''
    mutation MyMutation {
  insert_characters(objects: {name: "$name", age: $age}) {
    returning {
      id
    }
  }
}
    ''');
  }
}
