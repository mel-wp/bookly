const bcrypt = require('bcryptjs');
const prisma = require('../prisma');

async function createUser(req, res) {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({
        message: 'Nome, e-mail e senha são obrigatórios.',
      });
    }

    const userAlreadyExists = await prisma.user.findUnique({
      where: { email },
    });

    if (userAlreadyExists) {
      return res.status(409).json({
        message: 'Já existe um usuário cadastrado com este e-mail.',
      });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await prisma.user.create({
      data: {
        name,
        email,
        password: hashedPassword,
      },
      select: {
        id: true,
        name: true,
        email: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    return res.status(201).json(user);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao criar usuário.',
    });
  }
}

async function listUsers(req, res) {
  try {
    const users = await prisma.user.findMany({
      orderBy: {
        createdAt: 'desc',
      },
      select: {
        id: true,
        name: true,
        email: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    return res.json(users);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao listar usuários.',
    });
  }
}

async function getUserById(req, res) {
  try {
    const { id } = req.params;

    const user = await prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        name: true,
        email: true,
        createdAt: true,
        updatedAt: true,
        friends: true,
        books: true,
        loans: {
          include: {
            friend: true,
            book: true,
          },
        },
      },
    });

    if (!user) {
      return res.status(404).json({
        message: 'Usuário não encontrado.',
      });
    }

    return res.json(user);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao buscar usuário.',
    });
  }
}

async function updateUser(req, res) {
  try {
    const { id } = req.params;
    const { name, email, password } = req.body;

    const userExists = await prisma.user.findUnique({
      where: { id },
    });

    if (!userExists) {
      return res.status(404).json({
        message: 'Usuário não encontrado.',
      });
    }

    const data = {};

    if (name) data.name = name;
    if (email) data.email = email;
    if (password) data.password = await bcrypt.hash(password, 10);

    const user = await prisma.user.update({
      where: { id },
      data,
      select: {
        id: true,
        name: true,
        email: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    return res.json(user);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao atualizar usuário.',
    });
  }
}

async function deleteUser(req, res) {
  try {
    const { id } = req.params;

    const userExists = await prisma.user.findUnique({
      where: { id },
    });

    if (!userExists) {
      return res.status(404).json({
        message: 'Usuário não encontrado.',
      });
    }

    await prisma.user.delete({
      where: { id },
    });

    return res.json({
      message: 'Usuário removido com sucesso.',
    });
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao remover usuário.',
    });
  }
}

module.exports = {
  createUser,
  listUsers,
  getUserById,
  updateUser,
  deleteUser,
};