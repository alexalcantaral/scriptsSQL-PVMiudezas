CREATE OR REPLACE VIEW TotalPagamentosMetodo AS
SELECT 
    mp.Tipo AS MetodoPagamento,
    COUNT(p.IdMetodoPagamento) AS QuantidadePagamentos,
    SUM(p.ValorPago) AS ValorTotal,
    ROUND((COUNT(p.IdMetodoPagamento) * 100.0) / (SELECT COUNT(*) FROM Pagamento), 2) AS Porcentagem
FROM Pagamento p
INNER JOIN MetodoPagamento mp ON p.IdMetodoPagamento = mp.Id
GROUP BY mp.Tipo;
