CREATE OR REPLACE FUNCTION atualizar_status_venda() 
RETURNS TRIGGER AS $$
DECLARE
    v_TotalVenda DECIMAL(10,2);
    v_TotalPago DECIMAL(10,2);
    v_StatusVenda VARCHAR(20);
	v_IdProduto INT;
    v_Quantidade INT;
BEGIN
    -- Pega o total da venda
    SELECT (Subtotal - Desconto) INTO v_TotalVenda FROM Venda WHERE Codigo = NEW.CodVenda;

    -- Soma o total pago até o momento
    SELECT COALESCE(SUM(ValorPago), 0) INTO v_TotalPago FROM Pagamento WHERE CodVenda = NEW.CodVenda;

    -- Pega o status atual da venda
    SELECT Status INTO v_StatusVenda FROM Venda WHERE Codigo = NEW.CodVenda;

    -- Se a venda já estiver concluída, não faz nada
    IF v_StatusVenda = 'Concluida' THEN
        RETURN NULL;
    END IF;

    -- Verifica se o total pago é igual ou maior que o total da venda
    IF v_TotalPago >= v_TotalVenda THEN
        -- Atualiza o status da venda para 'Concluida'
        UPDATE Venda SET Status = 'Concluida' WHERE Codigo = NEW.CodVenda;

        FOR v_IdProduto, v_Quantidade IN
            SELECT IdProduto, Quantidade FROM ItemVenda WHERE CodVenda = NEW.CodVenda
        LOOP
            -- Atualiza a quantidade em estoque
            UPDATE Produto 
            SET QtdEstoque = QtdEstoque - v_Quantidade
            WHERE Id = v_IdProduto;
        END LOOP;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Criar o gatilho
CREATE TRIGGER gatilho_atualizar_status_venda
AFTER INSERT OR UPDATE ON Pagamento
FOR EACH ROW
EXECUTE FUNCTION atualizar_status_venda();
