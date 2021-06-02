# README

- Backend - Projeto prontuário do Busão

## Requisitos
```
Ruby 3.0.1
Rails 6.1.3.2
```
# Gem ApiPack

- A gem ApiPack é uma gem criada por um dos contribuidores deste projeto e seu código estar disponibilizado neste [Link](https://github.com/Jllima/api_pack)
- Esta gem foi utilizada para as seguintes fucionalidades;
- Autenticação utilizando JWT
- Meta generator para links de paginação
- Tratamentos de erros: 404, 500, 422 e 406

 Executar projeto em modo DEV usando o DOCKER
- Execute as permissões nos scripts
```
chmod +x docker/dev-entrypoint
chmod +x docker/test-entrypoint
``` 
- Excute o script up_dev na raiz do projeto
```
sh up_dev.sh 
```
- Verifique se todos os serviços foram iniciados
```
docker-compose logs -f -t 
```

- Visite o endereço
```
http://localhost:3003 

