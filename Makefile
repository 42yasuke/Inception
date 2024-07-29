# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jralph <jralph@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 14:43:04 by jralph            #+#    #+#              #
#    Updated: 2024/07/29 15:08:31 by jralph           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	mkdir -p /home/jralph/data/mariadb
	mkdir -p /home/jralph/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up --build -d

down:
	docker compose -f ./srcs/docker-compose.yml down

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

check:
	docker ps
	docker volume ls
	docker images

clean:
	docker stop wordpress mariadb nginx
	docker rm wordpress mariadb nginx

fclean: clean
	docker rmi wordpress mariadb nginx
	@sudo rm -rf /home/jralph/data/mariadb /home/jralph/data/wordpress
	@docker system prune -af

re:	fclean all