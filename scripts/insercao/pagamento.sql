-- Venda 1 paga totalmente com Crédito
CALL processar_pagamento(1, 1, 287.60);  -- Pagamento com Crédito

-- Venda 2 paga com PIX e Crédito
CALL processar_pagamento(2, 3, 100.00);  -- Pagamento com PIX
CALL processar_pagamento(2, 1, 165.50);  -- Pagamento com Crédito

-- Venda 3 paga totalmente com Dinheiro
CALL processar_pagamento(3, 4, 45.00);   -- Pagamento com Dinheiro

-- Venda 4 paga com PIX e Crédito
CALL processar_pagamento(4, 3, 200.00);  -- Pagamento com Boleto
CALL processar_pagamento(4, 1, 212.40);  -- Pagamento com Crédito

-- Venda 5 paga com Débito e Dinheiro
CALL processar_pagamento(5, 2, 80.00);   -- Pagamento com Débito
CALL processar_pagamento(5, 4, 80.50);   -- Pagamento com Dinheiro
