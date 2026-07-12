const prisma = require('../prisma');

async function createBook(req, res) {
  try {
    const {
      title,
      author,
      publisher,
      category,
      description,
      coverUrl,
      userId,
    } = req.body;

    if (!title || !author || !userId) {
      return res.status(400).json({
        message: 'Título, autor e userId são obrigatórios.',
      });
    }

    const userExists = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!userExists) {
      return res.status(404).json({
        message: 'Usuário não encontrado.',
      });
    }

    const book = await prisma.book.create({
      data: {
        title,
        author,
        publisher,
        category,
        description,
        coverUrl,
        userId,
      },
    });

    return res.status(201).json(book);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao criar livro.',
    });
  }
}

async function listBooks(req, res) {
  try {
    const { userId, available } = req.query;

    const where = {};

    if (userId) {
      where.userId = userId;
    }

    if (available === 'true') {
      where.available = true;
    }

    if (available === 'false') {
      where.available = false;
    }

    const books = await prisma.book.findMany({
      where,
      orderBy: {
        title: 'asc',
      },
      include: {
        loans: {
          include: {
            friend: true,
          },
        },
      },
    });

    return res.json(books);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao listar livros.',
    });
  }
}

async function getBookById(req, res) {
  try {
    const { id } = req.params;

    const book = await prisma.book.findUnique({
      where: { id },
      include: {
        loans: {
          include: {
            friend: true,
          },
        },
      },
    });

    if (!book) {
      return res.status(404).json({
        message: 'Livro não encontrado.',
      });
    }

    return res.json(book);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao buscar livro.',
    });
  }
}

async function updateBook(req, res) {
  try {
    const { id } = req.params;

    const {
      title,
      author,
      publisher,
      category,
      description,
      coverUrl,
      available,
    } = req.body;

    const bookExists = await prisma.book.findUnique({
      where: { id },
    });

    if (!bookExists) {
      return res.status(404).json({
        message: 'Livro não encontrado.',
      });
    }

    const book = await prisma.book.update({
      where: { id },
      data: {
        title,
        author,
        publisher,
        category,
        description,
        coverUrl,
        available,
      },
    });

    return res.json(book);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao atualizar livro.',
    });
  }
}

async function deleteBook(req, res) {
  try {
    const { id } = req.params;

    const bookExists = await prisma.book.findUnique({
      where: { id },
    });

    if (!bookExists) {
      return res.status(404).json({
        message: 'Livro não encontrado.',
      });
    }

    await prisma.book.delete({
      where: { id },
    });

    return res.json({
      message: 'Livro removido com sucesso.',
    });
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao remover livro.',
    });
  }
}

module.exports = {
  createBook,
  listBooks,
  getBookById,
  updateBook,
  deleteBook,
};