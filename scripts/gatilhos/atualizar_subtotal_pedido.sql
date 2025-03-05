CREATE OR REPLACE FUNCTION atualizar_subtotal_pedido()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza o subtotal do pedido somando todos os subtotais dos itens relacionados
    UPDATE Pedido
    SET Subtotal = (
        SELECT COALESCE(SUM(SubtotalItemPedido), 0) 
        FROM PedidoProduto 
        WHERE CodPedido = NEW.CodPedido
    )
    WHERE Codigo = NEW.CodPedido;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_subtotal_pedido
AFTER INSERT OR UPDATE ON PedidoProduto
FOR EACH ROW
EXECUTE FUNCTION atualizar_subtotal_pedido();
