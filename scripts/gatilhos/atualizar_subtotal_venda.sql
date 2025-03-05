CREATE OR REPLACE FUNCTION atualizar_subtotal_venda()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza o subtotal do pedido somando todos os subtotais dos itens relacionados
    UPDATE Venda
    SET Subtotal = (
        SELECT COALESCE(SUM(Subtotal), 0) 
        FROM ItemVenda 
        WHERE CodVenda = NEW.CodVenda
    )
    WHERE Codigo = NEW.CodVenda;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_subtotal_venda
AFTER INSERT OR UPDATE ON ItemVenda
FOR EACH ROW
EXECUTE FUNCTION atualizar_subtotal_venda();