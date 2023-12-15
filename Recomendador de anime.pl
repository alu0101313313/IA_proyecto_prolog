% Base de datos de animes y sus características
:- dynamic anime/3.
anime('death note', ['misterio', 'psicologico', 'sobrenatural'], 37).
anime('attack on titan', ['accion', 'fantasia', 'drama'], 25).
anime('one punch man', ['accion', 'comedia', 'superpoderes'], 12).
anime('pokemon', ['infantil', 'fantasia', 'amistad'], 37).
anime('naruto', ['accion', 'fantasia', 'superpoderes'], 1101).
anime('one piece', ['accion', 'aventuras', 'superpoderes'], 12).
anime('dragon ball', ['superpoderes', 'accion', 'juvenil'], 305).
anime('boku no hero', ['escolar', 'superpoderes', 'superheroes'], 145).

% Menu opcion 1: recomendador 
ejecutar_opcion(1) :-
    write('Ingrese una lista de animes que ya hayas visto, separados por comas: '),
    read_line_to_string(user_input, Animes),
    atomic_list_concat(ListaAnimes, ', ', Animes),
    
    write('Ingrese hasta 3 géneros que le interesan, separados por comas: '),
    read_line_to_string(user_input, Generos),
    atomic_list_concat(ListaGeneros, ', ', Generos),
    
    findall(Anime, (anime(Anime, Genero, _), 
                    not(member(Anime, ListaAnimes)),
                    intersect(ListaGeneros, Genero)), Recomendaciones),
    
    % Verificar si hay recomendaciones antes de imprimir
    (Recomendaciones = [] ->
        write('No se encontraron animes que coincidan con los criterios especificados.'), nl
    ; 
        write('Animes recomendados: '), nl,
        imprimir_recomendaciones(Recomendaciones)
    ).


% Menu opcion 2: insertar un nuevo anime a la base de conocimiento
ejecutar_opcion(2) :-
    
  % Menu opcion 2: insertar un nuevo anime a la base de conocimiento
  write('Ingrese el nombre del nuevo anime: '),
  read(Nombre),
    
  write('Ingrese 3 géneros del nuevo anime (separados por comas): '),
  read_line_to_string(user_input, Generos),
  atomic_list_concat(ListaGeneros, ', ', Generos),
    
  write('Ingrese el número de episodios del nuevo anime: '),
  read(Episodios),

  % Agregar el nuevo anime a la base de conocimiento
  assertz(anime(Nombre, ListaGeneros, Episodios)),
  write('Nuevo anime agregado a la base de conocimiento.'), nl.


% Menu opcion 3: insertar un nuevo anime a la base de conocimiento
ejecutar_opcion(3):- !.

% Regla que imprime las recomendaciones tras pasar los filtros de la opcion 1
imprimir_recomendaciones([]).
imprimir_recomendaciones([Recomendacion|Resto]):-
	write('- '), write(Recomendacion), nl,
	imprimir_recomendaciones(Resto).

% Regla que me permite intersectar 2 listas
intersect([], _).
intersect([X|Xs], Y) :- member(X, Y), intersect(Xs, Y).


% Menu Principal del recomendador
recomendador :-
  write('Recomendador de animes:'), nl,
  write('1. Utilizar Recomendador'), nl,
  write('2. Ingresar nuevo anime'), nl,
  write('3. Salir'), nl,
  read(Opcion),
  ejecutar_opcion(Opcion),
  (Opcion == 3 -> true ; recomendador).

% Comando para iniciar el recomendador
% recomendador
