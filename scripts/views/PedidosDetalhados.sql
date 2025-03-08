CREATE VIEW PedidosDetalhados AS
SELECT p.codigo AS codigo_pedido, 
p.dataPedido,
p.subtotal AS subtotal_pedido,
p.statusPedido,
prod.nome AS produto,
pp.quantidade AS quantidade_item,
pp.subtotalItemPedido,
pp.precoCompraFornecedor,
f.nome AS fornecedor,
fun.nome AS funcionario,
p.notapedido,
p.prazo AS prazo_pedido
FROM (((Pedido p INNER JOIN Fornecedor f ON p.CnpjFornecedor = f.Cnpj) 
INNER JOIN Funcionario fun ON p.codFuncionario = fun.codigo)
INNER JOIN PedidoProduto pp ON p.codigo = pp.codPedido) INNER JOIN Produto prod ON pp.idProduto = prod.id
ORDER BY p.codigo ASC