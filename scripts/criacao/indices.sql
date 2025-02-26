-- Índices para chaves primárias usadas em buscas
CREATE INDEX idx_funcionario_codigo ON Funcionario(Codigo);
CREATE INDEX idx_cliente_cpf ON Cliente(Cpf);
CREATE INDEX idx_venda_codigo ON Venda(Codigo);
CREATE INDEX idx_categoria_id ON Categoria(Id);
CREATE INDEX idx_produto_id ON Produto(Id);
CREATE INDEX idx_fornecedor_cnpj ON Fornecedor(Cnpj);
CREATE INDEX idx_pedido_codigo ON Pedido(Codigo);
CREATE INDEX idx_metodo_pagamento_id ON MetodoPagamento(Id);
CREATE INDEX idx_entrega_id ON Entrega(Id);
CREATE INDEX idx_nota_fiscal_id ON NotaFiscal(Id);

-- Índices para colunas frequentemente usadas em filtros e junções
CREATE INDEX idx_funcionario_nome ON Funcionario(Nome);
CREATE INDEX idx_cliente_nome ON Cliente(Nome);
CREATE INDEX idx_venda_data ON Venda(DataVenda);
CREATE INDEX idx_produto_nome ON Produto(Nome);
CREATE INDEX idx_pedido_data ON Pedido(DataPedido);
CREATE INDEX idx_pagamento_data ON Pagamento(DataPagamento);
CREATE INDEX idx_entrega_status ON Entrega(StatusEntrega);
