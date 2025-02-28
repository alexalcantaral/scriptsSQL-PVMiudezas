INSERT INTO ItemVenda (Subtotal, Quantidade, CodVenda, IdProduto) 
VALUES 
    -- Venda 1: Total 150.00
    ((SELECT calcular_subtotal(1, 3)), 3, 1, 1),  
    ((SELECT calcular_subtotal(5, 1)), 1, 1, 5),  

    -- Venda 2: Total 300.50
    ((SELECT calcular_subtotal(2, 2)), 2, 2, 2),  
    ((SELECT calcular_subtotal(3, 1)), 1, 2, 3),  

    -- Venda 3: Total 50.00 (Sem cliente)
    ((SELECT calcular_subtotal(3, 1)), 1, 3, 3),  
    ((SELECT calcular_subtotal(4, 1)), 1, 3, 4),  

    -- Venda 4: Total 500.00
    ((SELECT calcular_subtotal(6, 5)), 5, 4, 6),  
    ((SELECT calcular_subtotal(5, 1)), 1, 4, 5),  
    ((SELECT calcular_subtotal(3, 1)), 1, 4, 3),  

    -- Venda 5: Total 200.00 (Sem cliente)
    ((SELECT calcular_subtotal(2, 1)), 1, 5, 2),  
    ((SELECT calcular_subtotal(3, 1)), 1, 5, 3);  
