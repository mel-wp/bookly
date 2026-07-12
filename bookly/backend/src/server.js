const express = require('express');
const cors = require('cors');
require('dotenv').config();
const path = require("path");
const uploadRoutes = require("./routes/upload.routes");

const usersRoutes = require('./routes/users.routes');
const friendsRoutes = require('./routes/friends.routes');
const booksRoutes = require('./routes/books.routes');
const loansRoutes = require('./routes/loans.routes');

const app = express();

app.use(cors());
app.use(express.json());
app.use("/uploads", express.static(path.resolve("uploads")));


app.get('/', (req, res) => {
  return res.json({
    message: 'Backend oficial do Bookly rodando com sucesso!',
  });
});

app.use('/users', usersRoutes);
app.use('/friends', friendsRoutes);
app.use('/books', booksRoutes);
app.use('/loans', loansRoutes);
app.use("/upload", uploadRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor Bookly rodando na porta ${PORT}`);
});