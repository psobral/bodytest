***Settings***
Documentation       Suite de Cadastro de alunos

Resource    ${EXECDIR}/resources/actions/base.robot

##criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
Suite Setup     Start Admin Session  # cria a sessão do navegador e faz o login como administrador 
                # keyword base.robot
                # pré-condição para Login 

#Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot


***Test Cases***
Cenário: Novo aluno  ## tudo que representa a funcionalidade criar alunos

    &{student}      Create Dictionary   name=Paula  email=paula@hotmail.com     age=40  weight=57   feet_tall=1.57

    # ${email}        Set Variable        paula@hotmail.com

    Remove Student          ${student.email}  #deleta o email desejado antes de executar todas as instruções 
    Go To Students
    Go To Form Students
        
    ###até aqui foi pré-condição ####

    ### Ações do cenário

    New Student             ${student}
    #Paula   ${email}   35      55      1.50

    ## Validação

    Toaster Text Should Be      Aluno cadastrado com sucesso.
    [Teardown]                  Thinking And Take Screenshot        2 
    # simular a execução do teste congele por 2 seg para que o efeito da animação aconteça 
    # e consiga tirar o print exatamente no momento que o quadradinho é exibido na tela 
    # devido a animação visual (toaster) demorar muito para exibir na tela

Cenário: Não deve permitir email duplicado
    [tags]                      dup
    &{student}                  Create Dictionary   name=João Henrique  email=joao@gmail.com     age=20  weight=70   feet_tall=1.75

    Insert Student              ${student}
    Go To Students
    Go To Form Students    
    New Student                 ${student}
    Toaster Text Should Be      Email já existe no sistema.

    [Teardown]                  Thinking And Take Screenshot        2 


Cenário: Todos os campos devem ser obrigatorios
     ##lista de mensagens de alerta - Define a variável com @ para o robot entender que é do tipo LISTA
    @{expected_alerts}          Set Variable       Nome é obrigatório      O e-mail é obrigatório        idade é obrigatória        o peso é obrigatório        a Altura é obrigatória        
    @{got_alerts}               Create list
## variavel "got_alerts" - alertas obtidos -> A variavel @{got_alerts} sera criada do tipo LISTA VAZIA
## Create List - criar uma lista vazia

    Go To Students              ## acessar a página de gestão de alunos
    Go To Form Students         ## acessar o formulário de cadastros
    Submit Student Form         ## evento de click

    ## Vai percorrer toda a LISTA  -- Esta invocando uma unica vez a KEYWORD "Alert Text Should Be" sera chamado 5x dentro do loop criado no FOR
    # FOR     ${alert}   IN     @{expected_alerts}
    #     Alert Text Should Be    ${alert}

    # END

## ADICIONAR OS TEXTOS NA LISTA EVITA DE O TESTE PARAR QUANDO ENCONTRAR PROBLEMA
    FOR     ${index}          IN RANGE    1   6
        # Log to console      ${index}
        ${span}               Get Required Alerts    ${index}   ##KEYWORD - GET TEXT - obter a informação e retornar a informação, ou seja, o texto do elemento de acordo com uma posição 
        Append To List        ${got_alerts}          ${span}  ## pega o texto pela variavel ${span} e adiciona na LISTA ${got_alerts}
    END

    #imprimir os valores das variáveis abaixo

    Log     ${expected_alerts}  ## LISTA ESPERADA
    Log     ${got_alerts}       ## LISTA OBTIDA

    Lists Should Be Equal    ${expected_alerts}       ${got_alerts}  ##comparando as duas listas, devem estar na mesma POSIÇÃO, ordem natural dos campos

#Valida Tipo Numérico
Cenário: Validação dos campos numéricos  ## Esse cenário vai ser dividido por 3, vai executar 3x - 1x para cada massa de dados # é implementado pelo comportamento "Check Numeric Field On Student Form"
    [tags]                      temp
    ## tem o mesmo comportamento e só muda o output que quero validar
    [Template]                  Check Type Field On Student Form        
    ${AGE_FIELD}                number      #Verifica se o campo idade é numérico ## output
    ${WEIGHT_FIELD}             number      #Verifica se o campo idade é numérico ## output
    ${FEET_TALL}                number      #Verifica se o campo idade é numérico ## output

Cenário: Validar campo do tipo email 
    [tags]                      temp
    [Template]                  Check Type Field On Student Form 
    ${EMAIL_FIELD}              email

Cenário: Menor de 14 anos não pode fazer cadastro

    &{student}      Create Dictionary   name=Livia da Silva  email=livia@yahoo.com     age=13  weight=50   feet_tall=1.65

    Go To Students
    Go To Form Students
    New Student                 ${student}
    Alert Text Should Be        A idade deve ser maior ou igual 14 anos   


***Keywords***
## comportamento genérico ## foi feita para implementar um template de teste "Validate Number Type"
## KEYWORD VALIDA O TIPO DE CAMPO 
Check Type Field On Student Form  ##checa campo numérico no formulário aluno  # Verificar o TIPO DE CAMPO 
    [Arguments]                     ${element}      ${type}
    Go To Students              ## acessar a página de gestão de alunos
    Go To Form Students         ## acessar o formulário de cadastros
    Field Should Be Type          ${element}     ${type}    ##verifica se determinado elemento do tipo campo é numérico, email ...


    
    
    

