CREATE OR REPLACE PROCEDURE adicionar_item_pedido(v_idProduto INT, v_qtd INT, v_codPedido INT, v_precoCompra DECIMAL(10,2))
LANGUAGE plpgsql AS $$
DECLARE
    v_qtdValida BOOLEAN;
BEGIN
    -- Insere o item na tabela ItemVenda
    INSERT INTO PedidoProduto (SubtotalItemPedido, Quantidade, CodPedido, IdProduto, PrecoCompraFornecedor) 
    VALUES 
    ((v_precoCompra * v_qtd), v_qtd, v_codPedido, v_idProduto, v_precoCompra);

    -- Se chegar aqui, o item foi adicionado com sucesso
    RAISE NOTICE 'Item adicionado com sucesso';
END;
$$;
