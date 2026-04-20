CREATE TABLE Embedding_Texto ( 
    id_embedding SERIAL PRIMARY KEY, 
    id_doc INT REFERENCES Documento(id_doc) ON DELETE CASCADE, 
    chunk_id INT NOT NULL, 
    estrategia_chunking VARCHAR(50), 
    vector_embedding vector(384), -- Dimensión estándar para 
all-MiniLM-L6-v2 
    modelo VARCHAR(100) 
); 
 
CREATE TABLE Embedding_Imagen ( 
    id_embedding SERIAL PRIMARY KEY, 
    id_img INT REFERENCES Imagen(id_img) ON DELETE CASCADE, 
    vector_embedding vector(512), -- Dimensión estándar para CLIP 
    modelo VARCHAR(100) 
); 
 
CREATE TABLE Query_Embedding ( 
    id_qemb SERIAL PRIMARY KEY, 
    id_consulta INT UNIQUE REFERENCES Consulta(id_consulta) ON DELETE 
CASCADE, 
    vector_embedding vector(384), 
    modelo VARCHAR(100) 
); 
 
CREATE INDEX ON Embedding_Texto USING hnsw (vector_embedding 
vector_cosine_ops); 
CREATE INDEX ON Embedding_Imagen USING hnsw (vector_embedding 
vector_cosine_ops); 
