-- Índices para a tabela Funcionario
CREATE INDEX idx_funcionario_codigo ON Funcionario(Codigo);
CREATE INDEX idx_funcionario_nome ON Funcionario(Nome);
CREATE INDEX idx_funcionario_ativo ON Funcionario(Ativo);

-- Índices para a tabela Cliente
CREATE INDEX idx_cliente_cpf ON Cliente(Cpf);
CREATE INDEX idx_cliente_nome ON Cliente(Nome);

-- Índices para a tabela Venda
CREATE INDEX idx_venda_codigo ON Venda(Codigo);
CREATE INDEX idx_venda_data ON Venda(DataVenda);

-- Índices para a tabela Categoria
CREATE INDEX idx_categoria_id ON Categoria(Id);

-- Índices para a tabela Produto
CREATE INDEX idx_produto_id ON Produto(Id);
CREATE INDEX idx_produto_nome ON Produto(Nome);

-- Índices para a tabela Fornecedor
CREATE INDEX idx_fornecedor_cnpj ON Fornecedor(Cnpj);
CREATE INDEX idx_fornecedor_cnpj ON Fornecedor(Nome);
CREATE INDEX idx_fornecedor_cnpj ON Fornecedor(Ativo);

-- Índices para a tabela Pedido
CREATE INDEX idx_pedido_codigo ON Pedido(Codigo);
CREATE INDEX idx_pedido_data ON Pedido(DataPedido);

-- Índices para a tabela MetodoPagamento
CREATE INDEX idx_metodo_pagamento_id ON MetodoPagamento(Id);
CREATE INDEX idx_metodo_pagamento_ativo ON MetodoPagamento(Ativo);

-- Índices para a tabela Pagamento
CREATE INDEX idx_pagamento_data ON Pagamento(DataPagamento);

-- Índices para a tabela Entrega
CREATE INDEX idx_entrega_id ON Entrega(Id);
CREATE INDEX idx_entrega_status ON Entrega(StatusEntrega);

-- Índices para a tabela NotaFiscal
CREATE INDEX idx_nota_fiscal_id ON NotaFiscal(Id);

-- Indices para ForneceProduto
CREATE INDEX idx_ativo ON ForneceProduto(Ativo);

-- Indices para ItemVenda
CREATE INDEX idx_produto ON ItemVenda(IdProduto);
CREATE INDEX idx_venda ON ItemVenda(CodVenda);
