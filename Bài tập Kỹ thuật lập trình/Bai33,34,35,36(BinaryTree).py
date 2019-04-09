class Node:
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None

    def insert(self, data):
        if self.data:
            if data < self.data:
                if self.left is None:
                    self.left = Node(data)
                else:
                    self.left.insert(data)
            elif data > self.data:
                if self.right is None:
                    self.right = Node(data)
                else:
                    self.right.insert(data)
        else:
            self.data = data

    # Left -> Node -> Right
    def inOrder(self, root):
        if root:
            self.inOrder(root.left)
            print(root.data, end = ' ')
            self.inOrder(root.right)

    # Node -> Left -> Right
    def preOrder(self, root):
        if root:
            print(root.data, end = ' ')
            self.preOrder(root.left)
            self.preOrder(root.right)

    # Left -> Right -> Node
    def postOrder(self, root):
        if root:
            self.postOrder(root.left)
            self.postOrder(root.right)
            print(root.data, end = ' ')

def main():
    node_root = int(input('Đỉnh của cây: '))
    root = Node(node_root)
    for i in range(9):
        i = int(input("Nhập node: "))
        root.insert(i) 

    print('1. Duyệt cây theo thứ tự trước')
    print('2. Duyệt cây theo thứ tự giữa')
    print('3. Duyệt cây theo thứ tự sau')
    choice = str(input('Chọn kiểu duyệt: '))
    if choice == '1':
        print('Duyệt cây theo thứ tự trước: ', end = ' ')
        root.preOrder(root)
    elif choice == '2':
        print('Duyệt cây theo thứ tự giữa: ', end = ' ')
        root.inOrder(root)
    elif choice == '3':
        print('Duyệt cây theo thứ tự sau: ', end = ' ')
        root.postOrder(root)

if __name__ == "__main__":
    main()
