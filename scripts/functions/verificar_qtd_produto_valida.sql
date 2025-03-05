CREATE OR REPLACE FUNCTION verificar_qtd_produto_valida(v_idProduto INT, v_qtd INT)
RETURNS BOOLEAN AS $$
DECLARE
    v_qtdTotal INT;
BEGIN
    -- Obtém a quantidade total de estoque para o produto
    SELECT QtdEstoque INTO v_qtdTotal FROM Produto WHERE Id = v_idProduto;

    -- Verifica se a quantidade fornecida é maior que zero e menor ou igual ao estoque
    RETURN CASE
        WHEN v_qtd > 0 AND v_qtd <= v_qtdTotal THEN TRUE  -- Se a quantidade for válida
        ELSE FALSE  -- Caso contrário
    END;
END;
$$ LANGUAGE plpgsql;
