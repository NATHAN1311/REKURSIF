import 'dart:collection';
import 'dart:io';

// Kelas Node untuk menyimpan data dan anak kiri-kanan
class Node {
  int data;
  Node? left;
  Node? right;

  Node(this.data);
}

// Kelas BinaryTree
class BinaryTree {
  Node? root;

  // 1. Tambah node secara Level Order (menggunakan Queue)
  void insertLevelOrder(int data) {
    Node newNode = Node(data);

    if (root == null) {
      root = newNode;
      return;
    }

    Queue<Node> queue = Queue<Node>();
    queue.add(root!);

    while (queue.isNotEmpty) {
      Node current = queue.removeFirst();

      if (current.left == null) {
        current.left = newNode;
        return;
      } else {
        queue.add(current.left!);
      }

      if (current.right == null) {
        current.right = newNode;
        return;
      } else {
        queue.add(current.right!);
      }
    }
  }

  // 2. Tambah node berdasarkan target value (linear search)
  bool insertByTarget(int target, int newData) {
    if (root == null) return false;

    Queue<Node> queue = Queue<Node>();
    queue.add(root!);

    while (queue.isNotEmpty) {
      Node current = queue.removeFirst();

      if (current.data == target) {
        if (current.left == null) {
          current.left = Node(newData);
        } else if (current.right == null) {
          current.right = Node(newData);
        } else {
          print('Node dengan data $target sudah memiliki 2 anak.');
        }
        return true;
      }

      if (current.left != null) queue.add(current.left!);
      if (current.right != null) queue.add(current.right!);
    }

    print('Node dengan data $target tidak ditemukan.');
    return false;
  }

  // 3a. Non-recursive InOrder Traversal
  void inorderTraversal() {
    List<Node> stack = [];
    Node? current = root;

    stdout.write('InOrder traversal: ');
    while (current != null || stack.isNotEmpty) {
      while (current != null) {
        stack.add(current);
        current = current.left;
      }

      current = stack.removeLast();
      stdout.write('${current.data} ');
      current = current.right;
    }
    print('\n');
  }

  // 3b. Non-recursive PreOrder Traversal
  void preorderTraversal() {
    if (root == null) return;

    List<Node> stack = [root!];

    stdout.write('PreOrder traversal: ');
    while (stack.isNotEmpty) {
      Node current = stack.removeLast();
      stdout.write('${current.data} ');

      if (current.right != null) stack.add(current.right!);
      if (current.left != null) stack.add(current.left!);
    }
    print('\n');
  }

  // 3c. Non-recursive PostOrder Traversal
  void postorderTraversal() {
    if (root == null) return;

    List<Node> stack1 = [root!];
    List<int> result = [];

    while (stack1.isNotEmpty) {
      Node current = stack1.removeLast();
      result.add(current.data);

      if (current.left != null) stack1.add(current.left!);
      if (current.right != null) stack1.add(current.right!);
    }

    stdout.write('PostOrder traversal: ');
    for (int i = result.length - 1; i >= 0; i--) {
      stdout.write('${result[i]} ');
    }
    print('\n');
  }
}

void main() {
  BinaryTree tree = BinaryTree();

  // Tambahkan node secara level order
  tree.insertLevelOrder(10);
  tree.insertLevelOrder(20);
  tree.insertLevelOrder(30);
  tree.insertLevelOrder(40);
  tree.insertLevelOrder(50);

  // Tambahkan node berdasarkan target
  tree.insertByTarget(20, 60); // Menambahkan 60 ke node dengan data 20
  tree.insertByTarget(30, 70); // Menambahkan 70 ke node dengan data 30

  // Traversal
  print('\n== HASIL TRAVERSAL BINARY TREE ==\n');
  tree.inorderTraversal(); // Output: 40 20 60 10 50 30 70
  tree.preorderTraversal(); // Output: 10 20 40 60 30 50 70
  tree.postorderTraversal(); // Output: 40 60 20 50 70 30 10
}
