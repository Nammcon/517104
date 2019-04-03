class Node:
    def __init__(self, data):
        self.left = None
        self.right = None
        self.data = data

class BinaryTree(Node):
    def __init__(self):
        self.root = None

    def insertNode(self, root, element):
        if self.root is None:
            self.root = Node(element)
        else:
            if root is None:
                root = Node(element)
            elif root.data <= element:
                root.right = self.insertNode(root.right, element)
            elif root.data > element:
                root.left = self.insertNode(root.right, element)
        return root
    
    def preOrder(self, root):
        if root is not None:
            print(root.data, end = ' ')
        if root.left is not None:
            self.preOrder(root.left)
        if root.right is not None:
            self.preOrder(root.right)

a = BinaryTree()
a.insertNode(a.root,3) 
a.insertNode(a.root,4) 
a.insertNode(a.root,34) 
a.insertNode(a.root,45) 
a.insertNode(a.root,46) 
a.insertNode(a.root,2) 
a.insertNode(a.root,48) 
a.preOrder(a.root) 