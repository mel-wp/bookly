const prisma = require('../prisma');

async function createFriend(req, res) {
  try {
    const { name, email, phone, notes, userId } = req.body;

    if (!name || !userId) {
      return res.status(400).json({
        message: 'Nome e userId são obrigatórios.',
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

    const friend = await prisma.friend.create({
      data: {
        name,
        email,
        phone,
        notes,
        userId,
      },
    });

    return res.status(201).json(friend);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao criar amigo.',
    });
  }
}

async function listFriends(req, res) {
  try {
    const { userId } = req.query;

    const friends = await prisma.friend.findMany({
      where: userId ? { userId } : undefined,
      orderBy: {
        name: 'asc',
      },
      include: {
        loans: {
          include: {
            book: true,
          },
        },
      },
    });

    return res.json(friends);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao listar amigos.',
    });
  }
}

async function getFriendById(req, res) {
  try {
    const { id } = req.params;

    const friend = await prisma.friend.findUnique({
      where: { id },
      include: {
        loans: {
          include: {
            book: true,
          },
        },
      },
    });

    if (!friend) {
      return res.status(404).json({
        message: 'Amigo não encontrado.',
      });
    }

    return res.json(friend);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao buscar amigo.',
    });
  }
}

async function updateFriend(req, res) {
  try {
    const { id } = req.params;
    const { name, email, phone, notes } = req.body;

    const friendExists = await prisma.friend.findUnique({
      where: { id },
    });

    if (!friendExists) {
      return res.status(404).json({
        message: 'Amigo não encontrado.',
      });
    }

    const friend = await prisma.friend.update({
      where: { id },
      data: {
        name,
        email,
        phone,
        notes,
      },
    });

    return res.json(friend);
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao atualizar amigo.',
    });
  }
}

async function deleteFriend(req, res) {
  try {
    const { id } = req.params;

    const friendExists = await prisma.friend.findUnique({
      where: { id },
    });

    if (!friendExists) {
      return res.status(404).json({
        message: 'Amigo não encontrado.',
      });
    }

    await prisma.friend.delete({
      where: { id },
    });

    return res.json({
      message: 'Amigo removido com sucesso.',
    });
  } catch (error) {
    console.error(error);

    return res.status(500).json({
      message: 'Erro ao remover amigo.',
    });
  }
}

module.exports = {
  createFriend,
  listFriends,
  getFriendById,
  updateFriend,
  deleteFriend,
};