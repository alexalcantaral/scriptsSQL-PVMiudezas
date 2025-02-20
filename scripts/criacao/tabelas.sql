CREATE TABLE Funcionario (
    Codigo INT PRIMARY KEY,
    DataAdmissao DATE,
    Nome VARCHAR(100),
    DataNascimento DATE,
    Cargo VARCHAR(50),
    Telefone CHAR(11),
    Ativo BOOLEAN
)
;
CREATE TABLE Cliente (
    DataCadastro DATE,
    Cpf CHAR(11) PRIMARY KEY,
    Nome VARCHAR(100),
    Telefone CHAR(11)
)
;
CREATE TABLE Venda (
    Codigo INT PRIMARY KEY,
    Subtotal DECIMAL(10,2),
    Desconto DECIMAL(10,2),
    DataVenda DATE,
    CodFuncionario INT,
    CpfCliente CHAR(11),
    NotaVenda INT,

    FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(Codigo),
    FOREIGN KEY (CpfCliente) REFERENCES Cliente(Cpf)
)
;
CREATE TABLE Categoria (
    Id INT PRIMARY KEY,
    Nome VARCHAR(50)
)
;
CREATE TABLE Produto (
    Id INT PRIMARY KEY,
    Nome VARCHAR(150),
    Descricao VARCHAR(150),
    QuantEstoque INT,
    LocalizacaoEstoque VARCHAR(200),
    PrecoVenda DECIMAL(10,2),
    IdCategoria INT,

    FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id)
)
;
CREATE TABLE ItemVenda (
    Subtotal DECIMAL(10,2),
    Quantidade DECIMAL(10,2),
    CodVenda INT,
    IdProduto INT,
    PrecoCompra DECIMAL(10,2),

    PRIMARY KEY(CodVenda, IdProduto),
    FOREIGN KEY (CodVenda) REFERENCES Venda(Codigo),
    FOREIGN KEY (IdProduto) REFERENCES Produto(ID)
)
;
CREATE TABLE Fornecedor (
    Nome VARCHAR(100),
    Cnpj CHAR(14) PRIMARY KEY,
    Telefone CHAR(11),
    Ativo BOOLEAN
)
;
CREATE TABLE ForneceProduto (
    CnpjFornecedor CHAR(14),
    IdProduto INT,
    Prazo DATE,

    PRIMARY KEY (CnpjFornecedor, IdProduto),
    FOREIGN KEY (IdProduto) REFERENCES Produto(Id),
    FOREIGN KEY (CnpjFornecedor) REFERENCES Fornecedor(Cnpj)
)
;
CREATE TABLE Pedido (
    Codigo INT PRIMARY KEY,
    DataPedido DATE,
    Subtotal DECIMAL(10,2),
    StatusPedido VARCHAR(50),
    CnpjFornecedor CHAR(14),
    CodFuncionario INT,
    NotaPedido INT,
    Prazo DATE,

    FOREIGN KEY (CnpjFornecedor) REFERENCES Fornecedor(Cnpj),
    FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(Codigo)
)
;
CREATE TABLE PedidoProduto (
    Quantidade DECIMAL(10,2),
    PrecoCompra DECIMAL(10,2),
    SubtotalItemPedido DECIMAL(10,2),
    CodPedido INT,
    IdProduto INT,

    PRIMARY KEY (CodPedido, IdProduto),
    FOREIGN KEY (CodPedido) REFERENCES Pedido(Codigo),
    FOREIGN KEY (IdProduto) REFERENCES Produto(Id)
)
;
CREATE TABLE MetodoPagamento (
    Id INT PRIMARY KEY,
    Tipo VARCHAR(50),
    Ativo BOOLEAN
)
;
CREATE TABLE Pagamento (
    DataPagamento DATE,
    ValorPago DECIMAL(10,2),
    CodVenda INT,
    IdMetodoPagamento INT,

    PRIMARY KEY (CodVenda, IdMetodoPagamento),
    FOREIGN KEY (CodVenda) REFERENCES Venda(Codigo),
    FOREIGN KEY (IdMetodoPagamento) REFERENCES MetodoPagamento(Id)
)
;
CREATE TABLE Entrega (
    Id INT PRIMARY KEY,
    Rua VARCHAR(200),
    Bairro VARCHAR(100),
    Cep CHAR(9),
    StatusEntrega VARCHAR(50),
    Prazo TIMESTAMP,
    CodFuncionario INT,
    CodVenda INT,

    FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(Codigo),
    FOREIGN KEY (CodVenda) REFERENCES Venda(Codigo)
)
;
CREATE TABLE NotaFiscal (
    NumeroSerie VARCHAR(50),
    ChaveAcesso CHAR(44) UNIQUE,
    DataEmissao DATE,
    Id INT PRIMARY KEY,
    XmlNota XML
)
;