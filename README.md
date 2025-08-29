# Testes da API restful-booker utilizando Robot Framework
Este repositório registra o estudo e projeto inicial de testes automatizados da API restful-booker, uma API desenvolvida para fins de estudo e testes que simula o gerenciamento de reservas, utilizando Robot Framework.

Para executar os testes, basta rodar os seguintes comandos:

- Para os testes de autenticação:

  ``robot -d ./results/results_login ./tests/login_tests.robot``

- Para os testes de reserva:

  ``robot -d ./results/results_booking ./tests/booking_tests.robot``

Se desejar apenas acessar os resultados, basta acessar a pasta /results.
