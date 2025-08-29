*** Settings ***
Documentation    Execução dos casos de teste do endpoint /auth
Resource         ../resources/login_keywords.robot

*** Test Cases ***
Cenario 01: Fazer login com sucesso
    [Tags]    POST
    Criar Sessao
    POST Endpoint /auth    username=admin    password=password123
    Validar Status Code    status_code=200
    Validar se a Resposta Contem "token"

Cenario 02: Fazer login com campos vazios
    [Tags]    POST
    Criar Sessao
    POST Endpoint /auth    username=${EMPTY}    password=${EMPTY}
    Validar Status Code    status_code=400

Cenario 03: Fazer login com campos senha incorreta
    [Tags]    POST
    Criar Sessao
    POST Endpoint /auth    username=admin   password=123
    Validar Status Code    status_code=400