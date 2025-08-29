*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /auth
Library          RequestsLibrary
Resource         base_keywords.robot

*** Keywords ***
POST Endpoint /auth
    [Arguments]    ${username}    ${password}
    &{payload}    Create Dictionary    
    ...           username=${username}
    ...           password=${password}
    ${response}    POST On Session    restful-booker    /auth    json=&{payload}    expected_status=any
    ${token}=    Evaluate    $response.json().get("token")
    IF    "${token}" != "None"
        Set Global Variable    ${TOKEN}    ${token}
    END
    Set Global Variable    ${response}