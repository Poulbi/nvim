FILE = 

$(FILE): $(FILE).cpp
	gcc -Wall -Werror -g $(FILE).cpp -o $(FILE)
