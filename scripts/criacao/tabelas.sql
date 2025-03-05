CREATE TABLE Funcionario (
    Codigo SERIAL PRIMARY KEY,
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

CREATE TABLE Categoria (
    Id SERIAL PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Produto (
    Id SERIAL PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    Descricao VARCHAR(300),
    Marca VARCHAR(50) NOT NULL,
    QtdEstoque INT NOT NULL DEFAULT 0 CHECK (QtdEstoque >= 0),
    LocalizacaoEstoque VARCHAR(200) NOT NULL,
    PrecoVenda DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (PrecoVenda >= 0),
    UnidadeMedida VARCHAR(20),
    IdCategoria INT NOT NULL,
    
    UNIQUE(Nome, Marca),
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id)
);

CREATE TABLE NotaFiscal (
    Id SERIAL PRIMARY KEY,
    NumeroSerie VARCHAR(50) NOT NULL UNIQUE,
    ChaveAcesso CHAR(44) NOT NULL UNIQUE CHECK (ChaveAcesso ~ '^\d{44}$'),
    DataEmissao DATE NOT NULL DEFAULT CURRENT_DATE,
    XmlNota XML NOT NULL
);

CREATE TABLE Venda (
    Codigo SERIAL PRIMARY KEY,
    Subtotal DECIMAL(10,2) DEFAULT 0 CHECK (Subtotal >= 0),
    Desconto DECIMAL(10,2) DEFAULT 0 CHECK (Desconto >= 0 AND Desconto <= Subtotal),
    DataVenda DATE NOT NULL DEFAULT CURRENT_DATE,
    Status VARCHAR(20) NOT NULL DEFAULT 'Pendente' CHECK (Status IN ('Pendente', 'Finalizada')),
    CodFuncionario INT NOT NULL,
    CpfCliente CHAR(11) NOT NULL,
    NotaVenda INT,
    
    FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(Codigo),
    FOREIGN KEY (CpfCliente) REFERENCES Cliente(Cpf),
    FOREIGN KEY (NotaVenda) REFERENCES NotaFiscal(Id)
);

CREATE TABLE ItemVenda (
    Subtotal DECIMAL(10,2) NOT NULL CHECK (Subtotal >= 0),
    Quantidade INT NOT NULL CHECK (Quantidade > 0),
    CodVenda INT NOT NULL,
    IdProduto INT NOT NULL,

    PRIMARY KEY (CodVenda, IdProduto),
    FOREIGN KEY (CodVenda) REFERENCES Venda(Codigo),
    FOREIGN KEY (IdProduto) REFERENCES Produto(Id)
);

CREATE TABLE MetodoPagamento (
    Id SERIAL PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL UNIQUE CHECK (Tipo IN ('Crédito', 'Débito', 'PIX', 'Dinheiro', 'Boleto')),
    Descricao VARCHAR(100),
    Taxa DECIMAL(5,2) DEFAULT 0 CHECK (Taxa >= 0), 
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

CREATE TABLE Fornecedor (
    Nome VARCHAR(100) NOT NULL,
    Cnpj CHAR(14) PRIMARY KEY CHECK (Cnpj ~ '^\d{14}$'),
    Telefone CHAR(11) NOT NULL CHECK (Telefone ~ '^\d{10,11}$'),
    Ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE ForneceProduto (
    CnpjFornecedor CHAR(14) NOT NULL,
    IdProduto INT NOT NULL,
    Ativo BOOLEAN NOT NULL DEFAULT TRUE,

    PRIMARY KEY (CnpjFornecedor, IdProduto),
    FOREIGN KEY (IdProduto) REFERENCES Produto(Id),
    FOREIGN KEY (CnpjFornecedor) REFERENCES Fornecedor(Cnpj)
);

CREATE TABLE Pedido (
    Codigo SERIAL PRIMARY KEY,
    DataPedido DATE NOT NULL DEFAULT CURRENT_DATE,
    Subtotal DECIMAL(10,2) NOT NULL CHECK (Subtotal >= 0),
    StatusPedido VARCHAR(50) DEFAULT 'Pendente' CHECK (StatusPedido IN ('Pendente', 'Aprovado', 'Cancelado', 'Concluído')),
    CnpjFornecedor CHAR(14) NOT NULL,
    CodFuncionario INT NOT NULL,
    NotaPedido INT UNIQUE,
    Prazo DATE NOT NULL CHECK (Prazo >= CURRENT_DATE),

    FOREIGN KEY (CnpjFornecedor) REFERENCES Fornecedor(Cnpj),
    FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(Codigo),
    FOREIGN KEY (NotaPedido) REFERENCES NotaFiscal(Id)
);

CREATE TABLE PedidoProduto (
    Quantidade INT NOT NULL CHECK (Quantidade > 0),
    SubtotalItemPedido DECIMAL(10,2) NOT NULL CHECK (SubtotalItemPedido >= 0),
    PrecoCompraFornecedor DECIMAL(10,2) NOT NULL CHECK (PrecoCompraFornecedor >= 0),
    CodPedido INT NOT NULL,
    IdProduto INT NOT NULL,

    PRIMARY KEY (CodPedido, IdProduto),
    FOREIGN KEY (CodPedido) REFERENCES Pedido(Codigo),
    FOREIGN KEY (IdProduto) REFERENCES Produto(Id)
);

CREATE TABLE Entrega (
    Id SERIAL PRIMARY KEY,
    Rua VARCHAR(200) NOT NULL,
    Bairro VARCHAR(100) NOT NULL,
    Cep CHAR(9) NOT NULL CHECK (Cep ~ '^\d{5}-\d{3}$'),
    Observacoes TEXT,
    StatusEntrega VARCHAR(50) DEFAULT 'Aguardando' CHECK (StatusEntrega IN ('Aguardando', 'Saiu para entrega', 'Atrasada', 'Entregue')),
    Prazo TIMESTAMP NOT NULL,
    CodFuncionario INT NOT NULL,
    CodVenda INT NOT NULL,

    FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(Codigo),
    FOREIGN KEY (CodVenda) REFERENCES Venda(Codigo)
);
