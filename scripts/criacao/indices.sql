-- Índices para a tabela Funcionario
CREATE INDEX idx_funcionario_nome ON Funcionario(Nome);
CREATE INDEX idx_funcionario_cargo ON Funcionario(Cargo);

-- Índices para a tabela Cliente
CREATE INDEX idx_cliente_nome ON Cliente(Nome);

-- Índices para a tabela Venda
CREATE INDEX idx_venda_data ON Venda(DataVenda);
CREATE INDEX idx_venda_cod_funcionario ON Venda(CodFuncionario);
CREATE INDEX idx_venda_cpf_cliente ON Venda(CpfCliente);

-- Índices para a tabela Categoria
CREATE INDEX idx_categoria_nome ON Categoria(Nome);

-- Índices para a tabela Produto
CREATE INDEX idx_produto_nome ON Produto(Nome);
CREATE INDEX idx_produto_idcategoria ON Produto(IdCategoria);
CREATE INDEX idx_produto_marca ON Produto(Marca);

-- Índices para a tabela ItemVenda
CREATE INDEX idx_itemvenda_cod_venda ON ItemVenda(CodVenda);
CREATE INDEX idx_itemvenda_id_produto ON ItemVenda(IdProduto);

-- Índices para a tabela Fornecedor
CREATE INDEX idx_fornecedor_nome ON Fornecedor(Nome);

-- Índices para a tabela ForneceProduto
CREATE INDEX idx_forneceproduto_cnpj_fornecedor ON ForneceProduto(CnpjFornecedor);
CREATE INDEX idx_forneceproduto_id_produto ON ForneceProduto(IdProduto);

-- Índices para a tabela Pedido
CREATE INDEX idx_pedido_data ON Pedido(DataPedido);
CREATE INDEX idx_pedido_status ON Pedido(StatusPedido);
CREATE INDEX idx_pedido_cnpj_fornecedor ON Pedido(CnpjFornecedor);
CREATE INDEX idx_pedido_cod_funcionario ON Pedido(CodFuncionario);

-- Índices para a tabela PedidoProduto
CREATE INDEX idx_pedidoproduto_cod_pedido ON PedidoProduto(CodPedido);
CREATE INDEX idx_pedidoproduto_id_produto ON PedidoProduto(IdProduto);

-- Índices para a tabela MetodoPagamento
CREATE INDEX idx_metodopagamento_tipo ON MetodoPagamento(Tipo);

-- Índices para a tabela Pagamento
CREATE INDEX idx_pagamento_cod_venda ON Pagamento(CodVenda);
CREATE INDEX idx_pagamento_id_metodo_pagamento ON Pagamento(IdMetodoPagamento);

-- Índices para a tabela Entrega
CREATE INDEX idx_entrega_cod_venda ON Entrega(CodVenda);
CREATE INDEX idx_entrega_cod_funcionario ON Entrega(CodFuncionario);
CREATE INDEX idx_entrega_status ON Entrega(StatusEntrega);

-- Índices para a tabela NotaFiscal
CREATE INDEX idx_notafiscal_numero_serie ON NotaFiscal(NumeroSerie);
CREATE INDEX idx_notafiscal_chave_acesso ON NotaFiscal(ChaveAcesso);
