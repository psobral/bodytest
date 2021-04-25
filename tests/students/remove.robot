***Settings***
Documentation       Suite Remover alunos

Resource    ${EXECDIR}/resources/actions/base.robot

##criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
#Suite Setup     Start Admin Session  # cria a sessão do navegador e faz o login como administrador 
                # keyword base.robot
                # pré-condição para Login 
Test Setup      Start Admin Session   ## cria uma sessão por teste, por cenário

#Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot


***Test Cases***
Cenário: Remover aluno cadastrado 

    &{student}      Create Dictionary   name=Robert Pattinson  email=batman@dc.com     age=27  weight=70   feet_tall=1.80

    Insert Student              ${student}
    Go To Students
    Search Student By name      ${student.name}    ##step que faz a busca para identificar o alvo da remoção
    #Sleep               5
    Request Removal by Email    ${student.email}   ##pega o email inserido
    Confirm Removal 
    Toaster Text Should Be      Aluno removido com sucesso.
    Student Should Not Visible  ${student.email}  ## VALIDA SE O USUARIO REMOVIDO SUMIU DA PAGINA

    [Teardown]                  Thinking And Take Screenshot        2  ##so qdo tem toaster


Cenário: Desistir da exclusão

    &{student}      Create Dictionary   name=Robert Downey Jr  email=iroman@marvel.com   age=27  weight=70   feet_tall=1.80

    Insert Student              ${student}
    Go To Students
#    Reload          ## força o refresh na pagina
    Search Student By name      ${student.name}
    #Sleep           5
    Request Removal by Email    ${student.email}   ##pega o email inserido
    Cancel Removal
    Student Should Be Visible   ${student.email}   ## valida se o usuario continua na pagina

