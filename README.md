# Estacionamento Raro
Este projeto foi desenvolvido apenas para Android (infelizmente eu não tenho um Mac).

## Como rodar os testes de integração
Primeiro abra um emulador e depois execute o comando abaixo:

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


#### Contato
Qualquer dúvida podem entrar em contato comigo gabrielbum@gmail.com ou (31) 98249 - 9345


