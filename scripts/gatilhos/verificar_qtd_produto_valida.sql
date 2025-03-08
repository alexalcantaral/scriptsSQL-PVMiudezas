CREATE OR REPLACE FUNCTION verificar_qtd_produto_valida()
RETURNS TRIGGER AS $$
DECLARE
    v_QuantidadeProduto INT;
BEGIN
    -- Obtém a quantidade disponível no estoque
    SELECT QtdEstoque INTO v_QuantidadeProduto 
    FROM Produto 
    WHERE Id = NEW.idProduto;

    -- Se a nova quantidade for maior que o estoque, impede a operação
    IF NEW.Quantidade > v_QuantidadeProduto THEN
        RAISE EXCEPTION 'Quantidade solicitada (%s) excede o estoque disponível (%s) para o produto ID %s', 
                        NEW.Quantidade, v_QuantidadeProduto, NEW.idProduto;
    END IF;

    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

-- Criar o gatilho para verificar a quantidade antes de inserir ou atualizar um item na venda
CREATE TRIGGER gatilho_verificar_qtd_produto_valida
BEFORE INSERT OR UPDATE ON ItemVenda
FOR EACH ROW
EXECUTE FUNCTION verificar_qtd_produto_valida();
