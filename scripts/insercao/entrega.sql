-- Vendas que fazem sentido para entregadores
-- Venda 1: feita por Savio Antartica para Carlos Souza
-- Venda 2: feita por Ana Cecilia para Mariana Lima
-- Venda 3: feita por Savio Antartica sem cliente
-- Venda 4: feita por Ana Cecilia para Rafael Oliveira
-- Venda 5: feita por Savio Antartica sem cliente

-- Primeira venda - Duas entregas para diferentes prazos
INSERT INTO Entrega (Rua, Bairro, Cep, Observacoes, StatusEntrega, Prazo, CodFuncionario, CodVenda)
VALUES 
('Rua das Flores, 50', 'Centro', '12345-678', 'Entregar rapidamente, cliente aguardando', 'Aguardando', '2024-02-16 10:00:00', 3, 1),  -- Entregador: Sergio Rolim, Venda 1
('Rua das Flores, 50', 'Centro', '12345-678', 'Segunda entrega agendada, o cliente solicitou manhã seguinte', 'Saiu para entrega', '2024-02-17 09:00:00', 3, 1);  -- Entregador: Sergio Rolim, Venda 1

-- Segunda venda - Uma entrega para o cliente
INSERT INTO Entrega (Rua, Bairro, Cep, Observacoes, StatusEntrega, Prazo, CodFuncionario, CodVenda)
VALUES 
('Rua das Palmeiras, 22', 'Jardins', '23456-789', 'Cliente pede para ser entregue no mesmo dia', 'Saiu para entrega', '2024-02-02 14:30:00', 3, 2);  -- Entregador: Sergio Rolim, Venda 2

-- Terceira venda - Entrega sem cliente
INSERT INTO Entrega (Rua, Bairro, Cep, Observacoes, StatusEntrega, Prazo, CodFuncionario, CodVenda)
VALUES 
('Rua sem Nome, 100', 'Zona Norte', '34567-890', 'Entrega para estoque', 'Entregue', '2024-01-12 11:00:00', 3, 3);  -- Entregador: Sergio Rolim, Venda 3

-- Quarta venda - Duas entregas para diferentes prazos
INSERT INTO Entrega (Rua, Bairro, Cep, Observacoes, StatusEntrega, Prazo, CodFuncionario, CodVenda)
VALUES 
('Av. Brasil, 300', 'Zona Oeste', '45678-901', 'Cliente solicitou entrega urgente', 'Saiu para entrega', '2024-02-06 10:00:00', 3, 4),  -- Entregador: Sergio Rolim, Venda 4
('Av. Brasil, 300', 'Zona Oeste', '45678-901', 'Cliente aguardando a entrega até o fim da tarde', 'Aguardando', '2024-02-06 15:00:00', 3, 4);  -- Entregador: Sergio Rolim, Venda 4

-- Quinta venda - Entrega sem cliente
INSERT INTO Entrega (Rua, Bairro, Cep, Observacoes, StatusEntrega, Prazo, CodFuncionario, CodVenda)
VALUES 
('Rua da Praia, 500', 'Centro', '56789-012', 'Entrega de estoque', 'Entregue', '2024-01-20 10:00:00', 3, 5);  -- Entregador: Sergio Rolim, Venda 5
