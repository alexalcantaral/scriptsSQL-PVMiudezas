CREATE OR REPLACE PROCEDURE aprovar_pedido(v_codPedido INT)
LANGUAGE plpgsql AS $$
DECLARE

BEGIN
    -- Atualiza o status de pedido para aprovado
    UPDATE Pedido
    SET StatusPedido = 'Aprovado'
    WHERE codigo = v_codPedido;
    
    RAISE NOTICE 'Item adicionado com sucesso';
END;
$$;