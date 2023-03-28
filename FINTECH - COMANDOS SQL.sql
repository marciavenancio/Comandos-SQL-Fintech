--INSERIR OS DADOS DO USUÁRIO
INSERT INTO T_CLIENTE ( cpf, nm_cliente, ds_email, ds_senha, dt_nasc )
VALUES ( [CPF], 'NM_CLIENTE', 'DS_EMAIL', '******', [ dt_nasc TO_DATE('00/00/0000','DD/MM/YYYY')]);

INSERT INTO T_TIPO_TEL (cd_tipo_tel, tipo_tel)
VALUES ([cd_tipo_tel], 'TIPO_TEL');

INSERT INTO T_TELEFONE (cd_telefone, nr_telefone,t_cliente_cpf, t_tipo_tel_cd_tipo_tel)
VALUES ([cd_telefone], [nr_telefone], [CPF],[cd_tipo_tel]);


--ALTERAR DADOS DO USUÁRIO
 UPDATE 	 T_CLIENTE
	SET  nm_cliente = 'NM_CLIENTE',
         ds_email = 'DS_EMAIL',
         ds_senha = '******'
  WHERE cpf=[CPF];

UPDATE 	T_TELEFONE
    SET nr_telefone= [nr_telefone]
  WHERE t_cliente_cpf=[CPF];


 INSERT INTO T_TIPO_RECEB (cd_tipo_receb, ds_tipo_receb)
  VALUES ([cd_tipo_receb], 'ds_tipo_receb');

  INSERT INTO T_RECEBIMENTO (cd_recebimento, data_recebimento,valor_recebido,ds_origem_recebimento, t_cliente_cpf, t_tipo_receb_cd_tipo_receb)
  VALUES ([cd_recebimento], [data_recebimento TO_DATE('00/00/0000','DD/MM/YYYY')], [valor_recebido], 'ds_origem_recebimento', [CPF], [cd_tipo_receb);
  

   UPDATE T_RECEBIMENTO
  SET data_recebimento = [data_recebimento TO_DATE('00/00/0000','DD/MM/YYYY')],
      valor_recebido = [valor_recebido],
      ds_origem_recebimento = 'ds_origem_recebimento'
    WHERE t_cliente_cpf = [CPF];


INSERT INTO T_TIPO_GASTO (cd_tipo_gasto, ds_tipo_gasto)
VALUES ([cd_tipo_gasto], 'ds_tipo_gasto');

INSERT INTO T_GASTO (cd_gasto, data_gasto, valor_gasto, ds_gasto, t_cliente_cpf, t_tipo_gasto_cd_tipo_gasto)
VALUES ([cd_gasto], [data_gasto TO_DATE('00/00/0000','DD/MM/YYYY')], [valor_gasto], 'ds_gasto', [CPF], [cd_tipo_gasto]);

UPDATE T_GASTO
SET data_gasto = [data_gasto TO_DATE('00/00/0000','DD/MM/YYYY')],
    valor_gasto = [valor_gasto],
    ds_gasto = 'ds_gasto'
WHERE t_cliente_cpf = [CPF];

INSERT INTO T_TIPO_APLIC (cd_tipo_aplic, ds_tipo_aplic)
VALUES ([cd_tipo_aplic], 'ds_tipo_aplic');

INSERT INTO T_APLICACAO (cd_aplicacao, nm_aplicacao, data_aplicacao, vl_aplicado, vl_rendimento, dt_resgate, t_cliente_cpf, t_tipo_aplic_cd_tipo_aplic)
VALUES ([cd_aplicacao], 'nm_aplicacao', [data_aplicacao TO_DATE('00/00/0000','DD/MM/YYYY')], [vl_aplicado], [vl_rendimento], [dt_resgate], [CPF], [cd_tipo_aplic]);

UPDATE T_APLICACAO 
SET nm_aplicacao = 'nm_aplicacao',
    data_aplicacao= [data_aplicacao TO_DATE('00/00/0000','DD/MM/YYYY')],
    vl_aplicado = [vl_aplicado],
    vl_rendimento = [vl_rendimento]
WHERE t_cliente_cpf= [CPF];

--CONSULTAS
SELECT cpf, nm_cliente, ds_email, ds_senha, dt_nasc
FROM T_CLIENTE 
WHERE cpf=[CPF];

SELECT cd_gasto, data_gasto, valor_gasto, ds_gasto, t_tipo_gasto_cd_tipo_gasto "Cod Tipo de Gasto", t_cliente_cpf "CPF"
FROM T_GASTO
WHERE t_cliente_cpf= [CPF] and cd_gasto=[cd];

SELECT cd_gasto, data_gasto, valor_gasto, ds_gasto, t_tipo_gasto_cd_tipo_gasto "Cod Tipo de Gasto", t_cliente_cpf "CPF"
FROM T_GASTO
WHERE t_cliente_cpf= [CPF]
ORDER BY data_gasto DESC ;

SELECT cd_aplicacao, nm_aplicacao, data_aplicacao, vl_aplicado, vl_rendimento, dt_resgate, t_cliente_cpf "CPF", t_tipo_aplic_cd_tipo_aplic "Cod Tipo de Aplicação"
FROM T_APLICACAO
WHERE t_cliente_cpf= [CPF] AND cd_aplicacao=10;

SELECT cd_aplicacao, nm_aplicacao, data_aplicacao, vl_aplicado, vl_rendimento, dt_resgate, t_cliente_cpf "CPF", t_tipo_aplic_cd_tipo_aplic "Cod Tipo de Aplicação"
FROM T_APLICACAO
WHERE t_cliente_cpf= [CPF]
ORDER BY data_aplicacao desc;

SELECT C.cpf, C.nm_cliente, A.nm_aplicacao, A.data_aplicacao, A.vl_aplicado, G.data_gasto, G.valor_gasto, G.ds_gasto
FROM T_CLIENTE C, T_APLICACAO A, T_GASTO G
WHERE C.cpf = A.t_cliente_cpf AND C.cpf = G.t_cliente_cpf AND ROWNUM < 2
ORDER BY A.data_aplicacao, G.data_gasto DESC;