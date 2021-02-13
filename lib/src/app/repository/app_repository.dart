abstract class AppRepository {
  Future getCharacters();
  Future createCharacters(String name, int age);
  Future updateCharacters(int id, String name, int age);
  Future deleteCharacters(int id);
}
