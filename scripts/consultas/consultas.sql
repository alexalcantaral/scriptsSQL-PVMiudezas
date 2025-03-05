--Lista de todos os funcionários ativos.

SELECT * 
FROM Funcionario
WHERE Ativo = TRUE

--Lista de todos os funcionários que realizaram vendas.

SELECT * 
FROM Funcionario
WHERE Codigo IN (
SELECT CodFuncionario
FROM Venda
)

--Lista de todos os produtos registrados.

SELECT * 
FROM Produto

--Verificar o funcionário responsável por uma venda.

SELECT v.codigo as codvenda,f.nome as funcionario, f.codigo as codfuncionario 
FROM Venda v INNER JOIN Funcionario f ON v.codFuncionario = f.codigo
WHERE v.codigo = 1

--Verificar todos os produtos de uma categoria.

SELECT * 
FROM Produto
WHERE Idcategoria IN (
SELECT Id
FROM Categoria
WHERE nome LIKE '%Construcao%'
)

--Lista das vendas realizadas pelo funcionario Savio Antartica.

SELECT * 
FROM Venda
WHERE codfuncionario IN (
SELECT codigo
FROM Funcionario
WHERE nome LIKE '%Savio Antartica%'
)

--Verificar quais produtos o fornecedor com cnpj '12345678000199' disponibiliza.

SELECT * 
FROM Produto
WHERE Id IN (
SELECT IdProduto
FROM ForneceProduto
WHERE CnpjFornecedor = '12345678000199'
)

--Lista de todos os fornecedores ativos registrados.

SELECT * 
FROM Fornecedor
WHERE Ativo = TRUE

--Levantamento do subtotal médio dos itens comprados em um pedido para um fornecedor. isso para pedidos realizados no periodo de 25 de janeiro de 2025 e 28 de fevereiro de 2025.

SELECT AVG(SubtotalItemPedido)
FROM PedidoProduto
WHERE CodPedido IN (
SELECT codigo
FROM Pedido
WHERE DataPedido BETWEEN '2025-01-25' AND '2025-02-28'
)

--Lista de todas as vendas realizadas no dia 05 de março de 2025.

SELECT * 
FROM Venda
WHERE DataVenda = '2025-03-05'

--Levantamento do preço médio das vendas.

SELECT AVG(Subtotal - desconto)
FROM Venda

--Levantamento da proporção de vendas entregues e a media de entregas por venda.

SELECT 
    (SELECT COUNT(*) FROM Venda) AS TotalVendas,  
    (SELECT COUNT(*) FROM Entrega WHERE StatusEntrega = 'Entregue') AS TotalEntregas,  
	ROUND(
        (SELECT COUNT(*) FROM Entrega WHERE StatusEntrega = 'Entregue') * 100.0 / 
        (SELECT COUNT(*) FROM Venda), 2
    ) AS PorcentagemEntregas,
	ROUND(
        (SELECT COUNT(*) FROM Entrega WHERE StatusEntrega = 'Entregue') * 1.0 / 
        (SELECT COUNT(*) FROM Venda), 2
    ) AS MediaEntregasPorVenda
;

--Levantamento dos pagamentos realizados. 

SELECT 
    COUNT(*) AS TotalPagamentos,
    SUM(ValorPago) AS ValorTotalPago,
    ROUND(AVG(ValorPago), 2) AS MediaValorPago
FROM Pagamento;

--Levantamento dos métodos de pagamentos mais utilizados em pagamentos

SELECT 
    mp.tipo, 
    COUNT(p.IdMetodoPagamento) AS TotalPagamentos,
    ROUND(
        (COUNT(p.IdMetodoPagamento) * 100.0) / NULLIF((SELECT COUNT(*) FROM Pagamento), 0), 2
    ) AS Porcentagem
FROM MetodoPagamento mp
LEFT OUTER JOIN Pagamento p ON mp.Id = p.IdMetodoPagamento
GROUP BY mp.tipo
ORDER BY COUNT(p.IdMetodoPagamento) DESC














