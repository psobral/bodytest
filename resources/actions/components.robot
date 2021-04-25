***Settings***
Documentation           Ações de componentes genéricos

***Keywords***

## Validations
Alert Text Should Be
    [Arguments]     ${expect_text}

    Wait For Elements State        css=form span >> text=${expect_text}     visible     5

# ESSA KEYWORD VERIFICA SE UM DETERMINADO ELEMENTO DO TIPO CAMPO É NUMÉRICO, EMAIL ...
Field Should Be Type  # o CAMPO DEVE SER NUMÉRICO, EMAIL. ..
    [Arguments]         ${element}      ${type}

    ${attr}     Get Attribute        ${element}        type  ## obter o atributo do elemento idade
    Should Be Equal     ${attr}     ${type}   ## e valida se o type do campo idade é numérico, email, text, password ...

Register Should Not Be found 
           
    Wait For Elements State         css=div >> text=Nenhum registro encontrado. 	visible     5     ##deve estar visivel em ate 5egundos
    Wait For Elements State         css=table       detached        5       ##elemento tem ate 5 seg para não estar visivel no html

Total Items Should Be  ##O total de itens deve estar visivel por 5 seg. 
    [Arguments]                     ${number}

    ${element}          Set Variable       css=#pagination .total  

    Wait For Elements State         ${element}          visible         5  ## aqui está garantindo que o elemento esta disponível
    Get Text                        ${element}          ==              Total: ${number}  ##validar o texto


# Toaster
Toaster Text Should Be  # é usado para todas as páginas
    [Arguments]     ${expect_text}

    # Busca pela classe e pelo texto e aguarda até 5 segundos para que o elemento esteja visível 
    Wait For Elements State        css=.Toastify__toast-body >> text=${expect_text}      visible     5 
    ##obtem o elemento "Toastify..." que recebe como parametro o texto 


## Return Elements & Texts (Coisas que Devolvem um elemento)

# OBTER OS ALERTAS OBRIGATORIOS 
Get Required Alerts   ##ENCAPSULAR KEYWORD
    [Arguments]         ${index}

    ${span}     Get Text                xpath=(//form//span)[${index}]    ##KEYWORD - GET TEXT - obter a informação e retornar a informação, ou seja, o texto do elemento de acordo com uma posição        

    [return]            ${span}    # DEVOLVE O VALOR DE SPAN



