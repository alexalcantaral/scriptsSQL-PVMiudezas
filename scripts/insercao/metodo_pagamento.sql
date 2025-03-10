INSERT INTO MetodoPagamento (Tipo, Descricao, Taxa, Ativo) 
VALUES 
    ('Crédito', 'Pagamento via cartão de crédito', 2.50, TRUE),
    ('Débito', 'Pagamento via cartão de débito', 1.00, TRUE),
    ('PIX', 'Transferência instantânea via PIX', 0.00, TRUE),
    ('Dinheiro', 'Pagamento em espécie', 0.00, TRUE),
    ('Boleto', 'Pagamento via boleto bancário', 3.00, FALSE);