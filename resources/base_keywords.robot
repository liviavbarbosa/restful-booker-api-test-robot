*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste
Library          RequestsLibrary
Resource         login_keywords.robot

*** Keywords ***
*** Variables ***
${URL_BASE}    https://restful-booker.herokuapp.com
${USERNAME}    admin
${PASSWORD}    password123

*** Keywords ***
Criar Sessao
    Create Session    restful-booker    ${URL_BASE}

Validar Status Code 
    [Arguments]    ${status_code}
    Should Be Equal As Integers    ${response.status_code}    ${status_code}

Validar se a Resposta Contem "${palavra}"
    Should Contain    ${response.json()}    ${palavra}