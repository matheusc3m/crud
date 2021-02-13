import 'package:crud/src/shared/constants.dart';

import 'app_repository.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AppRepositoryImpl implements AppRepository {
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
              "id": e['id'],
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

  @override
  Future updateCharacters(int id, String name, int age) async {
    return await _client.mutation('''
   mutation MyMutation {
  update_characters(where: {id: {_eq: $id}}, _set: {name: "$name", age: $age}) {
    returning {
      id
    }
  }
}
    ''');
  }

  @override
  Future deleteCharacters(int id) async {
    return await _client.mutation('''
   mutation MyMutation {
  delete_characters(where: {id: {_eq: $id}}) {
    affected_rows
  }
}

    ''');
  }
}
