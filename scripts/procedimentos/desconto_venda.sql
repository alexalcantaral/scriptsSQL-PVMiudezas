CREATE OR REPLACE PROCEDURE desconto_venda(v_codVenda INT, v_desconto DECIMAL(10,2))
LANGUAGE plpgsql AS $$
DECLARE
    v_subtotalVenda DECIMAL(10,2);
BEGIN
    -- Obtém o subtotal da venda
    SELECT Subtotal INTO v_subtotalVenda FROM Venda WHERE Codigo = v_codVenda;

    -- Verifica se a venda existe
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Nenhuma venda encontrada com o código %s', v_codVenda;
    END IF;

    -- Valida se o desconto é maior que o subtotal
    IF v_desconto > v_subtotalVenda THEN
        RAISE EXCEPTION 'O desconto de %s para a venda com o código %s é maior que seu subtotal %s', 
                        v_desconto, v_codVenda, v_subtotalVenda;
    END IF;

    -- Aplica o desconto
    UPDATE Venda 
    SET Desconto = v_desconto
    WHERE Codigo = v_codVenda;

    -- Mensagem de sucesso
    RAISE NOTICE 'Desconto de %s aplicado com sucesso para a venda %s', v_desconto, v_codVenda;
END;
$$;
