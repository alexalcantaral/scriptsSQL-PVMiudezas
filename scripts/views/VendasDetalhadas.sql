CREATE VIEW VendasDetalhadas AS
SELECT
    v.Codigo AS CodigoVenda,
    v.DataVenda,
    v.Subtotal AS SubtotalVenda,
    v.Desconto,
    v.CodFuncionario,
    f.Nome AS NomeFuncionario,
    c.Nome AS NomeCliente,
    iv.Quantidade,
    p.Nome AS Produto,
    iv.Subtotal AS SubtotalItem
FROM
    Venda v
INNER JOIN
    ItemVenda iv ON v.Codigo = iv.CodVenda
INNER JOIN
    Produto p ON iv.IdProduto = p.Id
LEFT OUTER JOIN
    Cliente c ON v.CpfCliente = c.Cpf
INNER JOIN
    Funcionario f ON v.CodFuncionario = f.Codigo;