CREATE OR REPLACE PROCEDURE adicionar_item_venda(v_idProduto INT, v_qtd INT, v_codVenda INT)
LANGUAGE plpgsql AS $$
DECLARE
    v_qtdValida BOOLEAN;
BEGIN
    -- Verifica se a quantidade fornecida é válida
    v_qtdValida := verificar_qtd_produto_valida(v_idProduto, v_qtd);

    -- Se a quantidade não for válida, gera um erro
    IF NOT v_qtdValida THEN
        RAISE EXCEPTION 'Erro: Quantidade inválida. Verifique o estoque.';
    END IF;

    -- Insere o item na tabela ItemVenda
    INSERT INTO ItemVenda (Subtotal, Quantidade, CodVenda, IdProduto) 
    VALUES 
    ((SELECT calcular_subtotal(v_idProduto, v_qtd)), v_qtd, v_codVenda, v_idProduto);

    -- Se chegar aqui, o item foi adicionado com sucesso
    RAISE NOTICE 'Item adicionado com sucesso';
END;
$$;
