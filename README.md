# DELCON - Sistema de Gestão de Entregas

**Descrição e Desenvolvedores**

Este é um projeto integrado desenvolvido para o módulo de Inteligencia Artificial do curso de Análise e Desenvolvimento de sistemas e Gestão de Tecnologia da informação para a UNIFEOB.

Feito por:
Rita de Cássia Del Giudice Conceição - 24000469

Aplicativo desenvolvido em **Flutter** utilizando o Visual Studio Code, com o objetivo de gerenciar entregas de uma transportadora, permitindo o cadastro, acompanhamento e controle de pedidos de forma simples e eficiente.


## Descrição

O sistema possibilita registrar informações de entregas, incluindo dados do cliente, endereço, observações e prazos. Além disso, oferece controle visual de status das entregas, facilitando a organização e o acompanhamento das operações logísticas.


## Funcionalidades

* Cadastro de entregas com:

* Nome do cliente/destino
* Endereço completo
* Observações da carga
* Seleção de data de entrega
* Registro automático da data de inclusão
* Marcação de entrega como concluída
* Abertura do endereço diretamente no Google Maps

* Indicadores visuais de status:

* Entregas atrasadas
* Entregas próximas do prazo
* Entregas concluídas
* Interface em português (Brasil)


## Tecnologias Utilizadas

* Flutter
* Dart
* Material Design


## Requisitos

* Flutter SDK instalado
* Navegador (para execução em Flutter Web) ou dispositivo compatível


## Como Executar

1. Clone este repositório
2. Abra a pasta pelo Visual Studio Code
3. Entre na pasta "lib\main.dart
4. Abra um novo terminal
5. Execulte o comando "flutter run"


## Estrutura do Projeto

* `main.dart`: arquivo principal da aplicação
* `RegistroEntrega`: classe responsável pelo modelo de dados das entregas
* Interface construída com `StatefulWidget` para controle dinâmico do estado


## Possíveis Melhorias

* Persistência de dados com SQLite ou Firebase
* Implementação de autenticação de usuários
* Dashboard com métricas e relatórios
* Inclusão de horário de entrega
* Sistema de notificações


## Objetivo do Projeto

Este projeto foi desenvolvido com fins acadêmicos, com foco na prática de desenvolvimento mobile utilizando Flutter e na simulação de um sistema real de apoio logístico. O objetivo do app em si é facilitar a organização de uma pequena empresa de logística.
