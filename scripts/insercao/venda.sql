INSERT INTO Venda (Subtotal, Desconto, DataVenda, CodFuncionario, CpfCliente, NotaVenda) 
VALUES 
    (0, 10.00, '2024-02-15', 1, '12345678901', 1),  -- Venda feita por Savio Antartica para Carlos Souza
    (0, 20.50, '2024-01-30', 4, '23456789012', 2),  -- Venda feita por Ana Cecilia para Mariana Lima
    (0, 0.00, '2023-12-10', 1, NULL, 3),            -- Venda sem cliente por Savio Antartica
    (0, 50.00, '2024-02-05', 4, '34567890123', 4),  -- Venda feita por Ana Cecilia para Rafael Oliveira
    (0, 5.00, '2024-01-20', 1, NULL, 5);           -- Venda sem cliente por Savio Antartica