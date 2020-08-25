# ft_server

CMD build :

```
$ docker build . -t name
```
CMD run :
```
$ docker run -it -p 80:80 -p 443:443 --name="name" name
```

Open another iTerm window:
```
$ docker exec -it name bash
```
ft_server#
```
$ ./index.sh off
```

Check :
| Site | address |
| ------ | ------ |
| Index | https://localhost |
| PhpMyadmin | https://localhost/phpmyadmin |
| Wordpress | https://localhost/wordpress |
