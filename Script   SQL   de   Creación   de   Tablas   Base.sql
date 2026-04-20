
CREATE EXTENSION IF NOT EXISTS vector;


CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    rol VARCHAR(50)
);


CREATE TABLE Documento (
    id_doc SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    idioma VARCHAR(20),
    fecha DATE,
    fuente VARCHAR(255),
    contenido_texto TEXT NOT NULL
);


CREATE TABLE Imagen (
    id_img SERIAL PRIMARY KEY,
    id_doc INT REFERENCES Documento(id_doc) ON DELETE CASCADE,
    ruta_archivo VARCHAR(500) NOT NULL,
    descripcion TEXT,
    etiquetas VARCHAR(255)
);


CREATE TABLE Consulta (
    id_consulta SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuario(id_usuario) ON DELETE SET NULL,
    texto_pregunta TEXT NOT NULL,
    fecha TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Resultado (
    id_resultado SERIAL PRIMARY KEY,
    id_consulta INT REFERENCES Consulta(id_consulta) ON DELETE CASCADE,
    score_similitud FLOAT
);


CREATE TABLE Resultado_Documento (
    id_resultado INT REFERENCES Resultado(id_resultado) ON DELETE CASCADE,
    id_doc INT REFERENCES Documento(id_doc) ON DELETE CASCADE,
    PRIMARY KEY (id_resultado, id_doc)
);

CREATE TABLE Resultado_Imagen (
    id_resultado INT REFERENCES Resultado(id_resultado) ON DELETE CASCADE,
    id_img INT REFERENCES Imagen(id_img) ON DELETE CASCADE,
    PRIMARY KEY (id_resultado, id_img)
);


CREATE TABLE Evaluacion (
    id_eval SERIAL PRIMARY KEY,
    id_consulta INT UNIQUE REFERENCES Consulta(id_consulta) ON DELETE CASCADE,
    faithfulness FLOAT,
    answer_relevancy FLOAT,
    context_recall FLOAT,
    modelo_eval VARCHAR(100),
    fecha TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
