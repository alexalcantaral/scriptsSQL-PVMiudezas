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

--Cálculo do faturamento e lucro com base nas vendas

SELECT 
    (SELECT SUM(subtotal) FROM Pedido) AS valorTotalPedidos, 
    (SELECT SUM(subtotal - desconto) FROM Venda) AS valorTotalVendas,
    ROUND(
        (( (SELECT SUM(subtotal - desconto) FROM Venda) - (SELECT SUM(subtotal) FROM Pedido) ) 
        / NULLIF((SELECT SUM(subtotal) FROM Pedido), 0) ) * 100, 2
    ) AS percentualLucro


--Lista dos clientes que já se associaram a vendas

SELECT * 
FROM Cliente c
WHERE EXISTS (
    SELECT cpfcliente FROM Venda v WHERE v.CPFCliente = c.CPF
);

--Todos os clientes que nunca compraram produtos da categoria 'Construcao'

SELECT c.Nome
FROM Cliente c
WHERE NOT EXISTS (
    SELECT 1 FROM Venda v 
    INNER JOIN ItemVenda iv ON v.Codigo = iv.CodVenda
    INNER JOIN Produto p ON iv.idProduto = p.Id
	INNER JOIN Categoria ca ON p.IdCategoria = ca.Id
    WHERE v.CPFCliente = c.CPF AND ca.nome = 'Construcao'
);


--Lista dos clientes que realizaram compras em determinado período.

SELECT DISTINCT *
FROM Cliente c
JOIN Venda v ON c.CPF = v.CPFCliente
WHERE v.DataVenda BETWEEN '2024-01-01' AND '2024-12-31';


--Listar todos os clientes

SELECT * FROM Cliente;


--Listar todos os produtos  registrados que começam com a letra A

SELECT *
FROM Produto
WHERE Nome ILIKE 'C%';


--Listar todos os funcionários ordenados pela data de contratação

SELECT *
FROM Funcionario
ORDER BY dataAdmissao;


--Listar todas as vendas que foram feitas por um método de pagamento específico

SELECT v.Codigo, v.DataVenda, v.Subtotal, mp.Tipo
FROM Venda v
INNER JOIN Pagamento p ON v.Codigo = p.CodVenda
INNER JOIN MetodoPagamento mp ON p.IdMetodoPagamento = mp.Id
WHERE mp.Tipo = 'Crédito';
















