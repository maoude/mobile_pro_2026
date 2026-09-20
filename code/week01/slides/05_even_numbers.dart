// Week 1, slide 21 - print the even numbers between m and n.
void main() {
  int m = 10;
  int n = 20;

  for (int i = m; i <= n; i++) {
    if (i % 2 == 0) {
      print("$i");
    }
  }
}
