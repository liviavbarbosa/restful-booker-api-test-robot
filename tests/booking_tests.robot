*** Settings ***
Documentation    Execução dos casos de teste do endpoint /booking
Resource         ../resources/booking_keywords.robot

*** Test Cases ***
Cenario 01: Criar reserva com sucesso
    [Tags]    POST
    Criar Sessao
    POST Endpoint /booking    nome_cliente=Maria    sobrenome_cliente=Meireles    preco_reserva=6000    deposito_pago=${False}    
    ...                       checkin=2019-12-30    checkout=2020-01-02    necessidades_adicionais=Lanche
    Validar Status Code    status_code=200
    Validar se a Resposta Contem "bookingid"

Cenario 02: Editar reserva com sucesso
    [Tags]    PUT
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    PUT Endpoint /booking/id    id_reserva=${ID_RESERVA}    nome_cliente=Claudia    sobrenome_cliente=Soares    preco_reserva=6000    deposito_pago=${False}    
    ...                         checkin=2019-12-30    checkout=2020-01-02    necessidades_adicionais=Lanche    token=${TOKEN} 
    Validar Status Code    status_code=200

Cenario 03: Editar parcialmente reserva com sucesso
    [Tags]    PATCH
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    PATCH Endpoint /booking/id    id_reserva=${ID_RESERVA}    token=${TOKEN}    preco_reserva=7000    deposito_pago=true
    Validar Status Code    status_code=200

Cenario 04: Buscar ids de reservas com sucesso
    [Tags]    GET
    Criar Sessao
    GET Endpoint /booking
    Validar Status Code    status_code=200

Cenario 05: Buscar reserva com sucesso
    [Tags]    GET
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    GET Endpoint /booking/id    id_reserva=${ID_RESERVA}
    Validar Status Code    status_code=200

Cenario 06: Excluir reserva com sucesso
    [Tags]    DELETE
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    DELETE Endpoint /booking/id    id_reserva=${ID_RESERVA}    token=${TOKEN}
    Validar Status Code    status_code=201

Cenario 07: Criar reserva com campos nulos
    [Tags]    POST
    Criar Sessao
    POST Endpoint /booking    nome_cliente=${EMPTY}    sobrenome_cliente=${EMPTY}   preco_reserva=6000    deposito_pago=${EMPTY}    
    ...                       checkin=2019-12-30    checkout=2020-01-02    necessidades_adicionais=Lanche
    Validar Status Code    status_code=400

Cenario 08: Criar reserva com campos com tipagem errada
    [Tags]    POST
    Criar Sessao
    POST Endpoint /booking    nome_cliente=${True}    sobrenome_cliente=Bonoto   preco_reserva="1200"    deposito_pago=true   
    ...                       checkin=2019/12/30    checkout=2020/01/02    necessidades_adicionais=Lanche
    Validar Status Code    status_code=400

Cenario 09: Criar reserva com campos com data de checkout anterior à data de checkin
    [Tags]    POST
    Criar Sessao
    POST Endpoint /booking    nome_cliente=Ana   sobrenome_cliente=Amarantes   preco_reserva=1200    deposito_pago=${False} 
    ...                       checkin=2023-02-28    checkout=2023/02/05    necessidades_adicionais=Lanche
    Validar Status Code    status_code=400

Cenario 10: Criar reserva com campos com valores numéricos inválidos
    [Tags]    POST
    Criar Sessao
    POST Endpoint /booking    nome_cliente=Ana   sobrenome_cliente=Amarantes   preco_reserva=-10000    deposito_pago=${False} 
    ...                       checkin=2019-12-30    checkout=2020-01-02    necessidades_adicionais=Lanche
    Validar Status Code    status_code=400

Cenario 11: Editar reserva com campos nulos
    [Tags]    PUT
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    PUT Endpoint /booking/id    id_reserva=${ID_RESERVA}    nome_cliente=Claudia    sobrenome_cliente=Soares    preco_reserva=${EMPTY}    deposito_pago=${False}    
    ...                         checkin=${EMPTY}   checkout=${EMPTY}    necessidades_adicionais=Lanche    token=${TOKEN} 
    Validar Status Code    status_code=400

Cenario 12: Editar reserva com campos com tipagem errada
    [Tags]    PUT
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    PUT Endpoint /booking/id    id_reserva=${ID_RESERVA}    nome_cliente=12    sobrenome_cliente=Soares    preco_reserva="12000"    deposito_pago=${True}    
    ...                         checkin=2020-06-23    checkout=2019-09-12    necessidades_adicionais=Piscina    token=${TOKEN} 
    Validar Status Code    status_code=400

Cenario 13: Editar reserva com campos com valores numéricos inválidos
    [Tags]    PUT
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    PUT Endpoint /booking/id    id_reserva=${ID_RESERVA}    nome_cliente=Carolina    sobrenome_cliente=Silva    preco_reserva=-0    deposito_pago=${True}    
    ...                         checkin=2020-06-23    checkout=2019-09-12    necessidades_adicionais=Piscina    token=${TOKEN} 
    Validar Status Code    status_code=400

Cenario 14: Editar reserva sem autenticação
    [Tags]    PUT
    Criar Sessao
    PUT Endpoint /booking/id    id_reserva=${ID_RESERVA}    nome_cliente=Claudia    sobrenome_cliente=Soares    preco_reserva=6000    deposito_pago=${False}    
    ...                         checkin=2019-12-30    checkout=2020-01-02    necessidades_adicionais=Lanche    token=${EMPTY} 
    Validar Status Code    status_code=403

Cenario 15: Editar parcialmente reserva com campos nulos
    [Tags]    PATCH
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    PATCH Endpoint /booking/id    id_reserva=${ID_RESERVA}    token=${TOKEN}    nome_cliente=${EMPTY}
    Validar Status Code    status_code=400

Cenario 16: Editar parcialmente reserva com campos com tipagem errada
    [Tags]    PATCH
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    PATCH Endpoint /booking/id    id_reserva=${ID_RESERVA}    token=${TOKEN}    nome_cliente=125
    Validar Status Code    status_code=400

Cenario 17: Editar parcialmente reserva sem autenticação
    [Tags]    PATCH
    Criar Sessao
    PATCH Endpoint /booking/id    id_reserva=${ID_RESERVA}    token=${EMPTY}    nome_cliente=Livia
    Validar Status Code    status_code=403

Cenario 18: Excluir reserva sem autenticação
    [Tags]    DELETE
    Criar Sessao
    DELETE Endpoint /booking/id    id_reserva=${ID_RESERVA}    token=${EMPTY}
    Validar Status Code    status_code=403