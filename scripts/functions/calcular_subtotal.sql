CREATE OR REPLACE FUNCTION calcular_subtotal(v_id INT, v_qtd INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    v_Preco DECIMAL(10,2);
    v_Subtotal DECIMAL(10,2);
BEGIN

    SELECT PrecoVenda INTO v_Preco FROM Produto WHERE Id = v_id;

    v_Subtotal := v_Preco * v_qtd;

    RETURN v_Subtotal;
END;
$$ LANGUAGE plpgsql;
