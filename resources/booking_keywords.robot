*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /booking
Library          RequestsLibrary
Resource         base_keywords.robot
Resource         login_keywords.robot

*** Keywords ***
POST Endpoint /booking
    [Arguments]    ${nome_cliente}    ${sobrenome_cliente}    ${preco_reserva}    ${deposito_pago}    ${checkin}    ${checkout}    ${necessidades_adicionais}
    
    &{datas_reserva}    Create Dictionary    checkin=${checkin}    checkout=${checkout}

    &{payload}    Create Dictionary    
    ...           firstname=${nome_cliente}
    ...           lastname=${sobrenome_cliente}    
    ...           totalprice=${preco_reserva}
    ...           depositpaid=${deposito_pago}
    ...           bookingdates=&{datas_reserva}
    ...           additionalneeds=${necessidades_adicionais}      

    &{header}    Create Dictionary    Content-Type=application/json
    ...           Accept=application/json

    ${response}    POST On Session    restful-booker    /booking    json=&{payload}    expected_status=any    
    Set Global Variable    ${ID_RESERVA}    ${response.json()["bookingid"]}
    Set Global Variable    ${response}
    Set Global Variable    &{payload}

PUT Endpoint /booking/id
    [Arguments]    ${id_reserva}    ${nome_cliente}    ${sobrenome_cliente}    ${preco_reserva}    ${deposito_pago}    ${checkin}    ${checkout}    ${necessidades_adicionais}    ${token}
    
    &{datas_reserva}    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    
    &{payload}    Create Dictionary    
    ...           firstname=${nome_cliente}
    ...           lastname=${sobrenome_cliente}    
    ...           totalprice=${preco_reserva}
    ...           depositpaid=${deposito_pago}
    ...           bookingdates=&{datas_reserva}
    ...           additionalneeds=${necessidades_adicionais}

    &{header}    Create Dictionary
    ...           Content-Type=application/json
    ...           Accept=application/json
    ...           Cookie=token=${token}

    ${response}    PUT On Session    restful-booker    /booking/${ID_RESERVA}    json=&{payload}    headers=${header}    expected_status=any
    Set Global Variable    ${response}

PATCH Endpoint /booking/id
    [Arguments]    ${id_reserva}    ${token}    &{dados_modificar}
    &{header}    Create Dictionary
    ...           Content-Type=application/json
    ...           Accept=application/json
    ...           Cookie=token=${token}

    ${response}    PATCH On Session    restful-booker    /booking/${id_reserva}    json=&{dados_modificar}    headers=${header}    expected_status=any
    Set Global Variable    ${response}

GET Endpoint /booking
    ${response}    GET On Session    restful-booker    /booking
    Set Global Variable    ${response}

GET Endpoint /booking/id    
    [Arguments]    ${id_reserva}
    ${response}    GET On Session    restful-booker    /booking/${ID_RESERVA}    expected_status=any
    Set Global Variable    ${id_reserva}

DELETE Endpoint /booking/id
    [Arguments]    ${id_reserva}    ${token}
    &{header}    Create Dictionary
    ...           Content-Type=application/json
    ...           Accept=application/json
    ...           Cookie=token=${token}

    ${response}    DELETE On Session    restful-booker    /booking/${id_reserva}    headers=${header}    expected_status=any
    Set Global Variable    ${response}