***Settings***
Documentation       Suite Gestão de Matriculas

Resource    ${EXECDIR}/resources/actions/base.robot

# criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
Suite Setup     Start Admin Session  # cria a sessão do navegador e faz o login como administrador 
                # keyword base.robot
                # pré-condição para Login 

#Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot


***Test Cases***
Cenário: Deve exibir data inicial e final conforme o plano escolhido

    ${fixture}      Get JSON   enroll-dates.json   # Vai receber os dados do arquivo json

    ${john}         Set Variable        ${fixture['student']}   # entidade = student
    ${black}        Set Variable        ${fixture['plan']}      # entidade = plan

    Insert Student              ${john}     #  deleta e insere estudante 
    Insert Plan                 ${black}    #  deleta e insere planos
    
    Go To Enrolls
    Go To Form Enrolls

    Select Students             ${john['name']}
    Select Plan                 ${black['title']}
    Start Data Should Today
    End Date Should Be          ${fixture['days']}

    
    

    #Sleep           10
    # clique na div que o id contem(*) o option e que tem o texto John Connor 

    # Sleep           5  # espera 5 seg na lista que não consigo inspecionar
    # ${code}         Get Page Source    # Guarda o codigo html da pagina na variavel code para inspecionar o elemento
    # Log             ${code}  # e vai logar no relatorio de teste automatizado

    # # Get Page Source - Papito usa mais para mobile


Cenário 2: Deve matricular um aluno em um plano


    ${fixture}      Get JSON   enroll-create.json   # Vai receber os dados do arquivo json

    ${sara}         Set Variable        ${fixture['student']}   # entidade = student
    ${fit}          Set Variable        ${fixture['plan']}      # entidade = plan

    Insert Student              ${sara}     #  deleta e insere estudante 
    Insert Plan                 ${fit}    #  deleta e insere planos
    Go To Enrolls
    Go To Form Enrolls
    Select Students             ${sara['name']}  ## seleciona o aluno
    Select Plan                 ${fit['title']}  ## seleciona o plano 
    Submit Enrolls Form                          ## vai clicar no botão salvar para matricular o aluno
    Toaster Text Should Be      Matrícula cadastrada com sucesso 

    [teardown]                  Thinking And Take Screenshot        5  ##passando timeout de 5 seg


