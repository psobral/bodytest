***Settings***
Documentation       Suite de Cadastro de planos

Resource    ${EXECDIR}/resources/actions/base.robot

# criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
Suite Setup     Start Admin Session  # cria a sessão do navegador e faz o login como administrador 
                # keyword base.robot
                # pré-condição para Login 

#Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot


***Test Cases***
Cenário: Calcular preço total do plano

    &{plan}     Create Dictionary       title=Plano Anual      duration=12     price=19,99     total=R$ 239,88

    Go To Plans                       # acessando planos
    Go To Form Plan                   # Formulário de Cadastro de PLanos
    Fill Plan Form              ${plan}   # preenchendo form conpleto de planos
    #Submit Plan Form
    Total Plan Should Be        ${plan.total}

Cenário: Novo plano
    [tags]      new     
    &{plan}     Create Dictionary       title=Plano Semestral      duration=6     price=19,99     total=R$ 119,94

    Remove Plan                 ${plan.title}
    Go To Plans                             # acessando planos
    Go To Form Plan                         # Formulário de Cadastro de PLanos
    New Plan                    ${plan}   # preenchendo form conpleto de planos
    Toaster Text Should Be      Plano cadastrado com sucesso
    [Teardown]                  Thinking And Take Screenshot        2
   

Cenário: Validar Campos obrigatórios
    [tags]      lista

    @{expected_alerts}          Set Variable       Informe o título do plano      Informe a duração do plano em meses       
    @{got_alerts}               Create list

    Go To Plans                 # acessar a página gestão de planos
    Go To Form Plan             # acessar o formulário de cadastros 
    Submit Plan Form            # evento de click

    # Adicionar os textos em uma Lista 
    FOR     ${index}  IN RANGE    1   3
        ${span}             Get Required Alerts     ${index}
        Append To List      ${got_alerts}           ${span}
    END

    Log     ${expected_alerts}  # Lista Esperada
    Log     ${got_alerts}       # Lista obtida

    Lists Should Be Equal       ${expected_alerts}      ${got_alerts}   # Comparando as duas listas, devem estar na mesma POSIÇÃO, ordem natural dos campos

Cenário: Validação dos campos numéricos 
    [tags]                  temp
    [Template]              Check Type Field On Plan Form  
    ${DURATION_FIELD}       number  # verifica se o campo duration é numérico



***Keywords***
## comportamento genérico ## foi feita para implementar um template de teste "Validate Number Type"
## KEYWORD VALIDA O TIPO DE CAMPO 
Check Type Field On Plan Form  # Verificar o TIPO DE CAMPO 
    [Arguments]                     ${element}      ${type}
    Go To Plans                      # acessar a página de gestão de planos
    Go To Form Plan                 # acessar o formulário de cadastros de planos
    Field Should Be Type            ${element}      ${type}    ##verifica se determinado elemento do tipo campo é numérico, email ...
