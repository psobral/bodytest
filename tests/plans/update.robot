***Settings***
Documentation       Suite Atualizar planos

Resource    ${EXECDIR}/resources/actions/base.robot

# criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
Suite Setup     Start Admin Session  # cria a sessão do navegador e faz o login como administrador 
                # keyword base.robot
                # pré-condição para Login 

#Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot


***Test Cases***
Cenário: Atualizar um plano já cadastrado

    ${fixture}      Get JSON   plans.update.json

    ${completo}       Set Variable    ${fixture['before']}
    ${individual}     Set Variable    ${fixture['after']}

    Remove Plan                     ${completo['title']}    ## vai apagar qualquer registro no banco com o texto Plano Completo
    Remove Plan                     ${individual['title']}  ## vai apagar qualquer registro no banco com o texto Plano Individual 

    #Log To Console                   ${individual}
    Insert Plan                     ${completo}
    Go To Plans
    Search Plan By Title            ${completo['title']}
    Go To Plan Update Form          ${completo['title']}   ## clica em editar pelo title
            

     # Atualizar o cadastro com os dados da Plano individual 
    Update A Plan                   ${individual} 
    Toaster Text Should Be         Plano Atualizado com sucesso 

    [Teardown]                    Thinking And Take Screenshot        2



    