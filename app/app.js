import dotenv from 'dotenv';
dotenv.config();
import express from 'express';

const app = express();
app.use(express.json());

// Rutas (se agregarán en el siguiente commit)

app.get('/', (_req, res) => {
  res.send('API funcionando');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en puerto ${PORT}`);
});
