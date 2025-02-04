-- ========================
-- (f) 12 consultas diferentes
-- ========================

-- F1) Consulta com INNER JOIN
-- Recupera os nomes dos fornecedores e os nomes dos produtos que eles fornecem.
SELECT f.nome_fornecedor, p.nome_produto
FROM empresa.Fornecedor f
INNER JOIN empresa.Produto p ON f.cnpj = p.cnpj_fornecedor;

-- F2) Consulta com OUTER JOIN
-- Recupera os nomes de todos os fornecedores e os produtos que eles fornecem, incluindo fornecedores que não têm produtos associados.
SELECT f.nome_fornecedor, p.nome_produto
FROM empresa.Fornecedor f
LEFT OUTER JOIN empresa.Produto p ON f.cnpj = p.cnpj_fornecedor;

-- F3) Consulta com ORDER BY
-- Recupera os produtos com seus valores de venda, ordenados pelo valor de venda em ordem decrescente.
SELECT nome_produto, valor_produto_venda
FROM empresa.Produto
ORDER BY valor_produto_venda DESC;

-- F4) Consulta com GROUP BY
-- Recupera a quantidade de produtos em estoque por categoria, somando a quantidade de estoque de cada categoria.
SELECT c.nome_categoria, SUM(p.quantidade_estoque) AS total_estoque
FROM empresa.Categoria c
JOIN empresa.Produto p ON c.id_categoria = p.id_categoria
GROUP BY c.nome_categoria;

-- F5) Consulta com HAVING
-- Recupera o nome das categorias que possuem mais de 100 itens em estoque.
SELECT c.nome_categoria, SUM(p.quantidade_estoque) AS total_estoque
FROM empresa.Categoria c
JOIN empresa.Produto p ON c.id_categoria = p.id_categoria
GROUP BY c.nome_categoria
HAVING SUM(p.quantidade_estoque) > 100;

-- F6) Consulta com UNION
-- Recupera os nomes dos produtos e dos fornecedores, sem duplicação, combinando as duas consultas.
SELECT cnpj AS identificador, nome_fornecedor AS nome, 'Fornecedor' AS tipo
FROM empresa.Fornecedor
UNION
SELECT SKU AS identificador, nome_produto AS nome, 'Produto' AS tipo
FROM empresa.Produto;

-- F7) Consulta com IN
-- Recupera os produtos que pertencem às categorias "Eletrônicos" ou "Roupas".
SELECT nome_produto
FROM empresa.Produto
WHERE id_categoria IN (
    SELECT id_categoria
    FROM empresa.Categoria
    WHERE nome_categoria IN ('Eletrônicos', 'Roupas')
);

-- F8) Consulta com LIKE
-- Recupera os nomes dos fornecedores cujo nome começa com "A".
SELECT nome_fornecedor
FROM empresa.Fornecedor
WHERE nome_fornecedor LIKE 'A%';

-- F9) Consulta com IS NULL
-- Recupera os fornecedores que não têm nenhuma compra registrada:
SELECT f.nome_fornecedor
FROM empresa.Fornecedor f
LEFT JOIN empresa.Compra c ON f.cnpj = c.cnpj_fornecedor
WHERE c.id_compra IS NULL;

-- F10) Consulta com ANY ou SOME
-- Recupera os produtos cujo valor de venda é maior do que qualquer produto da categoria "Eletrônicos".
SELECT nome_produto, valor_produto_venda
FROM empresa.Produto p
WHERE valor_produto_venda > ANY (
    SELECT valor_produto_venda
    FROM empresa.Produto
    JOIN empresa.Categoria c ON c.id_categoria = p.id_categoria
    WHERE c.nome_categoria = 'Eletrônicos'
);


-- F11) Consulta com ALL
-- Recupera os produtos cujo valor de venda é maior do que todos os produtos da categoria "Roupas".
SELECT nome_produto, valor_produto_venda
FROM empresa.Produto p
WHERE valor_produto_venda > ALL (
    SELECT valor_produto_venda
    FROM empresa.Produto
    JOIN empresa.Categoria c ON c.id_categoria = p.id_categoria
    WHERE c.nome_categoria = 'Roupas'
);

-- 12) Consulta com EXISTS
-- Recupera os nomes dos fornecedores que possuem ao menos um produto com estoque acima de 100 unidades.
SELECT nome_fornecedor
FROM empresa.Fornecedor f
WHERE EXISTS (
    SELECT 1
    FROM empresa.Produto p
    WHERE p.cnpj_fornecedor = f.cnpj
    AND p.quantidade_estoque > 100
);