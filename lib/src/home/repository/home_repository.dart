abstract class HomeRepository {
  Future getCharacters();
  Future createCharacters(String name, int age);
}
