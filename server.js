const express = require('express');
const { createPool } = require('mysql2');
const path = require('path');

const app = express();
app.use(express.json());

// Configuração do pool de conexões
const pool = createPool({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'salacontrole', // Nome correto da base de dados
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Função para executar consultas SQL
const executeQuery = (query, params) => {
  return new Promise((resolve, reject) => {
    pool.query(query, params, (error, results) => {
      if (error) {
        console.error('Database query error:', error);
        return reject(error);
      }
      resolve(results);
    });
  });
};

// Rota para servir o arquivo HTML
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Rota para adicionar uma nova matéria
app.post('/materia', async (req, res) => {
  const { nomeMateria } = req.body;
  try {
    await executeQuery('CALL AddMateria(?)', [nomeMateria]);
    res.status(201).send({ message: 'Matéria adicionada com sucesso' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

// Rota para adicionar um novo responsável
app.post('/responsavel', async (req, res) => {
  const { nomeResponsavel } = req.body;
  try {
    await executeQuery('CALL AddResponsavel(?)', [nomeResponsavel]);
    res.status(201).send({ message: 'Responsável adicionado com sucesso' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

// Rota para adicionar uma nova sala

app.post('/sala', async (req, res) => {
  const { nomeSala, capacidade, tipo } = req.body;
  try {
    await executeQuery('CALL AddSala(?, ?, ?)', [nomeSala, capacidade, tipo]);
    res.status(201).send({ message: 'Sala adicionada com sucesso' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

// Rota para obter todas as matérias
app.get('/materias', async (req, res) => {
  try {
    const results = await executeQuery('CALL GetMaterias()');
    res.status(200).send(results[0]);
  } catch (error) {
    console.error('Error fetching materias:', error);
    res.status(500).send({ error: error.message });
  }
});

// Rota para obter todos os responsáveis
app.get('/responsaveis', async (req, res) => {
  try {
    const results = await executeQuery('CALL GetResponsaveis()');
    res.status(200).send(results[0]);
  } catch (error) {
    console.error('Error fetching responsaveis:', error);
    res.status(500).send({ error: error.message });
  }
});

// Rota para obter todos as salas

app.get('/salas', async (req, res) => {
  try {
    const results = await executeQuery('CALL GetSalas()');
    res.status(200).send(results[0]);
  } catch (error) {
    console.error('Error fetching salas:', error);
    res.status(500).send({ error: error.message });
  }
});


// Rota para remover uma matéria

app.post('/removerMateria', async (req, res) => {
  const { idMateria } = req.body;
  try {
    await executeQuery('CALL RemoveMateria(?)', [idMateria]);
    res.status(200).send({ message:  `Matéria com ID ${idMateria} removida com sucesso` });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});


// Rota para remover um responsável

app.post('/removerResponsavel', async (req, res) => {
  const { idResponsavel } = req.body;
  try {
    await executeQuery('CALL RemoveResponsavel(?)', [idResponsavel]);
    res.status(200).send({ message: `Responsável com ID ${idResponsavel} removido com sucesso` });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});


// Rota para remover uma sala

app.post('/removerSala', async (req, res) => {
  const { idSala } = req.body;
  try {
    await executeQuery('CALL RemoveSala(?)', [idSala]);
    res.status(200).send({ message: `Sala com ID ${idSala} removida com sucesso` });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

// Rota para adicionar uma nova aula
app.post('/aula', async (req, res) => {
  const {idSala, data, turno, idResponsavel, idMateria} = req.body;
  try {
    await executeQuery('CALL AddAula(?, ?, ?, ?, ?)', [idSala, data, turno, idResponsavel, idMateria]);
    res.status(201).send({ message: 'Aula adicionada com sucesso' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

// Rota para remover uma aula
app.post('/removerAula', async (req, res) => {
  const { idAula } = req.body;
  try {
    await executeQuery('CALL RemoveAula(?)', [idAula]);
    res.status(200).send({ message: 'Aula removida com sucesso' });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

// Rota para obter todas as aulas
app.get('/aulas', async (req, res) => {
  try {
    const results = await executeQuery('CALL GetAulas()');
    res.status(200).send(results[0]);
  } catch (error) {
    console.error('Error fetching aulas:', error);
    res.status(500).send({ error: error.message });
  }
});


// Inicia o servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
