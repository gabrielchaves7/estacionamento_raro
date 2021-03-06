# Estacionamento Raro
Este projeto foi desenvolvido apenas para Android (infelizmente eu não tenho um Mac).

## Como rodar os testes de integração
Primeiro, esteja na pasta raiz do projeto (a mesma onde está o folder integration_test), abra um emulador e depois execute o comando abaixo:

**flutter drive   --driver=test_driver/integration_test.dart   --target=integration_test/app_test.dart --flavor dev**

## Como rodar os testes de domain
Para rodar os testes de ui basta entrar no diretório **/packages/domain** e executar o comando **flutter test**.

## Como rodar os testes de UI
Para rodar os testes de ui basta entrar no diretório **/packages/ui** e executar o comando **flutter test**.

## Como rodar o projeto
Como eu utilizei o firebase, fiz a configuração de dois flavors (para poder ter um ambiente de dev e um ambiente de produção). Com isso, o comando para rodar fica um pouco diferente. Iinicie o emulador e utilize algum dos comandos abaixo:

Dev:
**flutter run lib/main.dart --flavor dev**

Prod:
**flutter run lib/main.dart --flavor prod**


## Arquitetura
A ideia foi utilizar o clean architecture como base. Para isto, criei dois pacotes: um de UI e um de Domain.
No pacote de domain estão expostas apenas as use cases e entidades, de modo que a UI não conhece mais nada do domain.

## Continuous Integration e Continuoues Delivery
No repositório do github eu criei uma action simples para poder rodar os testes de ui e domain a cada commit na main. Além disso ela também procura por warnings e
erros de compilação.
Um dos motivos para eu ter usado o firebase foi pensando em utilizar o remote config para implementar features toggles e também o test lab. Porém o tempo não consegui
a tempo.

### Melhorias
1- Criar use cases para filtros (Hoje a lógica para filtrar as vagas e os registros está na UI.);
2- lazy loading (As listas de vagas e registros ainda não estão com lazy loading);
3- Corrigir o teste do registro_card_widget (O teste que verifica se o horario entrada e o horario de saida do card de registro está sendo exibido coretamente não funciona quando executado no pipeline devido ao timezone ser diferente)
4- Melhorar transições de estados (As transições de estados estão muito fortes, sem animações de fade in por exemplo)
5- Utilizar o analytics do firebase que já está instalado para mapear mais eventos;
6- Configurar o app check do firebase em prod;


#### Contato
Qualquer dúvida podem entrar em contato comigo gabrielbum@gmail.com ou (31) 98249 - 9345


