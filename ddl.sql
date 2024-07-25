CREATE TABLE Files (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL UNIQUE,
    mime_type VARCHAR(50) NOT NULL,
    key VARCHAR(255) NOT NULL UNIQUE,
    url TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar_id INTEGER REFERENCES Files(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Persons (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender VARCHAR(10),
    country_id INTEGER REFERENCES Countries(id),
    primary_photo_id INTEGER REFERENCES Files(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PersonPhotos (
    person_id INTEGER REFERENCES Persons(id) ON DELETE CASCADE,
    photo_id INTEGER REFERENCES Files(id) ON DELETE CASCADE,
    PRIMARY KEY (person_id, photo_id)
);

CREATE TABLE Movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    budget NUMERIC(15, 2),
    release_date DATE,
    duration INTEGER,
    director_id INTEGER REFERENCES Persons(id),
    country_id INTEGER REFERENCES Countries(id),
    poster_id INTEGER UNIQUE REFERENCES Files(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE FavoriteMovies (
    user_id INTEGER REFERENCES Users(id) ON DELETE CASCADE,
    movie_id INTEGER REFERENCES Movies(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, movie_id)
);

CREATE TABLE Genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MovieGenres (
    movie_id INTEGER REFERENCES Movies(id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES Genres(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, genre_id)
);

CREATE TABLE Characters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    role VARCHAR(50) CHECK (role IN ('leading', 'supporting', 'background')) NOT NULL,
    movie_id INTEGER REFERENCES Movies(id) ON DELETE CASCADE,
    actor_id INTEGER REFERENCES Persons(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);