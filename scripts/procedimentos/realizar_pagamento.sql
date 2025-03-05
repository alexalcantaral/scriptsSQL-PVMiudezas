CREATE OR REPLACE PROCEDURE processar_pagamento(
    v_CodVenda INT,
    v_IdMetodoPagamento INT,
    v_ValorPago DECIMAL(10,2)
) AS $$
DECLARE
    v_metodoPagamentoAtivo BOOLEAN;
    v_StatusVenda VARCHAR(20);
BEGIN
    -- Verifica se o método de pagamento está ativo
    SELECT Ativo INTO v_metodoPagamentoAtivo FROM MetodoPagamento WHERE Id = v_IdMetodoPagamento;

    IF v_metodoPagamentoAtivo = FALSE THEN
        RAISE EXCEPTION 'Erro: O método de pagamento selecionado está inativo.';
    END IF;

    -- Verifica se a venda já foi concluída
    SELECT Status INTO v_StatusVenda FROM Venda WHERE Codigo = v_CodVenda;

    IF v_StatusVenda = 'Concluida' THEN
        RAISE EXCEPTION 'Erro: A venda já foi concluída e não pode receber novos pagamentos.';
    END IF;

    -- Inserir pagamento
    INSERT INTO Pagamento (CodVenda, IdMetodoPagamento, ValorPago)
    VALUES (v_CodVenda, v_IdMetodoPagamento, v_ValorPago);

    -- Aqui não retornamos nada, mas podemos adicionar uma notificação
    RAISE NOTICE 'Pagamento registrado para a venda %', v_CodVenda;
END;
$$ LANGUAGE plpgsql;
