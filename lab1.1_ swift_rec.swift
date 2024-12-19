// 1.1) SWIFT: Рекурсия - проверка пути в дереве с положительными элементами

// Структура дерева
class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

func hasPositivePath(_ root: TreeNode?) -> Bool {
    // Если узел пустой, пути нет
    guard let root = root else { return false }
    
    // Если это лист и значение положительное
    if root.left == nil && root.right == nil {
        return root.value > 0
    }
    
    // Проверяем пути рекурсивно для левого и правого поддерева
    return (root.value > 0) && (hasPositivePath(root.left) || hasPositivePath(root.right))
}

// Пример использования 
let tree1 = TreeNode(
    value: 5,
    left: TreeNode(value: 3, left: TreeNode(value: 2), right: TreeNode(value: -1)),
    right: TreeNode(value: 8, left: TreeNode(value: -6), right: TreeNode(value: -4))
)

print(hasPositivePath(tree1)) // true

let tree2 = TreeNode(
    value: 5,
    left: TreeNode(value: 3, left: TreeNode(value: -2), right: TreeNode(value: -1)),
    right: TreeNode(value: 8, left: TreeNode(value: -6), right: TreeNode(value: -4))
)

print(hasPositivePath(tree2)) // false