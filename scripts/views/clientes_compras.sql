CREATE OR REPLACE VIEW ClientesCompras AS
SELECT 
    c.Nome AS Cliente,
    COUNT(v.Codigo) AS TotalCompras,
    COALESCE(SUM(v.Subtotal - v.Desconto), 0) AS TotalGasto
FROM Cliente c
LEFT JOIN Venda v ON c.CPF = v.CPFCliente
GROUP BY c.Nome;
