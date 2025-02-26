CREATE TABLE Funcionario (
    Codigo INT PRIMARY KEY,
    DataAdmissao DATE NOT NULL DEFAULT CURRENT_DATE,
	Salario DECIMAL(10,2) DEFAULT 1416,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE NOT NULL CHECK (DataNascimento <= CURRENT_DATE),
    Cargo VARCHAR(50) DEFAULT 'Vendedor' CHECK (Cargo IN ('Caixa', 'Vendedor', 'Entregador')),
    Telefone CHAR(11) NOT NULL CHECK (Telefone ~ '^\d{10,11}$'),
    Ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE Cliente (
    DataCadastro DATE NOT NULL DEFAULT CURRENT_DATE,
    Cpf CHAR(11) PRIMARY KEY CHECK (Cpf ~ '^\d{11}$'),
    Nome VARCHAR(100) NOT NULL,
    Telefone CHAR(11) CHECK (Telefone ~ '^\d{10,11}$')
);

CREATE TABLE Venda (
    Codigo INT PRIMARY KEY,
    Subtotal DECIMAL(10,2) DEFAULT 0 CHECK (Subtotal >= 0),
    Desconto DECIMAL(10,2) DEFAULT 0 CHECK (Desconto >= 0 AND Desconto <= Subtotal),
    DataVenda DATE NOT NULL DEFAULT CURRENT_DATE,
    CodFuncionario INT NOT NULL,
    CpfCliente CHAR(11) NOT NULL,
    NotaVenda INT,

    FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(Codigo),
    FOREIGN KEY (CpfCliente) REFERENCES Cliente(Cpf),
	FOREIGN KEY (NotaVenda) REFERENCES NotaFiscal(Id)
);

CREATE TABLE Categoria (
    Id INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Produto (
    Id INT PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    Descricao VARCHAR(300),
	Marca VARCHAR(50) NOT NULL,
    QuantEstoque INT NOT NULL CHECK (QuantEstoque >= 0),
    LocalizacaoEstoque VARCHAR(200) NOT NULL,
    PrecoVenda DECIMAL(10,2) NOT NULL CHECK (PrecoVenda >= 0),
    IdCategoria INT NOT NULL,

	UNIQUE(Nome, Marca),
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id)
);

CREATE TABLE ItemVenda (
    Subtotal DECIMAL(10,2) NOT NULL CHECK (Subtotal >= 0),
    Quantidade DECIMAL(10,2) NOT NULL CHECK (Quantidade > 0),
    CodVenda INT NOT NULL,
    IdProduto INT NOT NULL,
    PrecoCompra DECIMAL(10,2) NOT NULL CHECK (PrecoCompra >= 0),

    PRIMARY KEY (CodVenda, IdProduto),
    FOREIGN KEY (CodVenda) REFERENCES Venda(Codigo),
    FOREIGN KEY (IdProduto) REFERENCES Produto(Id)
);

CREATE TABLE Fornecedor (
    Nome VARCHAR(100) NOT NULL,
    Cnpj CHAR(14) PRIMARY KEY CHECK (Cnpj ~ '^\d{14}$'),
    Telefone CHAR(11) NOT NULL CHECK (Telefone ~ '^\d{10,11}$'),
    Ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE ForneceProduto (
    CnpjFornecedor CHAR(14) NOT NULL,
    IdProduto INT NOT NULL,
    Prazo DATE NOT NULL,

    PRIMARY KEY (CnpjFornecedor, IdProduto),
    FOREIGN KEY (IdProduto) REFERENCES Produto(Id),
    FOREIGN KEY (CnpjFornecedor) REFERENCES Fornecedor(Cnpj)
);

CREATE TABLE Pedido (
    Codigo INT PRIMARY KEY,
    DataPedido DATE NOT NULL DEFAULT CURRENT_DATE,
    Subtotal DECIMAL(10,2) NOT NULL CHECK (Subtotal >= 0),
    StatusPedido VARCHAR(50) DEFAULT 'Pendente' CHECK (StatusPedido IN ('Pendente', 'Aprovado', 'Cancelado', 'Concluído')),
    CnpjFornecedor CHAR(14) NOT NULL,
    CodFuncionario INT NOT NULL,
    NotaPedido INT NOT NULL UNIQUE,
    Prazo DATE NOT NULL,

    FOREIGN KEY (CnpjFornecedor) REFERENCES Fornecedor(Cnpj),
    FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(Codigo)
);

CREATE TABLE PedidoProduto (
    Quantidade DECIMAL(10,2) NOT NULL CHECK (Quantidade > 0),
    PrecoCompra DECIMAL(10,2) NOT NULL CHECK (PrecoCompra >= 0),
    SubtotalItemPedido DECIMAL(10,2) NOT NULL CHECK (SubtotalItemPedido >= 0),
    CodPedido INT NOT NULL,
    IdProduto INT NOT NULL,

    PRIMARY KEY (CodPedido, IdProduto),
    FOREIGN KEY (CodPedido) REFERENCES Pedido(Codigo),
    FOREIGN KEY (IdProduto) REFERENCES Produto(Id)
);

CREATE TABLE MetodoPagamento (
    Id INT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL UNIQUE,
    Ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE Pagamento (
    DataPagamento DATE NOT NULL DEFAULT CURRENT_DATE,
    ValorPago DECIMAL(10,2) NOT NULL CHECK (ValorPago >= 0),
    CodVenda INT NOT NULL,
    IdMetodoPagamento INT NOT NULL,

    PRIMARY KEY (CodVenda, IdMetodoPagamento),
    FOREIGN KEY (CodVenda) REFERENCES Venda(Codigo),
    FOREIGN KEY (IdMetodoPagamento) REFERENCES MetodoPagamento(Id)
);

CREATE TABLE Entrega (
    Id INT PRIMARY KEY,
    Rua VARCHAR(200) NOT NULL,
    Bairro VARCHAR(100) NOT NULL,
    Cep CHAR(9) NOT NULL CHECK (Cep ~ '^\d{5}-\d{3}$'),
    StatusEntrega VARCHAR(50) DEFAULT 'Aguardando' CHECK (StatusEntrega IN ('Aguardando', 'Saiu para entrega', 'Entregue')),
    Prazo TIMESTAMP NOT NULL,
    CodFuncionario INT NOT NULL,
    CodVenda INT NOT NULL,

    FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(Codigo),
    FOREIGN KEY (CodVenda) REFERENCES Venda(Codigo)
);

CREATE TABLE NotaFiscal (
    NumeroSerie VARCHAR(50) NOT NULL UNIQUE,
    ChaveAcesso CHAR(44) UNIQUE CHECK (ChaveAcesso ~ '^\d{44}$'),
    DataEmissao DATE NOT NULL DEFAULT CURRENT_DATE,
    Id INT PRIMARY KEY,
    XmlNota XML NOT NULL
);
