CREATE OR REPLACE PROCEDURE adicionar_item_venda(v_idProduto INT, v_qtd INT, v_codVenda INT)
LANGUAGE plpgsql AS $$
DECLARE

BEGIN

    -- Insere o item na tabela ItemVenda
    INSERT INTO ItemVenda (Subtotal, Quantidade, CodVenda, IdProduto) 
    VALUES 
    ((SELECT calcular_subtotal(v_idProduto, v_qtd)), v_qtd, v_codVenda, v_idProduto);

    -- Se chegar aqui, o item foi adicionado com sucesso
    RAISE NOTICE 'Item adicionado com sucesso';
END;
$$;
