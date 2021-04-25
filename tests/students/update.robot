***Settings***
Documentation       Suite Atualizar alunos

Resource    ${EXECDIR}/resources/actions/base.robot

##criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
Suite Setup     Start Admin Session  # cria a sessão do navegador e faz o login como administrador 
                # keyword base.robot
                # pré-condição para Login 

#Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot


***Test Cases***
Cenário: Atualizar um aluno já cadastrado
    
    ${fixture}     Get JSON    students.update.json

    ${kamalakhan}   Set Variable    ${fixture['before']}  # chama o campo before do arquivo 'students.update.json'
    ${msmarvel}     Set Variable    ${fixture['after']}   # chama o campo after do arquivo 'students.update.json'
    # Antes : Massa de Testes que vou inserir para que eu tenha um aluno já cadastrado 
    # Depois: Massa de Testes que eu possa fazer a atualização
    
    Remove Student By Name      ${kamalakhan['name']}     ## vai apagar qualquer registro no banco com o texto kamalakhan
    Remove Student By Name      ${msmarvel['name']}     ## vai apagar qualquer registro no banco com o texto msmarvel
    
    Insert Student             ${kamalakhan} 
    Go To Students
    Search Student By Name      ${kamalakhan['name']}  
    Go To Student Update Form   ${kamalakhan['email']}  # clica em Editar, buscando o email como referência do cadastro 

    # Atualizar o cadastro com os dados da MsMarvel
    Update A Student            ${msmarvel}
    Toaster Text Should Be      Aluno atualizado com sucesso.

    [Teardown]                  Thinking And Take Screenshot        2

    



