CREATE OR REPLACE FUNCTION concluir_pedido()
RETURNS TRIGGER AS $$
DECLARE
v_IdProduto INT;
v_QuantidadePedido INT;
v_PrecoCompraFornecedor DECIMAL(10,2);
BEGIN

IF NEW.StatusPedido = 'Aprovado' THEN
	FOR v_IdProduto, v_QuantidadePedido, v_PrecoCompraFornecedor
	IN (SELECT idProduto, quantidade, precoCompraFornecedor FROM PedidoProduto WHERE codPedido = NEW.codigo)
	LOOP

		UPDATE Produto 
        SET QtdEstoque = QtdEstoque + v_QuantidadePedido, PrecoVenda = v_PrecoCompraFornecedor * 1.25
        WHERE Id = v_IdProduto;
		
	END LOOP;
END IF;

RETURN NULL;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER gatilho_status_aprovado
BEFORE UPDATE ON Pedido
FOR EACH ROW
WHEN (OLD.StatusPedido IS DISTINCT FROM NEW.StatusPedido)
EXECUTE FUNCTION concluir_pedido();
