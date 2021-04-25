***Settings***
Documentation       Suite Buscar de alunos

Resource    ${EXECDIR}/resources/actions/base.robot

## Login com Sessão
##criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
Suite Setup     Start Admin Session  # cria a sessão do navegador e faz o login como administrador 
#                 # keyword base.robot
#                 # pré-condição para Login 

# #Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot


***Test Cases***
Cenário: Busca Exata 

    &{student}      Create Dictionary   name=Steve Jobs  email=jobs@apple.com  age=45  weight=70  feet_tall=1.80

    Remove Student By Name          ${student.name}  ##deleta todos os registro pelo nome especificado no argumento
    Insert Student                  ${student}
    Go To Students
    Search Student By name          ${student.name}
    Student Name Should Be Visible  ${student.name}  ##garanto que steve jobs esta sendo exibido na tela
    Total Items Should Be           1       ##total de itens para esse cenário   
    ## garanto que total de itens é igual a 1, porque so tenho um aluno steve jobs

Cenário: Registro não encontrado 

    ${name}         Set Variable        Barão zemo

    Remove Student By name          ${name}       #Registro não deve estar no ambiente, para qdo for realizar a busca tenha o resultado esperado
    Go To Students
    Search Student By name          ${name}         
    Register Should Not Be found 

Cenário: Busca alunos por um único termo
    [tags]          json
## Usar um único termo para encontrar mais de um registro

# David
# David Guetta
# David Bowie
# David Beckham

    ${fixture}      Get JSON         students.search.json

    ${students}     Set Variable    ${fixture['students']}     ## o valor da lista students é armazenado, guardado na variavel ${students}

    ${word}         Set Variable    ${fixture['word']}

    ${total}         Set Variable    ${fixture['total']}

    Remove Student By Name          ${word} 

 # Aqui só chamei o Array de alunos - ${json_object['students']
    FOR     ${item}     IN      @{students}  ## Acessar  o array de alunos, colocar @ para o robot entender que é uma lista
        #Log To Console      ${item['name']}
        Insert Student      ${item}   ## Nessa etapa o Robot está inserindo os Alunos no Banco de Dados
    END     

        Go To Students   ## Acessa a página de gestão de Alunos
        Search Student By name      ${word}    # Faz a pesquisa 

        #Sleep   10 

        ## Percorre a Lista e verifica se possui os registros da pesquisa
    FOR     ${item}     IN      @{students}  ## Acessar  o array de alunos, colocar @ para o robot entender que é uma lista
        Student Name Should Be Visible     ${item['name']}   ## Nessa etapa o Robot está percorrendo pela lista e verifica se existe o David Guetta, David Bowie e David Beckham
    END 

    Total Items Should Be             ${total}  # existem 3 David 


    

